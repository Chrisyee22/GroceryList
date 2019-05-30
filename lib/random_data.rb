module RandomData

  def self.random_word
    letters = ('a'..'z').to_a
    letters.shuffle!
    letters[0,rand(3..8)].join
  end
  
  def self.random_sentence
    strings = []
    rand(3..8).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.random_number
    numbers = rand(1..12)
  end
end
