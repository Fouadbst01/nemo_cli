require_relative "../utilities/string_extensions"
require_relative '../infrastructure/project_structure'
require_relative '../infrastructure/file_content_manager'
require_relative "../domain/scene"

module Nemo
    module Services
        class SceneService
            def initialize()
                @project_manager = Nemo::Infrastructure::ProjectManager.new
                @project_structure = Nemo::Infrastructure::ProjectStructure.new(@project_manager)
                @file_content_manager = Nemo::Infrastructure::FileContentManager.new(@project_manager)
            end

            def create_scene(scene)
                validate_scene!(scene)
                selected_group = @project_manager.choose_group()
                new_group = @project_structure.create_scene_structure(selected_group, scene.name)
                @file_content_manager.create_files_for_scene(new_group, scene.name)
            # rescue StandardError => e
            #     handle_error(e)
            end
        
            private

            def validate_scene!(scene)
                return if scene.valid?

                raise ArgumentError, "Invalid Scene name."
            end

            def handle_error(error)
                puts "Error: #{error.message}".colorize(:red).style(:bold)
                exit(1)
            end
        end
    end
end