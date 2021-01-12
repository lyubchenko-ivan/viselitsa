require './lib/global.rb'
require 'csv'




module Game


  #словарь
  class Vocabulary
    attr_reader :name

    def initialize(name)
      @name = name
    end

    #достать слово из словаря
    def get_word
      words = File.readlines self.name
      words = words.select { |word| word.chomp.length >= 5 && word.chomp.length <= 12 }
      return  words.sample.chomp.downcase
    end

  end

  class Player
    attr_accessor :name


    def get_player_name
      name = nil
      begin
        print "Enter your name, please: "
        name = gets.chomp.strip
      end while(name == '')

      @name = name

      self.greet_player
    end


    private
    def greet_player
      puts "Welcome, #{self.name}"
    end

    public
    def get_letter
      letter = ''
      begin
        print "Введите символ: "
        letter = gets.chomp.strip.downcase
      end while(letter.nil?)
      return letter
    end
  end


  class Game
    attr_reader :player
    attr_accessor :attempts

    def initialize(player)
      @player = player
      @attempts = 0
    end

    def display_result
      system 'clear'
      puts "У вас осталось  #{$MAX_ATTEMPTS - self.attempts} попыток"
      puts self.word_output
      print "Неверные буквы:  #{$bad_letters}\n"
    end

    private
    def word_output
      output = ''

      $good_word.each_char do |letter|
        if $good_letters.include? letter then output << " #{letter} "
        else output << ' _ '
        end
      end

      return output
    end

    public
    def correct(letter)
      if ($good_word.include?(letter) && !$good_letters.include?(letter)) then $good_letters << letter
      elsif (!$good_word.include?(letter) && !$bad_letters.include?(letter)) then
        $bad_letters << letter
        self.attempts += 1
      end
    end

    def win?
      $good_word.each_char do |char|
        return false if !$good_letters.include?(char)
      end
      system 'clear'
      puts "#{self.player.name}, ты победил.\nСлово - #{$good_word}"
      return true
    end

    def lose?
      if self.attempts == $MAX_ATTEMPTS
        system "clear"
        puts "#{self.player.name}, ты проиграл.\nСлово - #{$good_word}"
        return  true
      end
      return false
    end


    def save_game
      File.open(".saves.csv", 'a') do |file|
        file.puts(self.to_s)
      end
    end

    private
    def to_s
      return "#{get_last_id}, #{self.player.name},#{$good_word}, #{$good_letters}, #{$bad_letters}, #{self.attempts}"
    end



  end

end