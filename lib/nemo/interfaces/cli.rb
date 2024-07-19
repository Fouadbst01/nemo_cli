require 'optparse'
require 'colorize'
require_relative '../application/create_project'
# require_relative '../application/create_viper_scene'
require_relative '../application/show_info'

module Nemo
    module Interfaces
        class CLI
            def self.run
                options = {}
                opt_parser = OptionParser.new do |opts|
                    opts.banner = "Usage: nemo [options]"

                    opts.on("-c", "--create PROJECT_NAME", "Create a new iOS project") do |name|
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
                end
                
                case options[:command]
                when :create
                    if options[:scene_name]
                        Nemo::Application::CreateViperScene.new(options[:scene_name]).execute
                    else
                        puts "Error: Project name is required for the 'create' command.".colorize(:color => :red, :mode => :bold)
                    end
                when :scene
                    if options[:scene_name]
                        #Nemo::Application::CreateViperScene.new(options[:scene_name]).execute
                    else
                        puts "Error: Scene name is required for the 'viper' command.".colorize(:color => :red, :mode => :bold)
                    end
                when :info
                    Nemo::Application::ShowInfo.new.execute
                else
                    puts "Error: Unknown command.".colorize(:color => :red, :mode => :bold)
                    Nemo::Application::ShowInfo.new.execute
                end
            end
        end
    end
end