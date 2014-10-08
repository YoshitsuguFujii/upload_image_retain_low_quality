module UploadImageRetainLowQuality
  class S3
    CONFIG_FILE = ".upload_image_retain_low_qualityrc"

    def initialize
      file =  if FileTest.file?(CONFIG_FILE)
                CONFIG_FILE
              else
                [Dir.home, CONFIG_FILE].join("/")
              end

      raise "no aws config file" unless FileTest.file?(file)
      @s3 = ::AWS::S3.new(YAML.load_file(file))
    end

    def buckets
      @s3.buckets
    end

    def bucket=(bucket)
      @bucket = bucket
    end

    def directories
      directories = @bucket.as_tree({prefix: current_path}).children.select(&:branch?).collect(&:prefix)
      directories.map{|dir| dir.split("/").last}
    end

    def current_path
      @prefix
    end

    def cd(prefix)
      @prefix = [@prefix, prefix].compact.join("/")
    end

    def upload_file(file, to_path, opts = {})
      raise "set bucket at first"  unless @bucket
      to_path = [to_path, file].compact.join("/")
      acl = opts[:acl] || :private

      #p puts "#{file} to #{to_path}"
      obj = @bucket.objects[to_path] || @bucket.create(to_path)
      obj.write(File.open(file), { :acl => acl })
    end

    # Class Methods
    class << self
      def generate_config
        if FileTest.file?(CONFIG_FILE)
          Console.print_red "#{CONFIG_FILE} is already exists"
        else

config = <<"CONFIG"
access_key_id: 'YOUR ACCESS KEY'
secret_access_key:  'SECRET ACCESS KEY'
CONFIG

          f = File.new(CONFIG_FILE, "w")
          f << config
          f.close
          Console.print_green "#{CONFIG_FILE} was created"
        end
      end
    end # Class Methods End
  end
end
