# grammar
# C: '('C')' | '['C']' | '{'C'}' | '<'C'>' | ''

module Syntax
  class CloseError < StandardError; end
  class OpenError < StandardError; end
end

class Tokenizer
  def initialize(line)
    @index = 0
    @line = line
  end

  def current
    line[@index]
  end

  def consume
    token = line[@index]
    @index += 1
    token
  end

  private

  attr_accessor :index, :line
end

class Syntaxer
  CHUNK_CLOSER = {
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>',
  }

  def self.scan(line)
    new(::Tokenizer.new(line)).scan
  end

  def initialize(tokenizer)
    @tokenizer = tokenizer
    @auto_correct = []
  end

  def scan
    chunk
    @auto_correct.reverse
  end

  private

  attr_accessor :tokenizer


  def chunk
    current = tokenizer.consume
    expected_closer = CHUNK_CLOSER[current]
    return current if expected_closer.nil?

    @auto_correct << expected_closer
    actual_closer = chunk
    return if actual_closer.nil?

    raise Syntax::CloseError, "expected #{expected_closer} but received #{actual_closer}" unless expected_closer == actual_closer
    raise Syntax::OpenError, "expected '(', '[', '{', or '<' but received #{actual_closer}" if @auto_correct == []

    @auto_correct.pop && chunk
  end
end

CHAR_SCORES = {
  ')' => 1,
  ']' => 2,
  '}' => 3,
  '>' => 4,
}

def auto_correct_score(chars)
  chars.inject(0) { |total, char| total * 5 + CHAR_SCORES[char] }
end

def auto_correct_scores
  scores = []

  File.foreach("../data.txt", chomp: true).with_index do |line, i|
    scores << auto_correct_score(Syntaxer.scan(line))
  rescue Syntax::OpenError, Syntax::CloseError => e
    puts "error on line #{i}: #{e.message}"
  end

  scores
end

scores = auto_correct_scores.sort

puts scores[scores.length - (scores.length + 1) / 2]
