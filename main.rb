# frozen_string_literal: false

require './enumerable'

students = %w[Rosa Amy Jake Charles]
numbers = [1, 2, 3, 4]

# each
students.each { |item| puts item } # => "Rosa\nAmy\nJake\nCharles\n"
students.my_each { |item| puts item } # => "Rosa\nAmy\nJake\nCharles\n"

# each_with_index
students.each_with_index { |item, index| puts "#{item}: #{index}" } # => "Rosa: 0\nAmy: 1\nJake: 2\nCharles: 3\n"
students.my_each_with_index { |item, index| puts "#{item}: #{index}" } # => "Rosa: 0\nAmy: 1\nJake: 2\nCharles: 3\n"

# my_select
p(students.select { |item| item.length == 4 }) # => ['Rosa', 'Jake']
p(students.my_select { |item| item.length == 4 }) # => ['Rosa', 'Jake']

# my_all?
p(students.all? { |item| item.length.between?(3, 7) }) # => true
p(students.my_all? { |item| item.length.between?(3, 7) }) # => true

# my_any?
p(students.any? { |item| item.length == 3 }) # => true
p(students.my_any? { |item| item.length == 3 }) # => true

# my_none?
p students.none? # => false
p(students.none? { |item| item.length == 8 }) # => true
p(students.none?('Jake')) # => false
p(students.none?('a')) # => true
p(students.none?('a') { |item| item.length == 4 }) # => true
puts "\n"
p students.my_none? # => false
p(students.my_none? { |item| item.length == 8 }) # => true
p(students.my_none?('Jake')) # => false
p(students.my_none?('a')) # => true
p(students.my_none?('a') { |item| item.length == 4 }) # => true

# my_count
p students.count # => 4
p students.count('Jake') # => 1
p(students.count { |item| item.include?('e') }) # => 2
p(students.count('Jake') { |item| item.include?('e') }) # => 1
puts "\n"
p students.my_count # => 4
p students.my_count('Jake') # => 1
p(students.my_count { |item| item.include?('e') }) # => 2
p(students.my_count('Jake') { |item| item.include?('e') }) # => 1

# my_map
p students.map # => Enumerator
p(students.map { |item| item.upcase }) # => [ROSA, AMY, JAKE, CHARLES]
p students.my_map # => Enumerator
p(students.my_map { |item| item.upcase }) # => [ROSA, AMY, JAKE, CHARLES]

# my_inject
p(numbers.inject { |memo, item| memo += item }) # => 10
p(students.inject(Hash.new(0)) { |memo, key| memo[key] += 1; memo })
p(numbers.my_inject { |memo, item| memo += item }) # => 10
p(students.my_inject(Hash.new(0)) { |memo, key| memo[key] += 1; memo })

# multiply_els
def multiply_els(array)
  array.my_inject { |memo, item| memo *= item }
end
p multiply_els(numbers) # => 24
p multiply_els([2, 4, 5]) # => 40

# my_map modified
p students.map # => Enumerator
p(students.map(&:upcase)) # => [ROSA, AMY, JAKE, CHARLES]
p students.my_map # => Enumerator
p(students.my_map(&:upcase)) # => [ROSA, AMY, JAKE, CHARLES]

