require_relative 'file_handler'
require_relative '../../../internal_config/environment'
require_relative '../../../config/user_config'
require 'yaml'

module Nemo
  module Infrastructure
    class ProjectStructure

        PROJECT_STRUCTURE_FILE_NAME = 'folder_structure.yml'
        SCENE_STRUCTURE_FILE_NAME = 'viper_structure.yml'
        TEST_STRUCTURE_FILE_NAME = 'test_foldar_structure.yml'
        VIPER_TESTS_STRUCTURE_FILE_NAME = "viper_test_structure.yml"
        TEMPLATE_DIR = File.expand_path('../templates', __FILE__)
        COLOR_FOLDER = "#{TEMPLATE_DIR}/Colors"
        APP_ICON_FOLDER = "#{TEMPLATE_DIR}/AppIcon/AppIcon.appiconset"

        private_constant :PROJECT_STRUCTURE_FILE_NAME, :SCENE_STRUCTURE_FILE_NAME, :TEST_STRUCTURE_FILE_NAME, \
                         :COLOR_FOLDER, :APP_ICON_FOLDER, :VIPER_TESTS_STRUCTURE_FILE_NAME

        def initialize(project_manager)
            @project_manager = project_manager
            @file_handler = FileHandler.new
        end

        def setup_project_structure(project_name)
            project_path = File.dirname(@project_manager.project.path)
            main_group = create_default_directories(project_name, project_path)
            create_assets_directories(main_group)
        end

        def create_default_scene_structure()
            group =  @project_manager.find_group(SCENE_GROUP_NAME)
            create_scene_structure(group, DEFAULT_SCENE_NAME)
        end

        def create_scene_structure(group, scene_name)
            structure = load_directories_from_yaml(SCENE_STRUCTURE_FILE_NAME)
            scene_group_path = File.join(group.real_path, scene_name)
            scene_group = @project_manager.include_folder_in_project(group, scene_name, scene_group_path)
            create_nested_folders(scene_group, structure)
            create_test_dirs(group, scene_name)
            return scene_group
        end
        
        def create_test_dirs(group, scene_name)
            structure = load_directories_from_yaml(VIPER_TESTS_STRUCTURE_FILE_NAME)
            test_group = @project_manager.get_test_group()
            scene_group = @project_manager.find_group(SCENE_GROUP_NAME, test_group)
            tested_scene_group_path = File.join(scene_group.real_path, scene_name)
            tested_scene_group = @project_manager.include_folder_in_project(scene_group, scene_name, tested_scene_group_path)
            create_nested_folders(tested_scene_group, structure)
        end

        private

        def create_default_directories(project_name, project_path)
            main_group = project_structure(project_name, project_path)
            test_structure(project_name, project_path)
            return main_group
        end

        def project_structure(project_name, project_path)
            # main group
            main_group_path = "#{project_path}/#{project_name}"
            main_group = create_main_group(project_name, main_group_path)
            #load project structure
            structure = load_directories_from_yaml(PROJECT_STRUCTURE_FILE_NAME)
            #create project structure
            create_nested_folders(main_group, structure)
            return main_group
        end

        def test_structure(project_name, project_path)
             # test group
             test_group_name = "#{project_name}Tests"
             test_group_path = "#{project_path}/#{test_group_name}"
             test_group = create_test_group(test_group_name, test_group_path)
             #load test structure
             structure = load_directories_from_yaml(TEST_STRUCTURE_FILE_NAME)
             #create project structure
            create_nested_folders(test_group, structure)
        end

        def create_assets_directories(main_group)
            ASSETS.each do |assets_name|
                assets_path = "#{main_group.real_path}/#{assets_name}"
                @file_handler.create_directory(assets_path)
                @project_manager.add_file_to_group(assets_path, main_group, :resources)
            end 
            addAppIcon(main_group)
            addDefaultColor(main_group)
        end

        def addDefaultColor(main_group)
            colorPath = "#{main_group.real_path}/Colors.xcassets"
            @file_handler.create_directory(colorPath)
            @file_handler.copy_content_to_directory(COLOR_FOLDER, colorPath)
        end
        
        def addAppIcon(main_group)
            appIconPath = "#{main_group.real_path}/Assets.xcassets/AppIcon.appiconset"
            @file_handler.create_directory(appIconPath)
            @file_handler.copy_content_to_directory(APP_ICON_FOLDER, appIconPath)
        end

        def create_main_group(main_group_name, main_group_path)
            @file_handler.create_directory(main_group_path)
            main_group = @project_manager.create_main_group(main_group_name, main_group_path)
            return main_group
        end

        def create_test_group(test_group_name, test_group_path)
            @file_handler.create_directory(test_group_path)
            test_group = @project_manager.create_main_group(test_group_name, test_group_path)
            return test_group
        end

        def create_nested_folders(group, structure)
            structure.each do |folder_name, subfolders|
                new_group_path = "#{group.real_path}/#{folder_name}"
                @file_handler.create_directory(new_group_path)
                new_group = @project_manager.include_folder_in_project(group, folder_name, new_group_path)
                if subfolders
                    create_nested_folders(new_group, subfolders)
                end
            end
        end
        
        def load_directories_from_yaml(file_name)
            config_path = File.join(PROJECT_ROOT, "internal_config", file_name)
            config = YAML.load_file(config_path)
            return config
        end
    end
  end
end