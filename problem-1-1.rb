#!/usr/bin/ruby

# Given an array of integers, return a new array such that each element
# at index i of the new array is the product of all the numbers in the
# original array except the one at i.

# Examples:
# - [1, 2, 3, 4, 5] => [120, 60, 40, 30, 24]
# - [3, 2, 1] => [2, 3, 6]

# Thoughts: Iterate over the array and the iterate over the sub-array?

# Faster solution: get product of all values, then divide each value at
# i to get the result.

# Book solution (best?): calculate prefix and suffix products as we go
# through the array... implemented this but it would have taken me a long
# time to find this solution myself, and I'm not sure I love it...

def generate_product_array_v1(array)
  result = []

  array.each_index do |i|
    value = array[i]

    product = 1

    array.each_index do |j|
      product *= array[j] unless i == j
    end

    result << product
  end

  result
end

def generate_product_array_v2(array)
  product = array.inject(1) { |sum, x| sum * x }

  array.map { |x| product / x }
end

def generate_product_array_v3(array)
  prefix_products = []

  # [1, 2, 3, 4, 5] results in [1, 2, 6, 24, 120]
  array.each do |a|
    if prefix_products.length == 0
      prefix_products << a
    else
      prefix_products << prefix_products[-1] * a
    end
  end

  suffix_products = []

  # [1,2,3,4,5] or [5,4,3,2,1] results in [5,20,60,120,120]
  array.reverse.each do |a|
    if suffix_products.length == 0
      suffix_products << a
    else
      suffix_products << suffix_products[-1] * a
    end
  end

  suffix_products.reverse!

  result = []

  array.each_index do |i|
    if i == 0
      result << suffix_products[i + 1]
    elsif i == array.length - 1
      result << prefix_products[i - 1]
    else
      result << prefix_products[i-1] * suffix_products[i+1]
    end
  end

  result
end

def main
  result = generate_product_array_v3([1, 2, 3, 4, 5])
  puts "result: #{result}"

  result = generate_product_array_v3([3,2,1])
  puts "result: #{result}"
end

main
