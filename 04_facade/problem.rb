class AccountsController < ApplicationController
  
  def create
    @user = User.new(params[:user])
    @account = @user.build_account(params[:account])
    
    if @user.valid? && @account.valid?
      @user.save!
      @account.save!
      redirect_to dashboard_url
    else
      render :new
    end    
  end
  
end

# Also think about the view