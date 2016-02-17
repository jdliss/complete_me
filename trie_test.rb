gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'trie'

class TrieTest < Minitest::Test

  attr_accessor :trie

  def setup
    @trie = Trie.new
  end

  def test_can_initialize_new_trie
    assert trie
  end

  def test_can_insert_node
    assert trie.root
  end

end
