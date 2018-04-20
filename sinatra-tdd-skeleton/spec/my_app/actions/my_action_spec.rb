describe "Here you should write your action" do

    before(:each) do
        #TODO
    end

    #TODO
    context "your context description" do
        it "bla bla bla" do

            my_action = MyApp::HelloWorldAction.new()

            result = my_action.run("world")

            expect(result).to eq "Hello world"
        end
    end

end