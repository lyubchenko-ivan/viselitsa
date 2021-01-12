require  './lib/game.rb'
require './lib/global.rb'


#создаем объект словарь и получаем слово из файла

answer = nil
begin
  puts "Нажмите \"0\", если хотите начать новую игру, а если хотите продолжить игру, то нажмите номер сохранения (0..#{get_last_id - 1})"
  answer = gets.chomp.strip.to_i
end while(answer != 0 && !(answer > 0 &&  answer < get_last_id) )


if (answer == 0)
  game = create_new_game
else
  game = continue_game(answer)
end

begin


  game.display_result
  letter = $player.get_letter
  game.correct(letter)
  puts "Если вы хотите сохранить нажмите \"1\"\nИначе нажмите любую другую клавишу"
  answer = gets.chomp.strip
  if answer == '1'
    game.save_game
    break
  end
end while(!game.win? && !game.lose?)