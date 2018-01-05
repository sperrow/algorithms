class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.reduce(0) do |acc, el|
      acc += el.hash
      acc.hash
    end
  end
end

class String
  def hash
    self.chars.map(&:ord).hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end
