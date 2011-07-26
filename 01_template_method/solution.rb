class PropertySearch < Search
  field :keywords,    String
  field :city_id,     Integer
  field :state_id,    Integer
  field :bedrooms,    Integer
  field :min_price,   Integer
  field :max_price,   Integer

  protected

  def matching_conditions
    add_text_condition :description, self.keywords
    add_equals_condition :city_id, self.city_id
    add_equals_condition :state_id, self.state_id
    add_gte_condition :bedrooms, self.bedrooms
    add_between_condition :price, self.min_price, self.max_price
  end
end

class Search
  # Left as an excercise
end

# In the controller
@property_search = PropertySearch.new(params[:search])
@properties = @property_search.results(params[:page])
@total = @property_search.count_results

# In the view
# f.text_field :min_price

# Also think about saved searches, alerts...

