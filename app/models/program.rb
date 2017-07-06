class Program < ApplicationRecord
  
  has_many :placements
  has_many :program_quota
  has_many :program_choices


  def remaining_quota(uninversity)
    return total_quota(uninversity) - total_placed(uninversity)
  end

  def total_placed(university)
    placements.where('university_id = ?',university).size
  end

  def total_quota(university)
    program_quota.where('university_id = ?',university).first.try(:quota_number) || 0
  end

  def count_applicants(choice_number)
    program_choices.where('choice_number = ?',choice_number).size
  end

  def total_remaining_quota
    University.all.collect{|x| remaining_quota(x.id)}.sum
  end

  def to_s
    name
  end
end
