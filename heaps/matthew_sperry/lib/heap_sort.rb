require_relative "heap"

class Array
  def heap_sort!
    partition = 0
    prc = Proc.new do |el1, el2|
      -1 * (el1 <=> el2)
    end

    until partition == self.length
      BinaryMinHeap.heapify_up(self, partition, partition, &prc)
      partition += 1
    end

    until partition == 0
      self[0], self[partition - 1] = self[partition - 1], self[0]
      partition -= 1
      BinaryMinHeap.heapify_down(self, 0, partition, &prc)
    end

    self
  end
end
