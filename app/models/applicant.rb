class Applicant < ApplicationRecord

  has_many :program_choices
  has_one :exam
  has_one :placement
  
  def self.match
    applicants = Applicant.unplaced_applicants
     applicants.each do |a|
        pc = a.program_choices.where('choice_number = ?',1).first
	unless pc.blank?
            uc = pc.university_choices.where('choice_number = ?',1).first
            placed = Applicant.final_match(a,pc,uc)
	end
    end
    applicants = Applicant.unplaced_applicants
    Applicant.iterate_applicants(applicants)
  end

  def self.unplaced_applicants
    Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).
	distinct.includes(:placement).where(placements: {id: nil} ).shuffle
  end

  def self.iterate_applicants(applicants)
    applicants.each do |a|
      placed = false
        a.program_choices.order('choice_number').each do |pc|
            pc.university_choices.order('choice_number').each do |uc|
            placed = Applicant.final_match(a,pc,uc)
            break if placed
	end
      end
    end
    prs = Program.joins(:program_quota).select{|x| x.total_remaining_quota > 0}
    applicants = Applicant.unplaced_applicants
    if !prs.blank? and !applicants.blank?
      Applicant.iterate_applicants(applicants)
    end
  end

  def average_of_all
    total = aptitude_result
unless exam.blank?
    exam.exam_results.each do |er|
     total = total + er.result
    end
end
    return total.round(2)
  end

  def self.final_match(applicant,pc,uc)
    match_result = false
    applicants = Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).where('exam_results.program_id = ? 
      and university_choices.university_id = ?', pc.program_id,uc.try(:university_id)).distinct.includes(:placement).where(placements: {id: nil} ).sort_by{|x| x.total_result(pc.program_id)}.reverse

    if pc.program.remaining_quota(uc.try(:university_id)) > 0 and applicants.include?(applicant)
	match_result = true
      if pc.program.remaining_quota(uc.try(:university_id)) >= applicants.index(applicant) + 1
        Placement.create(applicant_id: applicant.id, program_id: pc.program_id, university_id: uc.university_id)
      end
    end
    return match_result
  end

  def affirmative_result
    if gender == 'Female'
     return Setting.first.try(:affirmative_percentage) || 0
    end
    return 0
  end

  def total_result(program)
    return interview_result + program_exam_result(program) + aptitude_result + affirmative_result
  end

  def aptitude_result
    return ((exam.try(:aptitude_exam_result) || 0 /100) * Setting.first.try(:aptitude_weight)).round(2)
  end

  def program_interview_result(program)
    inres = exam.interviews.where('program_id = ?',program).first.try(:result) || 0 
    return ((inres/100) * Setting.first.try(:interview_weight)).round(2)
  end

 def interview_result
    return ((exam.interview_result/100) * Setting.first.try(:interview_weight)).round(2)
 end	

  def program_exam_result(program)
    pres = exam.exam_results.find_by_program_id_and_exam_id(program,self.exam.id).result || 0
    return ((pres/100) * Setting.first.try(:exam_weight)).round(2)
  end

  def to_s
    [first_name, father_name, grand_father_name].join(' ')
  end

end
