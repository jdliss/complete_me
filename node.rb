class Node
  attr_accessor :end_of_word, :children

  def initialize
    @end_of_word = false
    @children = Hash.new
  end
end
