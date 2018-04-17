class Whiteboard
    attr_accessor :id
    attr_reader :name

    def initialize(name:)
        @name = name
    end
end