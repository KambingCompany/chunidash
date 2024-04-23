extends RefCounted

class_name OsbParser

static func parse(osb_path: String) -> Array[Sprite]:
	print("Begin parsing")
	var start_time = Time.get_ticks_msec()

	var file = FileAccess.open(osb_path, FileAccess.READ)
	var content = file.get_as_text().split("\n")

	var sprite: Sprite
	var sprites: Array[Sprite] = []

	for line_idx in content.size():
		var line = content[line_idx]
		if line.begins_with("[") or line.begins_with("//") or line.is_empty():
			continue
		
		# commands
		if line.begins_with(" "):
			var command: SpriteCommand
			var split: PackedStringArray = line.strip_edges().split(",")

			if split.size() < 5:
				assert(false, "Invalid command: " + line)

			var type: CommandType
			match split[0]:
				"M":
					type = CommandType.Move
				"MX":
					type = CommandType.MoveX
				"MY":
					type = CommandType.MoveY
				"F":
					type = CommandType.Fade
				"S":
					type = CommandType.Scale
				"V":
					type = CommandType.Vector
				"R":
					type = CommandType.Rotate
				"C":
					type = CommandType.Color
				var cmd:
					print("unknown command: " + cmd)
					continue
			
			var easing: Easing
			match split[1]:
				"0":
					easing = Easing.Linear
				"1":
					easing = Easing.Out
				"2":
					easing = Easing.In
				"3":
					# print("don't support QuadIn")
					continue
				"4":
					# print("don't support QuadOut")
					continue
				"5":
					# print("don't support QuadInOut")
					continue
				"6":
					# print("don't support CubicIn")
					continue
				"7":
					# print("don't support CubicOut")
					continue
				"8":
					# print("don't support CubicInOut")
					continue
				"9":
					# print("don't support QuartIn")
					continue
				"10":
					# print("don't support QuartOut")
					continue
				"11":
					# print("don't support QuartInOut")
					continue
				"12":
					# print("don't support QuintIn")
					continue
				"13":
					# print("don't support QuintOut")
					continue
				"14":
					# print("don't support QuintInOut")
					continue
				"15":
					# print("don't support SineIn")
					continue
				"16":
					# print("don't support SineOut")
					continue
				"17":
					# print("don't support SineInOut")
					continue
				"18":
					# print("don't support ExpoIn")
					continue
				"19":
					# print("don't support ExpoOut")
					continue
				"20":
					# print("don't support ExpoInOut")
					continue
				"21":
					# print("don't support CircIn")
					continue
				"22":
					# print("don't support CircOut")
					continue
				"23":
					# print("don't support CircInOut")
					continue
				"24":
					# print("don't support ElasticIn")
					continue
				"25":
					# print("don't support ElasticOut")
					continue
				"26":
					# print("don't support ElasticHalfOut")
					continue
				"27":
					# print("don't support ElasticQuarterOut")
					continue
				"28":
					# print("don't support ElasticInOut")
					continue
				"29":
					# print("don't support BackIn")
					continue
				"30":
					# print("don't support BackOut")
					continue
				"31":
					# print("don't support BackInOut")
					continue
				"32":
					# print("don't support BounceIn")
					continue
				"33":
					# print("don't support BounceOut")
					continue
				"34":
					# print("don't support BounceInOut")
					continue
				var e:
					assert(false, "unknown easing: " + e)
			
			var startTime: int = int(split[2])
			if split[3] == "":
				split[3] = split[2]
			var endTime: int = int(split[3])
			var params: Array = split.slice(4, split.size())
			
			command = SpriteCommand.new(type, easing, startTime, endTime, params)
			sprite.commands.append(command)
		# objects
		else:
			var split: PackedStringArray = line.strip_edges().split(",")
			match split[0]:
				"Sprite":
					# print("New sprite: " + line)
					# if sprite != null:
					#	 print("Done Sprite: " + sprite.to_string())

					# check if valid
					if split.size() != 6:
						assert(false, "Invalid sprite: " + line)

					var layer: Layer
					match split[1]:
						"Background":
							layer = Layer.Background
						"Fail":
							layer = Layer.Fail
						"Pass":
							layer = Layer.Pass
						"Foreground":
							layer = Layer.Foreground
					
					var origin: Origin
					match split[2]:
						"TopLeft":
							origin = Origin.TopLeft
						"Centre":
							origin = Origin.Centre
						"CentreLeft":
							origin = Origin.CentreLeft
						"TopRight":
							origin = Origin.TopRight
						"BottomCentre":
							origin = Origin.BottomCentre
						"TopCentre":
							origin = Origin.TopCentre
						"Custom":
							origin = Origin.Custom
						"CentreRight":
							origin = Origin.CentreRight
						"BottomLeft":
							origin = Origin.BottomLeft
						"BottomRight":
							origin = Origin.BottomRight
					
					var filepath: String = split[3].replace("\"", "").replace("\\", "/")
					var rawX: String = split[4]
					var rawY: String = split[5]

					# # doesn't work for some reason
					# # check if rawx and rawy are valid
					# if not rawX.is_valid_int() or not rawY.is_valid_int():
					#	 print("Invalid sprite: " + line)
					#	 continue
					
					var x: int = int(rawX)
					var y: int = int(rawY)

					sprite = Sprite.new(layer, origin, filepath, x, y)
					sprites.append(sprite)
					# print("Sprite created: " + sprite.to_string())

				var type:
					assert(false, "unknown type at line: " + str(line_idx) + type)
	
	print("Done parsing")
	print("Time taken: " + str(Time.get_ticks_msec() - start_time) + "ms")
	return sprites

