class Program < ApplicationRecord
  
  has_many :placements
  has_many :program_quota
  has_many :program_choices

  def unplaced_applicants
      if total_remaining_quota > 0
        unvsts = program_quota.select{|x| remaining_quota(x.university_id) > 0}.collect{|x| x.university_id}

        return Applicant.joins([:exam=>:exam_results],[:program_choices=>:university_choices]).includes(:placement).
		where(placements: {id: nil}).where('exam_results.program_id = ? and program_choices.program_id = ? and university_choices.university_id in (?)',self.id,self.id, unvsts).uniq
    end
    return []
  end

  def remaining_quota(uninversity)
    return total_quota(uninversity) - total_placed(uninversity)
  end

  def total_placed(university)
    placements.where('university_id = ?',university).size
  end

  def total_quota(university)
    program_quota.where('university_id = ?',university).first.quota_number
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
