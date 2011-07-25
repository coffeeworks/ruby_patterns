# The strategy can also be passed as a lambda. This can be called a lightweight strategy

# Enumerable sort can receive an strategy
@users.sort! { |a,b| a.name.downcase <=> b.name.downcase }


# Other example

# Prints messages to the stdout
class Message
  def initialize(&formatter)
    @formatter = formatter
    @out = $stdout
  end

  def show(msg)
    @out.puts @formatter.call(msg)
  end
end

formatter = lambda do |msg|
  str = ''
  str << '-' * (msg.length + 4) + "\n"
  str << "| #{msg} | \n"
  str << '-' * (msg.length + 4) + "\n"
  str
end

msg = Message.new(&formatter)
msg.show('What shall we use to fill the empty spaces?')
# -----------------------------------------------
# | What shall we use to fill the empty spaces? |
# -----------------------------------------------

