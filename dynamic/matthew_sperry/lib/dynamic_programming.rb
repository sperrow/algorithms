class DynamicProgramming

  def initialize
    @blair_cache = {
      1 => 1,
      2 => 2
    }
    @frog_cache = {
      1 => [ [1] ],
      2 => [ [1, 1], [2] ],
      3 => [ [1, 1, 1], [1, 2], [2, 1], [3] ]
    }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    odd = (n - 1) * 2 - 1
    blair = blair_nums(n - 1) + blair_nums(n - 2) + odd
    @blair_cache[n] = blair unless @blair_cache[n]
    blair
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    cache = {
      1 => [ [1] ],
      2 => [ [1, 1], [2] ],
      3 => [ [1, 1, 1], [1, 2], [2, 1], [3] ]
    }
    return cache if cache[n]

    (4..n).each do |i|
      ith_solution = []
      cache[i - 1].each do |hop|
        arr = hop.dup
        arr << 1
        ith_solution << arr
      end
      cache[i - 2].each do |hop|
        arr = hop.dup
        arr << 2
        ith_solution << arr
      end
      cache[i - 3].each do |hop|
        arr = hop.dup
        arr << 3
        ith_solution << arr
      end

      cache[i] = ith_solution
    end

    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if frog_hops_top_down_helper(n)

    if @frog_cache[n - 1]
      ith_solution = []
      frog_hops_top_down_helper(n - 1).each do |hop|
        arr = hop.dup
        arr << 1
        ith_solution << arr
      end
      frog_hops_top_down_helper(n - 2).each do |hop|
        arr = hop.dup
        arr << 2
        ith_solution << arr
      end
      frog_hops_top_down_helper(n - 3).each do |hop|
        arr = hop.dup
        arr << 3
        ith_solution << arr
      end

      @frog_cache[n] = ith_solution
      ith_solution
    else
      frog_hops_top_down(n - 1)
      frog_hops_top_down(n)
    end
  end

  def frog_hops_top_down_helper(n)
    @frog_cache[n]
  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