enum Layer {Background, Fail, Pass, Foreground}
enum Origin {TopLeft, Centre, CentreLeft, TopRight, BottomCentre, TopCentre, Custom, CentreRight, BottomLeft, BottomRight}
enum CommandType {Fade, Move, MoveX, MoveY, Scale, Vector, Rotate, Color}
enum Easing {Linear, In, Out}
# enum Easing {Linear, In, Out, QuadIn, QuadOut, QuadInOut, CubicIn, CubicOut, CubicInOut, QuartIn, QuartOut, QuartInOut, QuintIn, QuintOut, QuintInOut, SineIn, SineOut, SineInOut, ExpoIn, ExpoOut, ExpoInOut, CircIn, CircOut, CircInOut, ElasticIn, ElasticOut, ElasticHalfOut, ElasticQuarterOut, ElasticInOut, BackIn, BackOut, BackInOut, BounceIn, BounceOut, BounceInOut}
class SpriteCommand:
	var type: CommandType
	var easing: Easing
	var startTime: int
	var endTime: int
	var params: Array

	func _init(startType: CommandType, startEasing: Easing, startStartTime: int, startEndTime: int, startParams: Array):
		type = startType
		easing = startEasing
		startTime = startStartTime
		endTime = startEndTime
		params = startParams

	func _to_string() -> String:
		return "Command: " + str(CommandType.keys()[type]) + ", " + str(Easing.keys()[easing]) + ", " + str(startTime) + ", " + str(endTime) + ", " + str(params)

class Sprite:
	var layer: Layer
	var origin: Origin
	var filepath: String
	var x: int
	var y: int
	var commands: Array[SpriteCommand]

	func _init(startLayer: Layer, startOrigin: Origin, startFilepath: String, startX: int, startY: int):
		layer = startLayer
		origin = startOrigin
		filepath = startFilepath
		x = startX
		y = startY
	
	func _to_string() -> String:
		var ret: String = "Sprite: " + str(Layer.keys()[layer]) + ", " + str(Origin.keys()[origin]) + ", " + filepath + ", " + str(x) + ", " + str(y)
		for command in commands:
			ret += "\n	" + command.to_string()
		return ret

