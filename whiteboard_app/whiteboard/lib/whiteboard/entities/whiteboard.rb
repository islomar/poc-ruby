class Whiteboard
    attr_accessor :id
    attr_reader :name

    def initialize(name: nil, id: nil)
        @name = name
        @id = id
    end

    def ==(other_whiteboard)
        !id.nil? && id == other_whiteboard.id
    end
end