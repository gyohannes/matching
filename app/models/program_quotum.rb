class ProgramQuotum < ApplicationRecord
  belongs_to :program
  belongs_to :university

  def self.total_remainig_quota 
    Program.all.collect{|p| p.total_remaining_quota}.sum
  end
    
end
