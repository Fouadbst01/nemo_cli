require_relative '../utilities/string_extensions.rb'

module Nemo
    module Application
        class ShowInfo
            def execute
                puts <<~ASCII_ART.colorize(:cyan)

                ███    ██ ███████ ███    ███  ██████  
                ████   ██ ██      ████  ████ ██    ██ 
                ██ ██  ██ █████   ██ ████ ██ ██    ██ 
                ██  ██ ██ ██      ██  ██  ██ ██    ██ 
                ██   ████ ███████ ██      ██  ██████  
                                            
                ASCII_ART
                puts "Nemo script version 1.0".colorize(:cyan)
                puts "A command-line tool designed to create iOS projects structured with VIPER architecture.".colorize(:green)
                puts ""
                puts "Usage:".style(:bold)
                puts "  nemo [command] [options]"
                puts ""
                puts "Commands:".style(:bold)
                puts "  \033[33m{-c, --create PROJECT_NAME}\033[0m   Create a new iOS project with the specified name."
                puts "  \033[33m-s, --scene SCENE_NAME\033[0m      Create a new VIPER scene with the specified name."
                puts "  \033[33m-i, --info\033[0m                  Show script information and usage."
                puts ""
                puts "Examples:".style(:bold)
                
                puts ""
                
            end

            def execute
                print_header
                print_usage
                print_options
                print_examples
                print_author_info
            end
    
            private
    
            def print_header
                puts <<~ASCII_ART.colorize(:cyan)

                ███    ██ ███████ ███    ███  ██████  
                ████   ██ ██      ████  ████ ██    ██ 
                ██ ██  ██ █████   ██ ████ ██ ██    ██ 
                ██  ██ ██ ██      ██  ██  ██ ██    ██ 
                ██   ████ ███████ ██      ██  ██████                    
                ASCII_ART
                puts "Nemo script version 1.0".colorize(:cyan).style(:bold)
                puts "A command-line tool for creating iOS projects with VIPER architecture".colorize(:green)
                puts ""
            end
    
            def print_usage
                puts "Usage:".style(:bold)
                puts "  nemo [command] [options]"
                puts ""
            end
    
            def print_options
                puts "Options:".style(:bold)
                puts "  \033[33m{-c, --create PROJECT_NAME}\033[0m   Create a new iOS project with the specified name."
                puts "  \033[33m-s, --scene SCENE_NAME\033[0m      Create a new VIPER scene with the specified name."
                puts "  \033[33m-i, --info\033[0m                  Show script information and usage."
                puts ""
            end
    
            def print_examples
                puts "Examples:".style(:bold)
                puts "  \033[32mnemo -c MyNewProject\033[0m        Create a new iOS project named 'MyNewProject'."
                puts "  \033[32mnemo --create MyNewProject\033[0m  Create a new iOS project named 'MyNewProject'."
                puts "  \033[32mnemo -s MyNewScene\033[0m          Create a new VIPER scene named 'MyNewScene'."
                puts "  \033[32mnemo --scene MyNewScene\033[0m     Create a new VIPER scene named 'MyNewScene'."
                puts "  \033[32mnemo -v\033[0m                     Show script information."
                puts "  \033[32mnemo --version\033[0m              Show script information."
                puts ""
            end
    
            def print_author_info
                puts "Author:".style(:bold)
                puts "  EL BSSITA Fouad".colorize(:cyan)
                puts "Email:".style(:bold)
                puts "  foaudelbssita@gmail.com".colorize(:cyan)
                puts "GitHub:".style(:bold)
                puts "  https://github.com/Fouadbst01".colorize(:cyan)
            end
        end
    end
end