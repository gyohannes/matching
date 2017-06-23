class Exam < ApplicationRecord
  belongs_to :applicant
  has_many :exam_results
  has_many :interviews

  def to_s
    applicant
  end
  
end
