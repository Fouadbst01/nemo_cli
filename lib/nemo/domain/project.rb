module Nemo
    module Domain
        class Project
            attr_accessor :name

            def initialize(name)
                @name = name
            end
        end 
    end
end