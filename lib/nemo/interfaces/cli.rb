require 'optparse'
require_relative '../application/create_project_use_case'
require_relative '../application/create_viper_scene_use_case'
require_relative '../application/show_info_use_case'
require_relative '../utilities/string_extensions.rb'

module Nemo
    module Interfaces
        class CLI

            def initialize(base_path)
                @base_path = base_path
            end

            def run(argv)
                options = {}
                opt_parser = OptionParser.new do |opts|
                    opts.banner = "Usage: nemo [options]"

                    opts.on("-c PROJECT_NAME", "--create PROJECT_NAME", "Create a new iOS project") do |name|
                        options[:command] = :create
                        options[:project_name] = name
                    end

                    opts.on("-s", "--scene SCENE_NAME", "Create a new VIPER scene") do |scene_name|
                        options[:command] = :scene
                        options[:scene_name] = scene_name
                    end

                    opts.on("-v", "--version", "Show script version") do
                        options[:command] = :info
                    end
                end.parse!(argv)

                
                case options[:command]
                when :create
                    if options[:project_name]
                        Nemo::Application::CreateProjectUseCase.new(@base_path, options[:project_name]).execute
                    else
                        puts "Error: Project name is required for the 'create' command.".colorize(:red).style(:bold)
                    end
                when :scene
                    if options[:scene_name]
                        Nemo::Application::CreateViperSceneUseCase.new(options[:scene_name]).execute
                    else
                        puts "Error: Scene name is required for the 'viper' command.".colorize(:red).style(:bold)
                    end
                when :info
                    Nemo::Application::ShowInfoUseCase.new.execute
                else
                    Nemo::Application::ShowInfoUseCase.new.execute
                end
            end
        end
    end
end