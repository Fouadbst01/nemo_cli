require 'fileutils'

module Nemo
  module Infrastructure
    class FileHandler

        def create_directory(full_path)
            FileUtils.mkdir_p(full_path) unless Dir.exist?(full_path)
        end

        def create_file(full_path, content = '')
            File.write(full_path, content)
        end

        def delete_file(full_path)
            File.delete(full_path) if File.exist?(full_path)
        end

        def delete_directory(directory_name)
            path = File.join(@base_path, directory_name)
            FileUtils.rm_rf(path) if Dir.exist?(path)
        end

        def copy_content_to_directory(content, destination)
            FileUtils.cp_r(Dir.glob("#{content}/*"), destination)
        end

    end
  end
end