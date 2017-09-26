class Applicant < ApplicationRecord

  has_many :program_choices
  has_one :exam
  has_one :placement
  
  def self.match
    applicants = Applicant.unplaced_applicants
    programs = Program.select{|x| x.unplaced_applicants.count > 0}.sort_by{|x| x.unplaced_applicants.count}.reverse
    Applicant.iterate_applicants(applicants,programs.first)
  end

  def self.unplaced_applicants
    Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).includes(:placement).where(placements: {id: nil} ).uniq.shuffle
  end

  def self.iterate_applicants(applicants,p)
    applicants.each do |a|
      placed = false
        pc = a.program_choices.where('program_id = ?',p.id).first
          unless pc.blank?
            pc.university_choices.order('choice_number').each do |uc|
            placed = Applicant.final_match(a,pc,uc)
            if placed == true
              break
	    end
      	  end
        end
    end
    programs = Program.select{|x| x.unplaced_applicants.count > 0}.sort_by{|x| x.unplaced_applicants.count}.shuffle
    unless programs.blank?
      programs.each do |p|
    	applicants = p.unplaced_applicants
    	unless applicants.blank?
      	 Applicant.iterate_applicants(applicants,p)
    	end
      end
    end
  end

  def self.final_match(applicant,pc,uc)
    match_result = false
    applicants = Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).where('exam_results.program_id = ? 
      and university_choices.university_id = ?', pc.program_id,uc.try(:university_id)).order('total_result DESC').includes(:placement).where(placements: {id: nil} ).uniq

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
    return ((exam.aptitude_exam_result/100) * Setting.first.try(:aptitude_weight)).round(2)
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
