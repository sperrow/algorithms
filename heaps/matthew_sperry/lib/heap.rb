class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |a, b| a <=> b }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[count - 1] = @store[count - 1], @store[0]
    popped = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    popped
  end

  def peek
    @store.first
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_idx)
    left = 2 * parent_idx + 1
    right = 2 * parent_idx + 2
    indices = []
    indices << left if left < len
    indices << right if right < len
    indices
  end

  def self.parent_index(child_idx)
    raise 'root has no parent' if child_idx == 0
    (child_idx - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    indices = self.child_indices(len, parent_idx)
    return array if indices.empty?
    smaller = indices[0]
    smaller = indices[1] if indices[1] && prc.call(array[indices[0]], array[indices[1]]) == 1
    if prc.call(array[parent_idx], array[smaller]) == 1
      array[parent_idx], array[smaller] = array[smaller], array[parent_idx]
      self.heapify_down(array, smaller, len, &prc)
    else
      array
    end
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    return array if child_idx == 0
    parent_idx = self.parent_index(child_idx)
    if prc.call(array[parent_idx], array[child_idx]) == 1
      array[child_idx], array[parent_idx] = array[parent_idx], array[child_idx]
      self.heapify_up(array, parent_idx, len, &prc)
    else
      array
    end
  end
end
