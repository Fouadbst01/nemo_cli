require_relative 'file_handler'
require_relative '../../../config/user_config'
require 'erb'

module Nemo
  module Infrastructure
    class FileContentManager

      TEMPLATE_DIR = File.expand_path('../templates', __FILE__)
      DEFAULT_FILES = ['Info.plist', 'AppDelegate.swift', 'SceneDelegate.swift', 'BaseVC.swift','LaunchScreen.storyboard']
      VIEW_CONTENT_FILE_NAME = "Scene/ViewContoller/view_controller.swift"
      CONTROLLER_CONTENT_FILE_NAME = "Scene/ViewContoller/view.xib"
      INTERACTOR_CONTENT_FILE_NAME = "Scene/Interactor/interactor.swift"
      PRESENTER_CONTENT_FILE_NAME = "Scene/Presenter/presenter.swift"
      NETWORK_MANAGER_CONTENT_FILE_NAME = "Common/Network/NetworkManger/NetworkManager.swift"
      HEADERS_CONTENT_FILE_NAME = "Common/Network/Headers/Headers.swift"
      CONSTANTS_CONTENT_FILE_NAME = "Common/constants.swift"
      LOADER_VIEW_CONTENT_FILE_NAME = "Common/LoaderView/loader-view.swift"
      LOADER_VIEW_HELPER_CONTENT_FILE_NAME = "Common/LoaderView/loader-view-helper.swift"
      IMAGE_EXTENSION_CONTENT_FILE_NAME = "Extension/ImageViewExt.swift"
      UIVIEW_EXTENSION_CONTENT_FILE_NAME = "Extension/UIViewExt.swift"
      COMMON_PROTOCOL_CONTENT_FILE_NAME = "Common/Protocol.swift"
      COMMON_BASE_ROUTER_CONTENT_FILE_NAME = "Common/Router/BaseRouter.swift"
      COMMON_DI_CONTENT_FILE_NAME = "Common/DI/DependencyContainer.swift"
      COMMON_ENUMS_CONTENT_FILE_NAME = "Common/Enums/Enums.swift"

      DEFAULT_VIEW_CONTENT_FILE_NAME = "Scene/ViewContoller/defaultViewController.swift"
      DEFAULT_CONTROLLER_CONTENT_FILE_NAME = "Scene/ViewContoller/defaultView.xib"
      DEFAULT_INTERACTOR_CONTENT_FILE_NAME = "Scene/Interactor/defaultInteractor.swift"
      DEFAULT_PRESENTER_CONTENT_FILE_NAME = "Scene/Presenter/defaultPresenter.swift"
      DEFAULT_RESPONSE_CONTENT_FILE_NAME = "Scene/Model/Response/LaunchResponse.swift"
      DEFAULT_VIEWMODEL_CONTENT_FILE_NAME = "Scene/ViewModel/LancheViewModel.swift"
      DEFAULT_ROUTER_CONTENT_FILE_NAME = "Scene/Router/Router.swift"

      MOCK_URLPROTOCOL_CONTENT_FILE_NAME = "tests/network/MockURLProtocol.swift"
      MOCK_NETWORK_MANAGER_CONTENT_FILE_NAME = "tests/network/NetworkManagerMock.swift"
      

      private_constant :DEFAULT_FILES, :TEMPLATE_DIR, :VIEW_CONTENT_FILE_NAME, :CONTROLLER_CONTENT_FILE_NAME, \
                       :INTERACTOR_CONTENT_FILE_NAME, :PRESENTER_CONTENT_FILE_NAME , :NETWORK_MANAGER_CONTENT_FILE_NAME, \
                       :CONSTANTS_CONTENT_FILE_NAME, :LOADER_VIEW_CONTENT_FILE_NAME, :LOADER_VIEW_HELPER_CONTENT_FILE_NAME, \
                       :IMAGE_EXTENSION_CONTENT_FILE_NAME, :UIVIEW_EXTENSION_CONTENT_FILE_NAME, :COMMON_BASE_ROUTER_CONTENT_FILE_NAME, \
                       :COMMON_DI_CONTENT_FILE_NAME, :COMMON_ENUMS_CONTENT_FILE_NAME, :HEADERS_CONTENT_FILE_NAME

      def initialize(project_manager)
        @project_manager = project_manager
        @file_handler = FileHandler.new
      end

      def create_default_files(project_name)
        app_root_group = find_group(project_name)
        app_root_group_path = app_root_group.real_path
        DEFAULT_FILES.each do |file_name|
          build_phase_type = nil
          build_phase_type = case file_name
            when 'Info.plist'
              @project_manager.set_infoplist_file(file_name)
              nil
            when 'LaunchScreen.storyboard'
              :resources
            else
              :source
            end
          params = {
            app_name: project_name,
            scene_name: "#{DEFAULT_SCENE_NAME}ViewController"
          }
          create_file(app_root_group, file_name, file_name, build_phase_type, params)
        end
        add_common_files(app_root_group)
        add_common_test_files()
      end

      def add_common_files(group)
        common_files = [
          { name: "NetworkManager.swift", template: NETWORK_MANAGER_CONTENT_FILE_NAME, group: NETWORK_MANAGER_GROUP_NAME },
          { name: "Headers.swift", template: HEADERS_CONTENT_FILE_NAME, group: HEADERS_GROUP_NAME },
          { name: "Constants.swift", template: CONSTANTS_CONTENT_FILE_NAME, group: COMMON_GROUP_NAME },
          { name: "LoaderView.swift", template: LOADER_VIEW_CONTENT_FILE_NAME, group: LOADER_GROUP_NAME },
          { name: "LoaderViewHelper.swift", template: LOADER_VIEW_HELPER_CONTENT_FILE_NAME, group: LOADER_GROUP_NAME },
          { name: "ImageViewExt.swift", template: IMAGE_EXTENSION_CONTENT_FILE_NAME, group: EXTENSION_GROUP_NAME },
          { name: "UIViewExt.swift", template: UIVIEW_EXTENSION_CONTENT_FILE_NAME, group: EXTENSION_GROUP_NAME },
          { name: "Protocol.swift", template: COMMON_PROTOCOL_CONTENT_FILE_NAME, group: COMMON_GROUP_NAME },
          { name: "BaseRouter.swift", template: COMMON_BASE_ROUTER_CONTENT_FILE_NAME, group: ROUTER_GROUP_NAME },
          { name: "DependencyContainer.swift", template: COMMON_DI_CONTENT_FILE_NAME, group: DI_GROUP_NAME },
          { name: "Enums.swift", template: COMMON_ENUMS_CONTENT_FILE_NAME, group: ENUMS_GROUP_NAME },
        ] 
        add_files_list_to_group(common_files, group)
      end

      # def create_test_files_for_scene(scene_name)
      #   global_test_group = @project_manager.get_test_group()
      #   scene_test_group = find_group(scene_name, test_group)
      # end

      def add_common_test_files()
        test_group = @project_manager.get_test_group()
        test_files = [
          { name: "MockURLProtocol.swift", template: MOCK_URLPROTOCOL_CONTENT_FILE_NAME, group: NETWORK_TEST_GROUP },
          { name: "NetworkManagerMock.swift", template: MOCK_NETWORK_MANAGER_CONTENT_FILE_NAME, group: NETWORK_TEST_GROUP }
        ]
        add_files_list_to_group(test_files, test_group, true)
      end

      def create_default_scene()
        default_scene_group = find_group(SCENE_GROUP_NAME)
        create_files_for_scene(default_scene_group, DEFAULT_SCENE_NAME, true)
      end

      def create_files_for_scene(group, scene_name, isDefault = false)
        create_interactor(group, scene_name, isDefault)
        create_presenter(group, scene_name, isDefault)
        create_view_controller_files(group, scene_name, isDefault)
        create_router(group, scene_name)
        if isDefault
          create_response(group)
          create_viewModel(group)
        end
        # create_test_files_for_scene(scene_name)
      end

      private

      def add_files_list_to_group(files, group, isTestFile = false)
        files.each do |file|
          file_name = file[:name]
          file_template = file[:template]
          file_group = file[:group]
          create_file_in_group(group, file_group, file_name, file_template, :source, [], isTestFile)
        end
      end

      def create_response(group)
        create_file_in_group(group, RESPONSE_GROUP_NAME, "LancheResponse.swift", DEFAULT_RESPONSE_CONTENT_FILE_NAME, :source)
      end

      def create_viewModel(group)
        create_file_in_group(group, VIEWMODEL_GROUP_NAME, "LancheViewModel.swift", DEFAULT_VIEWMODEL_CONTENT_FILE_NAME, :source)
      end

      def create_interactor(group, scene_name, isDefault)
        contentFileName = isDefault ? DEFAULT_INTERACTOR_CONTENT_FILE_NAME : INTERACTOR_CONTENT_FILE_NAME
        create_file_in_group(group, INTERACTOR_GROUP_NAME, "#{scene_name}Interactor.swift", contentFileName, :source, scene_name: scene_name)
      end
      
      def create_presenter(group, scene_name, isDefault)
        contentFileName = isDefault ? DEFAULT_PRESENTER_CONTENT_FILE_NAME : PRESENTER_CONTENT_FILE_NAME
        create_file_in_group(group, PRESENTER_GROUP_NAME, "#{scene_name}Presenter.swift", contentFileName, :source, scene_name: scene_name)
      end
      
      def create_view_controller_files(group, scene_name, isDefault)
        viewContentFileName = isDefault ? DEFAULT_VIEW_CONTENT_FILE_NAME : VIEW_CONTENT_FILE_NAME
        viewControllerContentFileName = isDefault ? DEFAULT_CONTROLLER_CONTENT_FILE_NAME : CONTROLLER_CONTENT_FILE_NAME
        create_file_in_group(group, VIEW_GROUP_NAME, "#{scene_name}ViewController.swift", viewContentFileName, :source, vc_name: scene_name)
        create_file_in_group(group, VIEW_GROUP_NAME, "#{scene_name}ViewController.xib", viewControllerContentFileName, :resources, vc_name: scene_name)
      end

      def create_router(group, scene_name)
        create_file_in_group(group, ROUTER_GROUP_NAME, "#{scene_name}Router.swift", DEFAULT_ROUTER_CONTENT_FILE_NAME, :source, vc_name: scene_name)
      end
      
      def create_file_in_group(group, group_name, file_name, content_name, build_phase_type, params = [], isTestFile = false)
        target_group = find_group(group_name, group)
        create_file(target_group, file_name, content_name, build_phase_type, params, isTestFile)
      end

      def create_file(group, file_name, content_name, build_phase_type, params, isTestFile = false)
        file_path = File.join(group.real_path, file_name)
        content = render_template(content_name, params)
        @file_handler.create_file(file_path, content)
        @project_manager.add_file_to_group(file_path, group, build_phase_type, isTestFile)
      end
      
      def find_group(name, group = nil)
        group = @project_manager.find_group(name, group)
        if group.nil?
          puts "Error: Could not find group in project '#{name}'"
          exit(1)
        end
        group
      end

      def render_template(template_file, params = {})
        template_path = File.join(TEMPLATE_DIR, template_file)
        template = File.read(template_path)

        params.each do |key, value|
          instance_variable_set("@#{key}", value)
        end

        ERB.new(template).result(binding)
      end

    end
  end
end
