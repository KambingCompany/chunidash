extends Control

@export var song: Song
@onready var projectile_controller: ProjectileController = $ProjectileController
@onready var rhythm_bar: RhythmBar = $PlayerContainer/Container/CharacterController/RhythmBar

var projectile = preload("res://scenes/Projectile.tscn")
var converter = OsbConverter.new()

func create_projectile(commands: Array[Command], start_position: Vector2, is_ghost: bool, texture: Texture):
	var p = projectile.instantiate()
	p.commands = commands
	p.start_position = start_position
	p.is_ghost = is_ghost
	p.start_time = commands[0].start_time
	p.texture = texture
	for command in commands:
		command.object = p
	return p

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	song = Song.new()
	song.rhythm = [2379, 2529, 2679, 2829, 2979, 3129, 3279, 3429, 3579, 3729, 3879, 4029, 4179, 4329, 4479, 4629, 4779, 4929, 5079, 5229, 5379, 5529, 5679, 5829, 5979, 6129, 6279, 6429, 6579, 6729, 6879, 7029, 7179, 7479, 7779, 8079, 8379, 8529, 8679, 8829, 8979, 9279, 9429, 9579, 9879, 10029, 10179, 10479, 10779, 11079, 11379, 11454, 11529, 11604, 11679, 11754, 11829, 11904, 11979, 12279, 12579, 12879, 13179, 13329, 13479, 13629, 13779, 14079, 14229, 14379, 14679, 14829, 14979, 15279, 15579, 15879, 16179, 16254, 16329, 16404, 16479, 16554, 16629, 16704, 16779, 17079, 17229, 17379, 17679, 17979, 18129, 18279, 18429, 18579, 18879, 19029, 19179, 19479, 19629, 19779, 20079, 20379, 20679, 20979, 21054, 21129, 21204, 21279, 21354, 21429, 21504, 21579, 21879, 22029, 22179, 22479, 22779, 22929, 23079, 23229, 23379, 23679, 23829, 23979, 24279, 24429, 24579, 24879, 25179, 25479, 25497, 25779, 25797, 26079, 26229, 26379, 26679, 26829, 26979, 27279, 27579, 27729, 27879, 28029, 28179, 28479, 28629, 28779, 29079, 29229, 29379, 29679, 29979, 30279, 30579, 30654, 30729, 30804, 30879, 30954, 31029, 31104, 31179, 31479, 31629, 31779, 32079, 32379, 32529, 32679, 32829, 32979, 33279, 33429, 33579, 33879, 34029, 34179, 34479, 34779, 35079, 35379, 35454, 35529, 35604, 35679, 35754, 35829, 35904, 35979, 36579, 37179, 37779, 38379, 38979, 39579, 40179, 40779, 41379, 41979, 42579, 43179, 43329, 43629, 43779, 44079, 44379, 44679, 44829, 44979, 46179, 46779, 47379, 47979, 48579, 49179, 49779, 50379, 50979, 51279, 51429, 51579, 51879, 52179, 52329, 52479, 52629, 52779, 53079, 53229, 53379, 53679, 53829, 53979, 54279, 54579, 54879, 55179, 55254, 55329, 55404, 55479, 55554, 55629, 55704, 55779, 56079, 56229, 56379, 56679, 56979, 57129, 57279, 57429, 57579, 57879, 58029, 58179, 58479, 58629, 58779, 59079, 59379, 59679, 59979, 62079, 62154, 62229, 63129, 63204, 63279, 63354, 63729, 63804, 63879, 63954, 64029, 64104, 64179, 64779, 64854, 64929, 65004, 65079, 65154, 65229, 65304, 65379, 65979, 66204, 66429, 66579, 66654, 66729, 66804, 66879, 67029, 67104, 67179, 67329, 67479, 67629, 67779, 67929, 68004, 68079, 68154, 68229, 68379, 68454, 68529, 68679, 68754, 68829, 68979, 69129, 69279, 69354, 69429, 69504, 69579, 70179, 70329, 70404, 70479, 70629, 70779, 70854, 70929, 71004, 71079, 71154, 71229, 71304, 71379, 71529, 71679, 71829, 71979, 72129, 72279, 72429, 72579, 72654, 72729, 72804, 72879, 72954, 73029, 73104, 73179, 73329, 73479, 73629, 73779, 73929, 74079, 74229, 74379, 74454, 74529, 74604, 74679, 74754, 74829, 74904, 74979, 75054, 75129, 75279, 75429, 75579, 75654, 75729, 75879, 76029, 76179, 76254, 76329, 76479, 76554, 76629, 76779, 76929, 77079, 77154, 77229, 77304, 77379, 77679, 77754, 77829, 77979, 78129, 78204, 78279, 78429, 78579, 78654, 78729, 78804, 78879, 79029, 79179, 79254, 79329, 79404, 79479, 79554, 79629, 79704, 79779, 80079, 80379, 80679, 80979, 81129, 81279, 81429, 81579, 81879, 82029, 82179, 82479, 82629, 82779, 83079, 83379, 83679, 83979, 84579, 84879, 85179, 85479, 85779, 85929, 86079, 86229, 86379, 86679, 86829, 86979, 87279, 87429, 87579, 87879, 88179, 88479, 88779, 89379, 89398, 89979, 89998, 90579, 90598, 91179, 91198, 91779, 91798, 92379, 92398, 92979, 92998, 93579, 93598, 94179, 94198, 94779, 94798, 95379, 95398, 95979, 95998, 96579, 96598, 97179, 97198, 97779, 97798, 98379, 98398, 98979, 99279, 99579, 99879, 100179, 100329, 100479, 100629, 100779, 101079, 101229, 101379, 101679, 101829, 101979, 102279, 102579, 102879, 103179, 103254, 103329, 103404, 103479, 103554, 103629, 103704, 103779, 104079, 104379, 104679, 104979, 105129, 105279, 105429, 105579, 105879, 106029, 106179, 106629, 106779, 107079, 107379, 107979, 108279, 108579]
	song.audio = preload("res://assets/songs/mopemope/audio.mp3")
	song.artist = "AAAA"
	song.title = "carnation"
	song.base_dir = "mopemope"
	
	rhythm_bar.note_judged.connect(_on_rhythm_bar_note_judged)
	
	projectile_controller.command_queue = converter.parse_osb_to_projectiles(song.base_dir)
	$AudioController.set_audio(song.audio)
	$AudioController.start()
	rhythm_bar.load(song.rhythm)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rhythm_bar.current_time = $AudioController.current_time
	projectile_controller.current_time = $AudioController.current_time


func _on_rhythm_bar_note_judged(judgement: int) -> void:
	if judgement == RhythmBar.Judgement.GREAT:
		rhythm_bar.flash_color(Color.SKY_BLUE)
	elif judgement == RhythmBar.Judgement.GOOD:
		rhythm_bar.flash_color(Color.GREEN)
	elif judgement == RhythmBar.Judgement.MISS:
		rhythm_bar.flash_color(Color.RED)
