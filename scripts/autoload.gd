extends Node

var gravity = 80;

# default save stats, I have no idea what to add
var stats = {
  "hp": 1,
  "xp": 1,
};

func save(savedict):
  var save_game = File.new()
  save_game.store_line(savedict)
  save_game.close()

func load():
  var save_game = File.new()
  if not save_game.file_exists("user://savegame.save"): return;
  save_game.open("user://savegame.save", File.READ)
  stats = save_game.get_as_text() # yay