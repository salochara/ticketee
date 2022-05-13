require 'rails_helper'

RSpec.feature "Users can view tickets" do
  before do
    @vscode = FactoryBot.create(:project, name: "Visual Studio Code")
    FactoryBot.create(:ticket, project: @vscode,
                      name: "Make it shiny!",
                      description: "This is the description")

    ie = FactoryBot.create(:project, name: "Internet Explorer")
    FactoryBot.create(:ticket, project: ie,
                      name: "Standard compliance",
                      description: "Internet explorer browser")

    visit "/"
  end

  scenario "for a given project" do
    click_link "Visual Studio Code"
    expect(page).to have_content "Make it shiny!"
    expect(page).to_not have_content "This is the description"

    click_link "Make it shiny!"
    within(".ticket h2") do
      expect(page).to have_content "Make it shiny!"
    end

    expect(page).to have_content "This is the description"
  end



end
