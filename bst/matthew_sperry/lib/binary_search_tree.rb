require_relative 'bst_node'

# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    if !@root
      @root = BSTNode.new(value)
    else
      compare_and_insert(value, @root)
    end
  end

  def find(value, tree_node = @root)
    return nil unless tree_node
    return tree_node if tree_node.value == value
    if tree_node.value > value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value, given_node = nil)
    node = given_node || find(value)
    return false unless node
    return @root = nil if value == @root.value
    if !node.left && !node.right
      parent_side = which_parent(node)
      if parent_side == 'left'
        node.parent.left = nil
      else
        node.parent.right = nil
      end
    elsif !node.left ^ !node.right
      child = node.left ? node.left : node.right
      parent_side = which_parent(node)
      if parent_side == 'left'
        node.parent.left = child
      elsif parent_side == 'right'
        node.parent.right = child
      end
    else
      left = node.left
      r = maximum(left)
      node.value = r.value

      r.parent.right = r.left
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    node = tree_node
    while node.right
      node = node.right
    end
    node
  end

  def depth(tree_node = @root)
    return 0 unless tree_node
    if !tree_node.left && !tree_node.right
      0
    else
      left_total = depth(tree_node.left)
      right_total = depth(tree_node.right)
      if left_total > right_total
        1 + left_total
      else
        1 + right_total
      end
    end
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:
  def compare_and_insert(value, node)
    if node.value > value
      if !node.left
        new_node = BSTNode.new(value)
        node.left = new_node
        new_node.parent = node
      else
        compare_and_insert(value, node.left)
      end
    elsif !node.right
      new_node = BSTNode.new(value)
      node.right = new_node
      new_node.parent = node
    else
      compare_and_insert(value, node.right)
    end
  end

  def which_parent(node)
    val = node.value
    parent = node.parent
    return false unless parent
    if parent.left.value == val
      return 'left'
    elsif parent.right.value == val
      return 'right'
    end
    false
  end
end
