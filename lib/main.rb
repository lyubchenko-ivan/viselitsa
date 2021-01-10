require  './lib/game.rb'
require './lib/global.rb'


#создаем объект словарь и получаем слово из файла
vocabulary = Game::Vocabulary.new("5desk.txt")
$good_word = vocabulary.get_word

player = Game::Player.new
player.get_player_name

game = Game::Game.new(player)
i = 0

begin
  game.display_result
  letter = player.get_letter
  game.correct(letter)
end while(!game.win? && !game.lose?)