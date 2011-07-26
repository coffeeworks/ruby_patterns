# Inside a cron script
#
# rescue Exception => e
#   notify_exception(e)
# end

def self.notify_exception(e)
  mock_controller = PlastilinaObject.new({
    :controller_name => self.name,
    :controller_action => 'run'

  })

  mock_request = PlastilinaObject.new({
    :env => ENV
  })

  ExceptionNotifier.deliver_exception_notification(e, mock_controller, mock_request, {})
end

class PlastilinaObject
  def initialize(hash={})
    @hash = hash
  end

  def method_missing(method, *args)
    if @hash.has_key?(method)
      @hash[method]
    else
      ""
    end
  end
end

