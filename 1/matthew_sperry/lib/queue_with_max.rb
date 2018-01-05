# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max = nil
  end

  def enqueue(val)
    @max = val if !@max || val > @max
    @store.push(val)
  end

  def dequeue
    val = @store.shift
    if val == @max
      @max = nil
      (0...@store.length).each do |i|
        @max = @store[i] if !@max || @store[i] > @max
      end
    end
  end

  def max
    @max
  end

  def length
    @store.length
  end

end
