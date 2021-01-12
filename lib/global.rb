$MAX_ATTEMPTS = 6

$good_letters = []

$bad_letters = []


def get_last_id
  rows = File.readlines ".saves.csv"
  last_line = rows[-1]
  last_id = last_line[0].to_i
  return  last_id + 1
end

def create_new_game
  vocabulary = Game::Vocabulary.new("5desk.txt")
  $good_word = vocabulary.get_word

  $player = Game::Player.new
  $player.get_player_name

  game = Game::Game.new($player)
  i = 0
  return  game
end

def continue_game(num)
  rows = File.readlines '.saves.csv'
  good_row = rows[num].split('; ')

  $good_word = good_row[2]
  # print $good_word
  $player = Game::Player.new
  $player.name = good_row[1]

  $good_letters = to_arr(good_row[3])

  $bad_letters = to_arr(good_row[4])

  game = Game::Game.new($player)
  game.attempts = good_row[5].to_i


  return  game

  end



def to_arr(str)
  array = []
  str.each_char do |char|
    array << char if char >= 'a' && char <= 'z'
  end
  return array

end