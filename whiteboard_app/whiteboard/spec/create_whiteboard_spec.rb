require "whiteboard"
require "support/fake_whiteboard_repo"

describe "create whiteboard" do
    let(:gui) { GuiSpy.new }
    let(:repo) { FakeWhiteboardRepo.new }

    it "requires name" do
        create_whiteboard(name: "", gui: gui, repo: repo)

        expect(gui.spy_validation_errors).to include(field: :name, validation: :required)
    end

    it "requires name to be unique" do
        create_whiteboard(name: "valid name", gui: gui, repo: repo)
        create_whiteboard(name: "valid name", gui: gui, repo: repo)

        expect(gui.spy_validation_errors).to include(field: :name, validation: :unique)
    end

    it "sends an id for the created whiteboard back to the gui" do
        create_whiteboard(name: "valid name", gui: gui, repo: repo)

        expect(gui.spy_created_whiteboard_id).to be
    end


    class GuiSpy
        attr_reader :spy_validation_errors
        attr_reader :spy_created_whiteboard_id

        def validation_failed(errors)
            @spy_validation_errors = errors
        end

        def whiteboard_created(whiteboard_id)
            @spy_created_whiteboard_id = whiteboard_id
        end
    end
end