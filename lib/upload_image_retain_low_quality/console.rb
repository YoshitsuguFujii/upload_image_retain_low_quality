module UploadImageRetainLowQuality
  class Console
    # Class Methods
    class << self
      def gets_from_stdin(message = nil)
        print "#{message}: " unless message.nil?
        str = STDIN.gets.chomp
      end

      def get_y_or_n_from_stdin(message)
        bol = ""
        while !%w(Y N).include?(bol.upcase)
          bol = gets_from_stdin("#{message}(y/n)")
        end
        bol.upcase == "Y"
      end

      def show_item_with_pointer(iterator, console_print = true)
        rtn_hash = {}
        iterator.each_with_index do |value, idx|
          rtn_hash[idx.to_s] = value
          if console_print
            if value.is_a?(AWS::S3::Bucket)
              p "[" + (idx).to_s + "] " + value.name.to_s
            else
              p "[" + (idx).to_s + "] " + value
            end
          end
        end

        rtn_hash
      end

      def progress_bar(i, max = 100)
        i = i.to_f
        max = max.to_f
        i = max if i > max
        percent = i / max * 100.0
        rest_size = 1 + 5 + 1 # space + progress_num + %
        bar_size = 79 - rest_size # (width - 1) - rest_size
        bar_str = '%-*s' % [bar_size, ('#' * (percent * bar_size / 100).to_i)]
        progress_num = '%3.1f' % percent
        print "\r#{bar_str} #{'%5s' % progress_num}%"
      end

      def print_green(str)
        puts "\e[32m#{str}\e[0m"
      end

      def print_red(str)
        puts "\e[31m#{str}\e[0m"
      end
    end # Class Methods End
  end
end
