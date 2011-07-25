# This may be a visitor

module ResultSet
  class ChangeStatusVisitor < Visitor
    def initialize(new_status)
      @new_status = new_status
      super
    end
    
    def apply(item)
      item.update(:status => @new_status)   
    end
  end
  
  class Visitor
    def initialize
      @count_success = 0
      @count_failed = 0
    end
    
    def visit(item)
      if self.apply(item)
        @count_success += 1
      else
        @count_failed += 1
      end
    end
    
    def results
      [@count_failed, @count_success]
    end
  end

  class Collection
    def initialize(klass, ids)
      @klass = klass
      @ids = ids
    end
    
    def accept(visitor)
      self.items.each do |item|
        visitor.visit(item)
      end
    end
    
    def items
      klass.all(:id => @ids)
    end
  end
end

# In the controller
# ..
def mass_action
  @collection = ResultSet::Collection(Article, params[:ids])
  @new_status = Status.category_status(Article, params[:status_id])
  visitor = ResultSet::ChangeStatusVisitor(@new_status)
  @results = @collection.accept(visitor)
end