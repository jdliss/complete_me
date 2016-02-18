require_relative 'node'

class Trie

  attr_accessor :root, :count

  def initialize
    @root = Node.new
    @count = 0
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

  def load(file)
    temp = File.read(file)
    temp.split("\n").map do |word|
      insert(word)
    end.last
  end

  # def check_input(string)
  #   return "Invalid input" unless string.chars.all? { |char| letters.include?(char) }
  #
  # end


  def suggest(string, n = 0, current = root)
    return "Invalid input" if string == ""

    @suggestions = []
    @word = ""
    string.each_char do |char|
      current.children.keys.include?(char) ? current = current.children[char] : (return "No suggestions found")
    end

    find_suggestions(string, current)
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

end
