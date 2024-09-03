require_relative '../infrastructure/project_manager'
require_relative '../services/project_service'

module Nemo
    module Application
        class CreateProjectUseCase
            def initialize(base_url, project_name)
                @project_name = project_name
                @project_service = Nemo::Services::ProjectService.new(base_url)
            end

            def execute
                project = Nemo::Domain::Project.new(@project_name)
                @project_service.create_project(project)
            end
        end
    end
end