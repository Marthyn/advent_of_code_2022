class Stack
  attr_reader :crates

  def initialize(crates)
    @crates = crates.reverse
  end

  def insert(crate)
    crates.push(crate)
  end

  def take
    crates.pop
  end

  def pretty
    crates.reverse.map { |x| "[#{x}]"}
  end
end

class Crane
  attr_reader :stack_one, :stack_two, :stack_three

  def initialize(stack_one, stack_two, stack_three)
    @stack_one = stack_one
    @stack_two = stack_two
    @stack_three = stack_three
    @stacks = [@stack_one, @stack_two, @stack_three]
  end

  def process(input)
    print

    3.times do
      stack_three.insert(stack_one.take)
    end

    print

    2.times do
      stack_one.insert(stack_two.take)
    end

    print

    1.times do
      stack_two.insert(stack_one.take)
    end

    print
  end

  def tops
    @stacks.map { |stack| stack.crates.last }
  end

  def print
    puts stack_one.pretty
    puts '1'
    puts stack_two.pretty
    puts '2'
    puts stack_three.pretty
    puts '3'
  end
end

one = Stack.new(['D', 'N', 'Z'])
two = Stack.new(['C', 'M'])
three = Stack.new(['P'])

crane = Crane.new(one, two, three)
crane.process('')
puts "--- RESULT ---"
puts crane.tops.join

# stack_one = Stack.new(['W', 'L', 'S'])
# stack_one = Stack.new(['W', 'L', 'S'])
# stack_one = Stack.new(['W', 'L', 'S'])
# stack_one = Stack.new(['W', 'L', 'S'])
# stack_one = Stack.new(['W', 'L', 'S'])
# stack_one = Stack.new(['W', 'L', 'S'])
