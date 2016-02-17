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

  def test_initializes_with_root_node
    assert trie.root
  end

  def test_can_insert_into_trie
    trie.insert("dog")
    assert trie.root.children.include?("d")
    current = trie.root.children["d"]
    assert current.children.include?("o")
    current = current.children["o"]
    assert current.children.include?("g")

  end

  def test_can_insert_another_word
    trie.insert("dog")
    trie.insert("cat")

    assert trie.root.children.include?("c")
    current = trie.root.children["c"]
    assert current.children.include?("a")
    current = current.children["a"]
    assert current.children.include?("t")
  end

end
