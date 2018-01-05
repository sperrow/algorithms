require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise 'index out of bounds' if index >= @length
    idx = (@start_idx + index) % @capacity
    @store[idx]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index >= @length
    idx = (@start_idx + index) % @capacity
    @store[idx] = val
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    idx = (@length + @start_idx - 1) % @capacity
    @length -= 1
    @store[idx]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    idx = (@length + @start_idx) % @capacity
    @store[idx] = val
    @length += 1
  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length == 0
    el = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    new_idx = 0
    start = @start_idx

    while new_idx < @length
      new_store[new_idx] = @store[start % @capacity]
      new_idx += 1
      start += 1
    end
    @capacity *= 2
    @start_idx = 0
    @store = new_store
  end
end
