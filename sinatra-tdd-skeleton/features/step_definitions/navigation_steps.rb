When("goes to home page") do
    @home_page = PageObjects::HomePage.new(self)
end

Then("we get a hello world message") do
    expect(@home_page.title).to eq 'Hello world'
end

# Then /^show me the page$/ do
#     save_and_open_page
# end

