require_relative '../infrastructure/project_manager'
require_relative '../services/scene_service'

module Nemo
    module Application
        class CreateViperSceneUseCase
            def initialize(scene_name)
                @scene_name = scene_name
                @scene_service = Nemo::Services::SceneService.new
            end

            def execute
                scene = Nemo::Domain::Scene.new(@scene_name)
                @scene_service.create_scene(scene)
            end
        end
    end
end