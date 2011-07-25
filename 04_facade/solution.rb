# See https://github.com/jamesgolick/active_presenter

class SignupPresenter < ActivePresenter::Base
  presents :user, :account
end

class AccountsController < ApplicationController
  def create
    @signup_presenter = SignupPresenter.new(params[:signup_presenter])
    
    if @signup_presenter.save
      redirect_to dashboard_url
    else
      render :new
    end
  end
end