require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  list = []
  queue = []

  queue = enqueue(vertices, queue)

  until queue.empty?
    vertex = queue.shift
    list << vertex

    new_vertices = vertex.out_edges.map(&:to_vertex)
    out_edges = vertex.out_edges.dup

    out_edges.each(&:destroy!)
    vertex.out_edges = []

    queue = enqueue(new_vertices, queue)
  end

  list.length == vertices.length ? list : []
end

def enqueue(vertices, queue)
  vertices.each do |vertex|
    queue << vertex if vertex.in_edges.empty?
  end
  queue
end
