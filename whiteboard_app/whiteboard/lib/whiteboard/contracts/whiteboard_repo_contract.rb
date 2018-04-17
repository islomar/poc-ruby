require "whiteboard"

def whiteboard_repo_contract(repo_class)
    describe "whiteboard repository" do
        let (:ny) { Whiteboard.new(name: "NY") }
        let (:sf) { Whiteboard.new(name: "SF") }
        let (:repo) { repo_class.new() }

        it "creates unique IDs for whiteboards when saved" do
            repo.save(ny)
            repo.save(sf)

            expect(ny.id).to be
            expect(sf.id).to be
            expect(ny.id).not_to eq(sf.id)
        end

        it "finds by name" do
            repo.save(ny)
            repo.save(sf)

            expect(repo.find_by_name(ny.name)).to eq ny
            expect(repo.find_by_name(sf.name)).to eq sf
        end
    end
end