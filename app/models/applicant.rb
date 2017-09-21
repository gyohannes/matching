class Applicant < ApplicationRecord

  has_many :program_choices
  has_one :exam
  has_one :placement
  
  def self.match
    applicants = Applicant.all.sort_by{ |a| a.aptitude_result}.reverse
     Applicant.iterate_applicants(applicants)
  end

  def self.unplaced_applicants
    Applicant.all.select{ |a| a.placement.blank?}.sort_by{ |a| a.aptitude_result}.shuffle
  end

  def self.iterate_applicants(applicants)
    applicants.each do |a|
      placed = false
      if a.placement.blank?
        a.program_choices.order('choice_number').each do |pc|
          if placed == true
              break
          end
            pc.university_choices.order('choice_number').each do |uc|
            placed = Applicant.final_match(a,pc,uc)
            if placed == true
              break
            end
          end
        end
      end
    end
    unplaced_applicants = Applicant.unplaced_applicants
    if Program.unplaced_applicant
    	Applicant.iterate_applicants(unplaced_applicants)
    end
  end


  def self.final_match(applicant,pc,uc)
    match_result = false
    applicants = Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).where('exam_results.program_id = ? 
      and university_choices.university_id = ?', pc.program_id,uc.university_id).uniq.reject{|x| !x.placement.blank?}.
    sort_by{|x| x.total_result(pc.program_id)}.reverse
    if pc.program.remaining_quota(uc.university_id) > 0 and applicants.include?(applicant)
      if pc.program.remaining_quota(uc.university_id) >= applicants.index(applicant) + 1
        Placement.create(applicant_id: applicant.id, program_id: pc.program_id, university_id: uc.university_id)
        match_result = true
      else
        better_applicants = applicants.select{|x| applicants.index(x) < applicants.index(applicant)}
        unless better_applicants.blank?
          match_result = true
        end     
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
