# Messy model

class User
  # ...

  def self.new_signup(params, type)
    user = User.new

    if type == 'company'
      user.build_company
      user.company.name = "#{user.name} company"
      user.status = UserStatus.pending
    else
      user.status = UserStatus.active
    end

    user.attributes = params
    user.build_settings
    user.build_dashboard
  end

  def self.new_from_facebook(oauth_params)
    # Convert facebook params
    user.name = "#{params['first_name']} #{params['last_name']}"
    user.city = params['location']['name'].split(',').first
    #...

    user.from_facebook = true
    user.status = UserStatus.active
    user.build_settings
    user.build_dashboard
  end
end

class UserObserver

  def after_create(user)
    logger.info "User #{user.name} created"

    if @user.active?
      if @user.from_facebook?
        UserMailer.deliver_welcome_with_facebook(@user)
      else
        UserMailer.deliver_welcome(@user)
      end
    elsif @user.pending_activation?
      UserMailer.deliver_activation_required(@user)
    end
  end
end

# What if:
#   I want to create a user without sending emails
#

