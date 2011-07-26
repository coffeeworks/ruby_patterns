# Too much logic in the controller

class SignupController < ApplicationController
  # ...

  def create
    @user = User.new(params[:user])

    if @user.valid?

      # Add associated objects
      @user.website = Website.new

      # Set default values
      @user.plan = :free

      @user.save

      if @user.active?
        UserMailer.deliver_welcome(@user)
        set_current_user(@user) # Login
        redirect_to :action => 'success'
      else
        UserMailer.deliver_activation_required(@user)
        redirect_to :action => 'activation_required'
      end
    else
      render :action => :new
    end
  end

end

# What if:
#   I want to support different kinds of users?
#   There are different creation flows: Signup form, Facebook Connect, ...
#   I want to create associated objects inside a transaction?

