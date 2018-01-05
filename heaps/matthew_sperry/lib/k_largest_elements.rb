require_relative 'heap'

def k_largest_elements(array, k)
  prc = Proc.new do |el1, el2|
    -1 * (el1 <=> el2)
  end
  heap = BinaryMinHeap.new(&prc)
  array.each { |el| heap.push(el) }
  arr = []
  k.times { arr << heap.extract }
  arr
end
