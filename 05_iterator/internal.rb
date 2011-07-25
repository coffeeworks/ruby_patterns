# Any class that includes the Enumerable module

[1, 2, 3].each { |number| puts number }

# Higher level methods

[1, 2, 3].any? { |number| number % 2 == 0 } # => true
[1, 3, 5].any? { |number| number % 2 == 0 } # => false

[2, 4, 6].all? { |number| number % 2 == 0 } # => true
[1, 2, 3].all? { |number| number % 2 == 0 } # => false

[1, 2, 3].collect { |number| number * 2 } # => [2, 4, 6]

[1, 2, 3, 4].select { |number| number % 2 == 0 } # => [2, 4]

[1, 2, 3, 4].select(&:even?) # => [2, 4]

# With ActiveSupport
[1, 2, 3, 4].in_groups_of(2) do |row|
  row.each do |col|
    puts col + ' '
  end
  puts "̣\n"
en
# =>
# 1 2
# 3 4

# I dont remember the last time I used 'for' or 'while' loops!!