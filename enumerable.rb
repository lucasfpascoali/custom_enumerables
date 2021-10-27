# frozen_string_literal: true

# Enumerable module modified to add new methods
module Enumerable
  def my_each
    return to_enum unless block_given?

    for item in self
      yield(item)
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    my_each { |item| yield(item, find_index(item)) }
    self
  end

  def my_select
    return to_enum unless block_given?

    selected_items = []
    my_each { |item| selected_items.push(item) if yield(item) }
    selected_items
  end

  def my_all?
    return true unless block_given?

    my_each { |item| return false unless yield(item) }
    true
  end

  def my_any?
    my_each { |item| return true if !block_given? || yield(item) }
    false
  end

  def my_none?(pattern = nil)
    if !pattern.nil?
      my_each { |item| return false if pattern === item }
    elsif block_given?
      my_each { |item| return false if yield(item) }
    end
    pattern.nil? && !block_given? ? false : true
  end

  def my_count(pattern = nil)
    counter = length
    if block_given? && pattern.nil?
      my_each { |item| counter -= 1 unless yield(item) }
      return counter
    end
    my_each { |item| counter -= 1 unless item == pattern } unless pattern.nil?
    counter
  end

  def my_map(proc = nil)
    array = clone
    if !proc.nil?
      my_each_with_index { |_, index| array[index] = proc.call }
    elsif block_given?
      my_each_with_index { |_, index| array[index] = yield(array[index]) }
    else
      return to_enum
    end
    array
  end

  def my_inject(memo = self[0])
    my_each do |item|
      next if item == self[0] && memo == self[0]

      memo = yield(memo, item)
    end
    memo
  end
end
