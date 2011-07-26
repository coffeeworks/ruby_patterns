class Property < ORM
  # ...

  def self.count_search_results(params, page)
    # ?
  end

  def self.search_results(params, page)
    conditions = {}

    conditions[:city_id] = params[:city_id] if params[:city_id]

    conditions[:state_id] = params[:state_id] if params[:state_id]

    conditions['bedrooms.gte'] = params[:bedrooms] if params[:bedrooms]

    min_price = params[:min_price].to_i if params[:min_price]
    max_price = params[:max_price].to_i if params[:max_price]

    if min_price && max_price
      conditions[:price] = min_price..max_price
    elsif min_price
      conditions['price.gte'] = min_price
    elsif max_price
      conditions['price.lte'] = max_price
    end

    self.all(conditions).paginate(:page => page)
  end

end

# In the controller
# @properties = Property.search_results(params[:search], params[:page])

# In the view
# = text_field_tag 'search[min_price]'

