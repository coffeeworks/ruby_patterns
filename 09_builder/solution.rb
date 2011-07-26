class UserCreationService
  attr_accessor :skip_notification

  def initialize(user_klass = User)
    @user_klass = user_klass
  end

  def create(params)
    @user = @user_klass.new

    populate_params(params)

    build_associations

    after_create

    return @user
  end

  private

  def populate_params(params)
    @user.attributes = params
  end

  def build_associations
    @user.build_settings
    @user.build_dashboard
  end

  def after_create
    logger.info "User #{user.name} created"
    send_notifications unless @skip_notification
  end
end

class FacebookUserCreationService < UserCreationService

  private

  def populate_params(params)
    @user.name = "#{params['first_name']} #{params['last_name']}"
    @user.city = params['location']['name'].split(',').first
    # ..

    @user.from_facebook = true
  end
end

