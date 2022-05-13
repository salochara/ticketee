require 'rails_helper'

RSpec.feature "Users can edit exisiting tickets" do
  let(:project) { FactoryBot.create(:project) } # Let uses lazy-loading, the block won't get evaluated until the first time
  # called to :project
  # let! doesn't use lazy-loading
  let(:ticket) { FactoryBot.create(:ticket, project: project) }

  before do
    visit project_ticket_path(project, ticket)
  end

  scenario "with valiod attributes" do
    click_link "Edit Ticket"
    fill_in "Name", with: "Make it shiny!"
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated"

    within(".ticket h2") do
      expect(page).to have_content "Make it shiny!"
      expect(page).not_to have_content ticket.name
    end
  end

  scenario "with invalid attributes" do
    click_link "Edit Ticket"
    fill_in "Name", with: ""
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has not been updated"
  end
end
