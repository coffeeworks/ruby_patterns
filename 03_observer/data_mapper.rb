# Can be used as a trigger to handle denormalized data

class Employee
  include DataMapper::Resource  
  
  property :name, String
  
  belongs_to :company
  has n, :job_positions
end

class JobPosition
  include DataMapper::Resource
  
  include Observers::JobPositionObserver
  
  property :works_here, Boolean  
  belongs_to :employee
  belongs_to :company
end

module Observers::JobPositionObserver
  extend ActiveSupport::Concern
  
  included do
    after :save do
      if self.working_here?
        self.employee.update(
          :company => self.company
        )
      end
    end
  end  
end


# JobPositionsController:
#   @employee.job_positions.create(params[:job_position])
# ...