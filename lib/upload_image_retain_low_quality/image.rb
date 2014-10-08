module UploadImageRetainLowQuality
  class Image
    # 対象の拡張子
    TARGET_EXT = %w(.jpg .jpeg .gif .png)
    ORIGINAL_IMAGE_DIR = "original_image/"

    def initialize(file)
      return nil unless FileTest.file?(file)
      @file = file
      @ext = File.extname(file)
      @base_name = File.basename(file, @ext)
    end

    def valid_ext?
      TARGET_EXT.include?(@ext)
    end

    def file
      @file
    end

    def quality_down(quality)
      #p "#{@file} change quality #{quality}"
      down_filename = "#{@base_name}_#{quality}#{@ext}"

      image = MiniMagick::Image.open(@file)
      image.format(@ext[1..-1])
      image.quality(quality)
      image.write(down_filename)

      return down_filename
    end

    def backup!
      FileUtils.mkdir_p(ORIGINAL_IMAGE_DIR) unless File.exists?(ORIGINAL_IMAGE_DIR)
      FileUtils.move(@file, ORIGINAL_IMAGE_DIR + @file)
    end

    def destroy!
      File.delete(@file)
    end
  end
end

