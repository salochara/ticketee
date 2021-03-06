require 'rails_helper'

RSpec.feature "Users can edit existing projects" do
  before do
    FactoryBot.create(:project, name: "VSCode")

    visit "/"
    click_link "VSCode"
    click_link "Edit Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Visual Studio Code"
    click_button "Update Project"

    expect(page).to have_content "Project has been updated"
    expect(page).to have_content "Visual Studio Code"
  end

  scenario "when providing invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Project"

    expect(page).to have_content "Project has not been updated."
  end
end
