require_relative 'node'

class Trie

  attr_accessor :root, :count

  def initialize
    @root = Node.new
    @count = 0
  end

  def insert(word, n = 0, current = root)
    word = word.downcase
    unless current.children.include?(word[n])
      current.children[word[n]] = Node.new
      current.children[word[n]].end_of_word = true && @count += 1 if n == word.length - 1
      insert(word, n+1, current.children[word[n]]) if n < word.length - 1

    else
      insert(word, n+1, current.children[word[n]]) if n < word.length - 1
    end
  end

  def load(file)
    temp = File.read(file)
    temp.split("\n").count do |word|
      insert(word)
    end
  end


end
