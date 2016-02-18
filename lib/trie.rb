require_relative 'node'

class Trie

  attr_accessor :root, :count, :weights

  def initialize
    @root = Node.new
    @count = 0

    @weights = {}
  end

  def insert(word, n = 0, current = root)
    unless current.children.include?(word[n])
      current.children[word[n]] = Node.new
      current.children[word[n]].end_of_word = true && @count += 1 if n == word.length - 1
      insert(word, n+1, current.children[word[n]]) if n < word.length - 1

    else
      insert(word, n+1, current.children[word[n]]) if n < word.length - 1
    end
    @count
  end

  def populate(contents_of_file)
    contents_of_file.split("\n").map do |word|
      insert(word)
    end.last
  end

  def load(file)
    temp = File.read(file)
    temp.split("\n").map do |word|
      insert(word)
    end.last
  end


  def suggest(string, n = 0, current = root)
    return "Invalid input" if string == ""

    @suggestions = []
    @word = ""
    string.each_char do |char|
      current.children.keys.include?(char) ? current = current.children[char] : (return "No suggestions found")
    end

    find_suggestions(string, current)

    temp = []
    unless weights[string] == nil
      weights[string].sort_by { |array| array[1] }.reverse.flatten.each do |element|
        temp << element if element.class == String
      end
    end

    temp.each { |word| @suggestions.delete(word) }

    return (temp + @suggestions)


  end

  def find_suggestions(string, current = root)
    unless current.children == {}
      current.children.each_key do |key|
        @word += key
        @suggestions << (string + @word) if current.children[key].end_of_word
        find_suggestions(string, current.children[key])
        @word = @word.chop
      end
    end
    @suggestions
  end

  def select(string, word)
    if weights.keys.include?(string)
      weights[string][word] += 1
    else
      weights[string] = Hash.new(0)
      weights[string][word] += 1
    end
    weights
  end
end
