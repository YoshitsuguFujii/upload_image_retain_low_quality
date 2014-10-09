require "upload_image_retain_low_quality/version"
require 'upload_image_retain_low_quality'
require 'upload_image_retain_low_quality/console'
require 'upload_image_retain_low_quality/image'
require 'upload_image_retain_low_quality/s3'

require "aws-sdk"
require "mini_magick"
require 'optparse'
require "yaml"
require 'parallel'

module UploadImageRetainLowQuality

  class CLI
    def self.run(params)
      # bucketの選択
      s3 = S3.new
      all_buckets = Console.show_item_with_pointer(s3.buckets)
      idx = Console.gets_from_stdin("select number your bucket")
      s3.bucket = all_buckets[idx]

      # ディレクトリの選択
      while !s3.directories.empty? && !Console.get_y_or_n_from_stdin("update here?")
        directories = Console.show_item_with_pointer(s3.directories)
        idx = Console.gets_from_stdin("select number upload folder")
        s3.cd(directories[idx])
      end

      image_upload_proc = ->(image){
        if image && image.valid_ext?
          quality_down_file = image.quality_down(params["quality"])
          s3.upload_file(image.file, s3.current_path)
          if params["delete"]
            image.destroy!
          else
            image.backup!
          end
        end
      }

      if File::ftype(params["file_or_dir"]) == "directory"
        images = Dir::entries(params["file_or_dir"]).map{|file| Image.new(file)}.select(&:valid_ext?)
      else
        images = [Image.new(params["file_or_dir"])]
      end

      idx = 0
      Parallel.each(images, in_threads: Parallel.processor_count) do |file|
        idx += 1
        Console.progress_bar(idx, images.size)
        image_upload_proc.call(file)
      end
    end
  end
end
