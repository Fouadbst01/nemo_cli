module Nemo
    module Domain
        class Scene
            attr_accessor :name

            def initialize(name)
                @name = name
            end

            def valid?
                !@name.nil? && !@name.strip.empty? && valid_name_format?
            end

            def valid_name_format?
                !!(@name =~ /^[a-zA-Z0-9_-]+$/)
            end
            
        end 
    end
end