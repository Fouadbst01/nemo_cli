require_relative "../utilities/string_extensions"
require_relative '../infrastructure/project_structure'
require_relative '../infrastructure/file_content_manager'
require_relative "../domain/project"

module Nemo
    module Services
        class ProjectService
            def initialize(base_url)
                @project_manager = Nemo::Infrastructure::ProjectManager.new(base_url)
                @project_structure = Nemo::Infrastructure::ProjectStructure.new(@project_manager)
                @file_content_manager = Nemo::Infrastructure::FileContentManager.new(@project_manager)
            end

            def create_project(project)
                validate_project!(project)
                
                create_and_setup_project(project.name)
                setup_default_files_and_structure(project.name)
            # rescue StandardError => e
            #     handle_error(e)
            end
        
            private
    
            def validate_project!(project)
                return if project.valid?

                raise ArgumentError, "Invalid project name."
            end

            def create_and_setup_project(project_name)
                @project_manager.create_project(project_name)
                @project_structure.setup_project_structure(project_name)
            end

            def setup_default_files_and_structure(project_name)
                @file_content_manager.create_default_files(project_name)
                @project_structure.create_default_scene_structure()
                @file_content_manager.create_default_scene()
            end

            def handle_error(error)
                puts "Error: #{error.message}".colorize(:red).style(:bold)
                exit(1)
            end
        end
    end
end