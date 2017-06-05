class ProgramChoice < ApplicationRecord
  belongs_to :applicant
  belongs_to :program
  has_many :university_choices

  def to_s
    [applicant,program,choice_number].join('-')
  end
end
