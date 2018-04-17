def create_whiteboard(name:, gui:, repo:)
    if name.empty?
        gui.validation_failed(name: :required)
    elsif repo.find_by_name(name)
        gui.validation_failed(name: :unique)
    else
        repo.save(Whiteboard.new(name: name))
    end
end

describe "create whiteboard" do
    # require names be unique   ==> UI, Persistence
    # save the whiteboard       ==> Persistence

    it "requires name" do
        create_whiteboard(name: "", gui: gui, repo: repo)

        expect(gui.spy_validation_errors).to include(name: :required)
    end

    it "requires name to be unique" do
        create_whiteboard(name: "valid name", gui: gui, repo: repo)
        create_whiteboard(name: "valid name", gui: gui, repo: repo)

        expect(gui.spy_validation_errors).to include(name: :unique)
    end

    let(:gui) { GuiSpy.new }
    let(:repo) { FakeWhiteboardRepo.new }

    class Whiteboard
        attr_reader :name

        def initialize(name:)
            @name = name
        end
    end

    describe "whiteboard repository" do
        it "finds by name" do
            ny = Whiteboard.new(name: "NY")
            sf = Whiteboard.new(name: "SF")

            repo = FakeWhiteboardRepo.new()

            repo.save(ny)
            repo.save(sf)

            expect(repo.find_by_name(ny.name)).to eq ny
            expect(repo.find_by_name(sf.name)).to eq sf
        end
    end

    class GuiSpy
        attr_reader :spy_validation_errors

        def validation_failed(errors)
            @spy_validation_errors = errors
        end
    end

    class FakeWhiteboardRepo
        def initialize()
            @whiteboards = []
        end

        def find_by_name(name)
            @whiteboards.find { |w| w.name == name }
        end

        def save(whiteboard)
            @whiteboards << whiteboard
        end
    end
end