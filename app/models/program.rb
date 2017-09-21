class Program < ApplicationRecord
  
  has_many :placements
  has_many :program_quota
  has_many :program_choices

  def self.unplaced_applicant
    Program.all.each do |p|
      if p.total_remaining_quota > 0
        unvsts = p.program_quota.collect{|x| x.university_id}
        unvsts.each do |u|
          if p.remaining_quota(u) > 0
            p.program_choices.each do |pc|
              if pc.university_choices.collect{|x| x.university_id}.include?(u) and pc.applicant.placement.blank?
              return true
              end
            end
          end
        end
      end
    end
    return false
  end

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
