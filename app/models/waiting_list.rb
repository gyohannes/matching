class WaitingList < ApplicationRecord
  belongs_to :applicant
  belongs_to :program
  belongs_to :university
end
