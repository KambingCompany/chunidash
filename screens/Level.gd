extends Control

@export var song: Song
@onready var projectile_controller: ProjectileController = $ProjectileController

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
	song.rhythm = [93, 843, 1218, 1593, 2343, 2718, 3093, 3843, 4218, 4593, 5155, 5343, 6046, 6093, 6889, 7218, 7593, 7968, 8343, 8718, 9093, 9116, 9843, 10218, 10593, 11155, 11343, 11436, 11530, 11624, 11718, 11811, 11905, 11999, 12093, 12116, 12280, 12374, 12468, 12655, 12749, 12843, 13030, 13218, 13593, 13780, 13968, 14155, 14343, 14624, 14718, 15093, 15561, 15655, 15749, 15843, 16030, 16124, 16218, 16311, 16405, 16499, 16593, 16780, 16803, 16968, 16991, 17155, 17178, 17343, 17366, 17624, 17647, 17718, 17741, 17999, 18093, 18116, 18374, 18397, 18468, 18491, 18655, 18678, 18843, 18866, 19218, 19311, 19405, 19499, 19593, 19968, 20343, 20530, 20718, 21093, 21468, 21843, 22218, 22405, 22593, 22780, 22968, 23155, 23343, 23530, 23718, 23905, 24093, 24655, 24749, 24843, 25593, 29718, 29905, 30093, 30468, 30843, 31218, 31593, 32343, 32718, 32905, 33093, 33468, 33843, 34218, 34593, 35155, 35343, 35718, 35811, 35905, 35999, 36093, 36468, 36843, 37218, 37405, 37499, 37593, 37968, 38155, 38343, 38530, 38718, 38905, 39093, 39468, 39655, 39749, 39843, 40218, 40593, 40616, 40686, 40780, 40874, 40968, 40991, 41061, 41155, 41249, 41343, 41366, 41436, 41530, 41624, 41718, 41741, 41811, 41905, 41999, 42093, 42116, 42186, 42280, 42374, 42468, 42491, 42561, 42655, 42749, 42843, 42866, 42936, 43030, 43124, 43218, 43241, 43311, 43405, 43499, 43593, 43616, 43686, 43780, 43874, 43968, 43991, 44061, 44155, 44249, 44343, 44366, 44436, 44530, 44624, 44718, 44741, 44811, 44905, 44999, 45093, 45116, 45186, 45280, 45374, 45468, 45491, 45561, 45655, 45749, 45843, 45866, 45936, 46030, 46124, 46218, 46241, 46311, 46405, 46499, 46593, 46616, 46968, 47343, 47718, 48093, 48843, 49218, 49405, 49593, 49968, 50343, 50718, 51093, 51655, 51843, 52218, 52311, 52405, 52499, 52593, 52616, 52968, 53343, 53366, 53718, 53905, 53999, 54093, 54116, 54468, 54655, 54843, 55030, 55218, 55405, 55593, 55616, 55968, 56155, 56249, 56343, 56718, 57093, 57116, 57655, 57843, 58030, 58218, 58405, 58593, 58616, 58874, 58897, 58968, 58991, 59155, 59249, 59343, 59436, 59530, 59624, 59718, 59811, 59905, 59999, 60093, 60116, 60374, 60397, 60468, 60491, 60655, 60749, 60843, 60936, 61030, 61124, 61218, 61311, 61405, 61499, 61593, 61616, 61874, 61897, 61968, 61991, 62155, 62249, 62343, 62436, 62530, 62624, 62718, 62811, 62905, 62999, 63093, 63468, 63655, 63843, 64030, 64218, 64405, 64593, 64616, 64874, 64897, 64968, 64991, 65155, 65249, 65343, 65436, 65530, 65624, 65718, 65811, 65905, 65999, 66093, 66116, 66374, 66397, 66468, 66491, 66749, 66843, 66936, 67030, 67124, 67218, 67311, 67405, 67499, 67593, 67874, 67968, 68155, 68249, 68343, 68530, 68624, 68718, 68811, 68905, 68999, 69093, 69374, 69468, 69749, 69843, 70124, 70218, 70499, 70593, 70874, 70968, 71249, 71343, 71530, 71624, 71717, 71811, 71905, 71999, 72093, 72374, 72468, 72749, 72843, 73124, 73218, 73499, 73593, 73874, 73968, 74155, 74343, 74436, 74530, 74624, 74718, 74811, 74905, 74999, 75093, 76030, 79593, 80343, 80718, 81093, 81843, 82218, 82593, 83343, 83718, 84093, 84655, 84843, 85593, 86343, 86718, 87093, 87468, 87843, 88218, 88593, 88968, 89343, 89718, 90093, 90843, 91218, 91311, 91405, 91499, 91593, 91616, 92343, 92593, 92843, 93093, 93843, 94593, 95343, 96093, 96843, 97093, 97343, 97593, 97616, 98343, 98593, 98843, 99093, 99116, 99468, 99843, 100218, 100593, 100616, 100718, 100843, 100968, 100991, 101093, 101218, 101343, 101366, 101468, 101593, 101718, 101741, 101843, 101968, 102093, 102116, 102218, 102343, 102468, 102491, 102593, 102718, 102843, 102866, 102968, 103093, 103218, 103241, 103311, 103405, 103499, 103593, 103616, 103968, 104343, 104718, 105093, 105116, 105843, 106093, 106100, 106343, 106358, 106593, 106616, 107343, 107718, 108093, 108116, 108468, 108749, 108843, 109124, 109218, 109311, 109405, 109499, 109593, 109968, 110155, 110249, 110343, 110436, 110530, 110624, 110718, 110811, 110905, 110999, 111093, 111186, 111280, 111374, 111468, 111561, 111655, 111749, 111843, 111937, 112031, 112125, 112218, 112312, 112406, 112500, 112593, 113343, 113718, 114093, 114843, 115030, 115218, 115405, 115593, 115616, 115874, 115897, 115968, 115991, 116155, 116249, 116343, 116436, 116530, 116624, 116718, 116811, 116905, 116999, 117093, 117116, 117374, 117397, 117468, 117491, 117655, 117749, 117843, 117936, 118030, 118124, 118218, 118311, 118405, 118499, 118593, 118616, 118874, 118897, 118968, 118991, 119155, 119249, 119343, 119436, 119530, 119624, 119718, 119811, 119905, 119999, 120093, 120468, 120655, 120843, 121030, 121218, 121405, 121593, 121616, 121874, 121897, 121968, 121991, 122155, 122249, 122343, 122436, 122530, 122624, 122718, 122811, 122905, 122999, 123093, 123116, 123374, 123397, 123468, 123491, 123749, 123843, 123936, 124030, 124124, 124218, 124311, 124405, 124499, 124593, 124874, 124968, 125155, 125249, 125343, 125530, 125624, 125718, 125811, 125905, 125999, 126093, 126374, 126468, 126749, 126843, 127124, 127218, 127499, 127593, 127874, 127968, 128249, 128343, 128530, 128624, 128717, 128811, 128905, 128999, 129093, 129374, 129468, 129749, 129843, 130124, 130218, 130499, 130593, 130874, 130968, 131155, 131343, 131436, 131530, 131624, 131718, 131811, 131905, 131999, 132093, 133030, 138093, 138843, 139218, 139593, 140343, 140718, 141093, 141843, 142218, 142593, 143343, 143718, 144093, 144843, 145218, 145593, 145968, 146343, 146718, 147093, 147843, 148093, 148343, 148593]
	song.audio = preload("res://assets/songs/spaceinvaders/audio.mp3")
	song.artist = "AAAA"
	song.title = "carnation"
	song.base_dir = "spaceinvaders"
	
	projectile_controller.projectiles = converter.parse_osb_to_projectiles(song.base_dir)
	$AudioController.set_audio(song.audio)
	$AudioController.start()
	$RhythmBar.load(song.rhythm)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$RhythmBar.current_time = $AudioController.current_time
	projectile_controller.current_time = $AudioController.current_time


func _on_rhythm_bar_note_judged(judgement: int) -> void:
	if judgement == RhythmBar.Judgement.GREAT:
		$RhythmBar.flash_color(Color.SKY_BLUE)
	elif judgement == RhythmBar.Judgement.GOOD:
		$RhythmBar.flash_color(Color.GREEN)
	elif judgement == RhythmBar.Judgement.MISS:
		$RhythmBar.flash_color(Color.RED)
