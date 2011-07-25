# ActiveRecord Observer
# Really useful in combination with dirty tracking
class ActivationObserver < ActiveRecord::Observer
  observe :account

  def before_save(account)
    @status_changed = account.status_changed?
    @old_status = account.status_was
  end
  
  def after_save(account)
    AccountNotifier.account_status_changed(account, @old_status).deliver if @status_changed
  end
end