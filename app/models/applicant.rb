class Applicant < ApplicationRecord

  has_many :program_choices
  has_one :exam
  has_one :placement
  has_one :waiting_list
  
  def self.match
    	applicants = Applicant.unplaced_applicants
        programs = Program.joins(:program_quota).select{|x| x.unplaced_applicants.count > 0 }
    	if !programs.blank? and !applicants.blank?
      	 Applicant.iterate_applicants(applicants)
    	end
  end

  def self.unplaced_applicants
    Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).includes(:placement).where(placements: {id: nil} ).
uniq.sort_by(&:aptitude_and_interview).reverse
  end

  def self.iterate_applicants(applicants)
    applicants.each do |a|
       placed = false
        a.program_choices.order('choice_number').each do |pc|
            pc.university_choices.order('choice_number').each do |uc|
            placed = Applicant.final_match(a,pc,uc)
            break if placed==true
      	  end
          break if placed==true
        end
    end
    remaining_applicants = Applicant.unplaced_applicants
    if remaining_applicants == applicants
      logger.info("-----------------------Same Applicants---")
      Applicant.match_waiting
     logger.info("-----------------------Same Applicants---")
    end
   Applicant.match
  end

  def self.match_waiting
    WaitingList.all.each do |wa|
      if wa.applicant.placement.blank?
        Placement.create(applicant_id: wa.applicant.id, program_id: wa.program_id, university_id: wa.university_id)
           wa.destroy
        end
      end
  end

  def self.waiting_list(program,university)
    Applicant.joins(:waiting_list, [:exam=>:exam_results]).where('waiting_lists.program_id = ? and exam_results.program_id = ? and university_id = ?',program, program, university).order('total_result DESC')
  end

  def self.final_match(applicant,pc,uc)
    match_result = false
    applicants = Applicant.joins([:program_choices=>:university_choices],[:exam=>:exam_results]).where('exam_results.program_id = ? 
      and university_choices.university_id = ? and program_choices.program_id = ?', pc.program_id,uc.try(:university_id),pc.program_id).includes(:placement).order('total_result DESC').where(placements: {id: nil} ).uniq

    if pc.program.remaining_quota(uc.try(:university_id)) > 0 and applicants.include?(applicant)
      if pc.program.remaining_quota(uc.try(:university_id)) >= applicants.index(applicant) + 1 
        if applicant.placement.blank?
          Placement.create(applicant_id: applicant.id, program_id: pc.program_id, university_id: uc.university_id)
          match_result = true
          if !applicant.waiting_list.blank?
           applicant.waiting_list.destroy
          end
          waiting_apps = Applicant.waiting_list(pc.program_id, uc.university_id).uniq
          if waiting_apps.count > pc.program.remaining_quota(uc.try(:university_id))
           waiting_apps.last.waiting_list.destroy
          end
        end
      else
        all_waiting = Applicant.waiting_list(pc.program_id, uc.university_id)
        if all_waiting.include?(applicant)
            match_result = true
        else
          better_waiting = all_waiting.where('total_result > ?',applicant.total_result(pc.program_id))
          if pc.program.remaining_quota(uc.try(:university_id)) > better_waiting.count
            WaitingList.create(applicant_id: applicant.id, program_id: pc.program_id, university_id: uc.university_id)
            match_result = true
            all_waiting_after = Applicant.waiting_list(pc.program_id, uc.university_id).uniq
            if all_waiting_after.count > pc.program.remaining_quota(uc.try(:university_id))
              all_waiting_after.last.waiting_list.destroy
            end
          end
        end
      end
    end
    return match_result
  end

  def self.calculate_total_result
    ExamResult.all.each do |er|
      er.total_result = er.exam.applicant.total_result(er.program_id)
      er.save
    end
  end

  def affirmative_result
    if gender == 'Female'
     return Setting.first.try(:affirmative_percentage) || 0
    end
    return 0
  end

  def total_result(program)
    return (interview_result + program_exam_result(program) + aptitude_result + affirmative_result).round(2)
  end

  def aptitude_and_interview
    (aptitude_result + interview_result + affirmative_result).round(2)
  end

  def aptitude_result
    return ((exam.aptitude_exam_result.to_f/40) * Setting.first.try(:aptitude_weight)).round(2)
  end

  def program_interview_result(program)
    inres = exam.interviews.where('program_id = ?',program).first.try(:result) || 0 
    return ((inres/30) * Setting.first.try(:interview_weight)).round(2)
  end

 def interview_result
    return ((exam.interview_result.to_f/30) * Setting.first.try(:interview_weight)).round(2)
 end	

  def program_exam_result(program)
    pres = exam.exam_results.find_by_program_id_and_exam_id(program,self.exam.id).try(:result) || 0
    return ((pres/80) * Setting.first.try(:exam_weight)).round(2)
  end

  def to_s
    [first_name, father_name, grand_father_name].join(' ')
  end

end
