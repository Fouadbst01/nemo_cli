require_relative '../../../config/user_config'

require 'xcodeproj'
require 'tty-prompt'

module Nemo
  module Infrastructure
    class ProjectManager
    
        attr_reader :project

        def initialize(base_path = nil)
            if base_path.nil?
                open_project()
            else 
                @base_path = base_path
            end
        end

        def create_project(project_name)
            current_path = Dir.pwd
            project_path =  "#{current_path}/#{project_name}/"
            # Create a new Xcode project
            @project = Xcodeproj::Project.new("#{project_path}/#{project_name}.xcodeproj")

            # Create a new target (iOS app)
            target = project.new_target(:application, project_name, :ios, '14.0')

            # Add the test target
            test_target_name = "#{project_name}Tests"
            test_target = project.new_target(:unit_test_bundle, test_target_name, :ios, '14.0')

            # Set the project bundle identifier
            bundle_identifier = "com.nemo.#{project_name}"
            project.build_configuration_list.set_setting('PRODUCT_BUNDLE_IDENTIFIER', bundle_identifier)

            # set version
            project.build_configuration_list.set_setting('MARKETING_VERSION', '1.0')

            # set build number
            project.build_configuration_list.set_setting('CURRENT_PROJECT_VERSION', '1')
            
            # Set the project to use Swift
            project.build_configuration_list.set_setting('SWIFT_VERSION', '5.0')

            # Set launch screen
            project.build_configuration_list.set_setting('INFOPLIST_KEY_UILaunchStoryboardName', 'LaunchScreen')
        
            # Set the development team and deployment target (optional)
            target.build_configuration_list.set_setting('DEVELOPMENT_TEAM', '')
            target.build_configuration_list.set_setting('IPHONEOS_DEPLOYMENT_TARGET', '14.0')

            #set user defined
            target.build_configuration_list.set_setting('BASE_URL', 'https://api.spacexdata.com/v5/')

            # add packages 
            add_packages()

            save_project
        end

        def create_main_group(group_name, main_group_path)
            main_group = @project.new_group(group_name, main_group_path)
            return main_group
        end

        def add_file_to_group(file_path, group, build_phase_type = nil)
            file_reference = group.new_file(file_path)
            add_to_build_phase(file_reference, build_phase_type) if build_phase_type

            save_project
        end

        def include_folder_in_project(group, new_group_name ,new_group_path)
            group = group.new_group(new_group_name, new_group_path)
            save_project
            return group
        end

        def find_group(group_name, group = nil)
            if group.nil?
                group = @project.main_group
            end
            return find_group_by_name(group_name, group)
        end

        def set_infoplist_file(infoplist_file_name)
            target = @project.targets.first
            target.build_configuration_list.set_setting('INFOPLIST_FILE', File.join(target.name,infoplist_file_name))
            target.build_configuration_list.set_setting('GENERATE_INFOPLIST_FILE', 'YES')
            save_project
        end

        def choose_group
            group = find_group(SCENE_GROUP_NAME)
            prompt = TTY::Prompt.new
            choices = [
                {name: "#{SCENE_GROUP_NAME} (main screen folder)", value: 0}
            ]
            subgroups = group.groups
            subgroups.each_with_index do |subgroup, index|
                choices << {name: subgroup.display_name, value: index + 1}
            end
            user_input = prompt.select("Select a group for the VIPER scene :", choices)
            return user_input == 0 ? group : subgroups[user_input]
        end

        def sort_project()
            @project.main_group.groups.sort_by! { |group| group.display_name.downcase }
            save_project
        end

        def get_test_group()
            @project.main_group.groups.each do |subgroup|
                return subgroup if subgroup.display_name.end_with?("Tests")
            end
            nil
        end

        private 

        def open_project
            project_path = get_xcodeproj_path()
            @project = Xcodeproj::Project.open(project_path)
        end

        def get_xcodeproj_path()
            project_path = Dir.glob('*.xcodeproj').first
            if project_path.nil?
                puts "No .xcodeproj file found in the current directory."
                exit 1
            end
            return "#{Dir.pwd}/#{project_path}"
        end

        def add_packages()
            root_object = @project.root_object
            target = @project.targets.first
            # Check if the package dependencies already exist
            existing_packages = root_object.package_references.map(&:url)

            PACKAGES.each do |pkg|
                package_name = pkg[:name]
                package_url = pkg[:url]
                package_version = pkg[:version]

                unless existing_packages.include?(package_url)
                    package_reference = @project.new(Xcodeproj::Project::Object::XCRemoteSwiftPackageReference)
                    package_reference.repositoryURL = package_url
                    package_reference.requirement = { 'kind' => 'exactVersion', 'version' => package_version }

                    root_object.package_references << package_reference

                    package_product_dependency = @project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
                    package_product_dependency.product_name = package_name
                    package_product_dependency.package = package_reference

                    target.package_product_dependencies << package_product_dependency

                    puts "Added package #{package_name} (#{package_url}, version #{package_version}) to the project."
                else
                    puts "Package #{package_name} is already added."
                end
            end

            save_project
        end
          
        def add_to_build_phase(file_reference, build_phase_type)
            target = @project.targets.first
            case build_phase_type
            when :source
                target.source_build_phase.add_file_reference(file_reference)
            when :resources
                target.resources_build_phase.add_file_reference(file_reference)
            else
                raise ArgumentError, "Unsupported build phase type: #{build_phase_type}"
            end
        end

        def find_group_by_name(group_name, group)
            return group if group.display_name == group_name
            group.groups.each do |subgroup|
              result = find_group_by_name(group_name, subgroup)
              return result unless result.nil?
            end
            nil
        end

        def save_project
            @project.save
        end
    end
  end
end