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

  def test_suggests_words_based_on_string
    trie.insert("dough")
    trie.insert("dog")
    trie.insert("down")

    suggestions = ["dough", "dog", "down"]
    assert_equal suggestions, trie.suggest("do")
  end

  def test_cant_find_suggestions_for_string
    trie.insert("dough")
    trie.insert("dog")
    trie.insert("down")
    suggestions = "No suggestions found."

    assert suggestions, trie.suggest("asfg")
  end

end
