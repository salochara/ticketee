class Project < ApplicationRecord
  validates :name, presence: true
  has_many :tickets, dependent: :delete_all

  # The option with the :destroy, will iterate through the ticket's project and do a delete
  # This means it will destroy each ticket and every callback that a ticket might have associated
  # If there are no callbacks associated, it's faster to do the destroy_all, that does this:
  # DELETE FROM tickets WHERE project_id = :project_id
  # has_many :tickets, dependent: :destroy
end
