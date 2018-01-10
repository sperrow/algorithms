# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  vertices = []
  packages = {}

  max = arr.max_by { |t| t[0] }[0]
  (1..max).each do |i|
    v = Vertex.new(i)
    vertices << v
    packages[i] = v
  end

  arr.each do |tuple|
    from_vertex = packages[tuple[1]]
    to_vertex = packages[tuple[0]]
    Edge.new(from_vertex, to_vertex)
  end

  order = topological_sort(vertices)
  order.map { |v| v.value }
end

def install_order2(arr)
  packages = {}

  arr.each do |tuple|
    packages[tuple[0]] = Vertex.new(tuple[0]) unless packages[tuple[0]] || !tuple[0]
    packages[tuple[1]] = Vertex.new(tuple[1]) unless packages[tuple[1]] || !tuple[1]

    Edge.new(packages[tuple[1]], packages[tuple[0]]) unless !tuple[0] || !tuple[1]
  end

  topological_sort(packages.values).map(&:value)
end
