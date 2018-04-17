def create_whiteboard(name:, gui:)
    gui.validation_failed(name: :required)
end

describe "create whiteboard" do
    # require name              ==> UI
    # require names be unique   ==> UI, Persistence
    # save the whiteboard       ==> Persistence

    it "requires name" do
        create_whiteboard(name: "", gui: gui)

        expect(gui.spy_validation_errors).to include(name: :required)
    end

    let(:gui) { GuiSpy.new }

    class GuiSpy
        attr_reader :spy_validation_errors
        
        def validation_failed(errors)
            @spy_validation_errors = errors
        end
    end
end