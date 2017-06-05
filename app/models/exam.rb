class Exam < ApplicationRecord
  belongs_to :applicant
  has_many :exam_results


  def to_s
    applicant
  end
  
end
