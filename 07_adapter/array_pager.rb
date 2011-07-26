class Messenger
  def inbox_messages(user)
    messages = ArrayPager.new

    inbox_entries = InboxEntry.all(conditions_for(user))
    inbox_entries.each do |entry|
      msg = Presenter::Message.new(entry.message)
      messages << msg
    end
    messages.pager = inbox_entries.pager
    messages
  end
end

class ArrayPager < Array
  attr_accessor :pager
end

# <%= will_paginate @messages %>

# Alternative, use singleton methods
def messages.pager
  inbox_entries.pager
end

