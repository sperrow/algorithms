class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length == 1
    pivot = array.length - 1
    left = arr[0...pivot].select { |el| el < array[pivot] }
    right = arr[0...pivot].select { |el| el >= array[pivot] }
    QuickSort.sort1(left) + array[pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 0
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    pivot_idx = start
    pending = false
    (start + 1...start + length).each do |i|
      if prc.call(array[i], array[start]) == -1
        if pending
          array[pivot_idx + 1], array[i] = array[i], array[pivot_idx + 1]
          pending = false
        end
        pivot_idx += 1
      else
        pending = true
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end
end
