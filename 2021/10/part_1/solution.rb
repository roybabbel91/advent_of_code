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
  end

  def scan
    response = chunk
    return if response.nil?

    raise Syntax::OpenError, "expected '(', '[', '{', or '<' but received #{response}"
  end

  private

  attr_accessor :tokenizer


  def chunk
    current = tokenizer.consume
    expected_closer = CHUNK_CLOSER[current]
    return current if expected_closer.nil?

    actual_closer = chunk
    return if actual_closer.nil?

    return chunk if expected_closer == actual_closer

    raise Syntax::CloseError, "expected #{expected_closer} but received #{actual_closer}"
  end
end

ERROR_SCORES = {
  '(' => 3,
  ')' => 3,
  '[' => 57,
  ']' => 57,
  '{' => 1197,
  '}' => 1197,
  '<' => 25137,
  '>' => 25137,
}

def error_score
  score = 0

  File.foreach("../data.txt", chomp: true).with_index do |line, i|
    Syntaxer.scan(line)
  rescue Syntax::OpenError, Syntax::CloseError => e
    puts "error on line #{i}: #{e.message}"
    score += ERROR_SCORES[e.message.chars.last].to_i
  end

  score
end

puts error_score
