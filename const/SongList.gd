extends RefCounted

class_name SongList

static var tutorial: Song = Song.new(
	"Kevin MacLeod", "Scheming Weasel (faster)",
	[20368, 20608, 20726, 20964, 21082, 21440, 21797, 22511, 23226, 23466, 23584, 23822, 23940, 25368, 26083, 26323, 26441, 26679, 26797, 27155, 27512, 28226, 63226, 63464, 63583, 63821, 63940, 64297, 64654, 65011, 65368, 66083, 66321, 66440, 66678, 66797, 67154, 67511, 68226, 68940, 69178, 69297, 69535, 69654, 70011, 70368, 70726, 71083, 71797, 72035, 72154, 72392, 72511, 72868, 73226, 73940, 74654, 74892, 75011, 75249, 75368, 75607, 75726, 75964, 76083, 76321, 76440, 76678, 76797, 77035, 77154, 77392, 77511, 78583, 78821, 78940, 80368, 80607, 80726, 80964, 81083, 81321, 81440, 81678, 81797, 82035, 82154, 82392, 82511, 82749, 82868, 83107, 83226, 84297, 84654, 85368],
	preload("res://assets/songs/tutorial/audio.mp3"),
	"tutorial",
	[]
)

static var songs: Array[Song] = [
	Song.new(
		"LeaF", "MARENOL",
		[1698, 1751, 1805, 1858, 1912, 1965, 2019, 2073, 2126, 2179, 2233, 2286, 2340, 2393, 2447, 2501, 2555, 2608, 2662, 2715, 2769, 2822, 2876, 2930, 2983, 3036, 3090, 3143, 3197, 3250, 3304, 3358, 3412, 4269, 4376, 4590, 4698, 4912, 5126, 5555, 5769, 5983, 6198, 6412, 6840, 7269, 7483, 7698, 7912, 8126, 8555, 8983, 9198, 9412, 9626, 9840, 10269, 10483, 10698, 10912, 11019, 11126, 11233, 11340, 11555, 11769, 11876, 11983, 12198, 12412, 12626, 12733, 12840, 12948, 13055, 13269, 13483, 13590, 13698, 13912, 14126, 14340, 14448, 14555, 14662, 14769, 14983, 15198, 15305, 15412, 15519, 15626, 15733, 15840, 15948, 16055, 16162, 16269, 16376, 16483, 16590, 16698, 16805, 16912, 17019, 17126, 18198, 18412, 18626, 18840, 19162, 19269, 19483, 19698, 19912, 20019, 20126, 20340, 20555, 20877, 20984, 21198, 21413, 21627, 21734, 21841, 22055, 22269, 22591, 22698, 22912, 23127, 23341, 23448, 23555, 23769, 23983, 24412, 24840, 25269, 25323, 25376, 25430, 25483, 25537, 25590, 25644, 25698, 26019, 26126, 26340, 26555, 26769, 26876, 26983, 27198, 27412, 27519, 27626, 27840, 28055, 28269, 28483, 28591, 28698, 29126, 29555, 29662, 29769, 29876, 29983, 30198, 30305, 30412, 30626, 30840, 31055, 31162, 31269, 31483, 31698, 32126, 32555, 34055, 34269, 34698, 35126, 35555, 35983, 36412, 36840, 37269, 37698, 38126, 38555, 38983, 39412, 39519, 39626, 39733, 39840, 39948, 40055, 40162, 40269, 40376, 40483, 40590, 40698, 40805, 40912, 41019, 41126, 41233, 41340, 41448, 41555, 41662, 41769, 41876, 41983, 42090, 42198, 42305, 42412, 42519, 42626, 42733, 42840, 42894, 42948, 43001, 43055, 43162, 43269, 43376, 43483, 43537, 43590, 43644, 43698, 43805, 43858, 43912, 44019, 44126, 44180, 44233, 44287, 44340, 44394, 44448, 44501, 44555, 46269, 47126, 47983, 48840, 49698, 50555, 51412, 52269, 53126, 53983, 54126, 54269, 54412, 54555, 54698, 54840, 55269, 55412, 55555, 55698, 56126, 56555, 57412, 57840, 58055, 58269, 58698, 58840, 58983, 59126, 59555, 59983, 60840, 60983, 61126, 61269, 61412, 61555, 61698, 62126, 62269, 62412, 62555, 62983, 63412, 66840, 67698, 67751, 67805, 67858, 67912, 67965, 68019, 68072, 68126, 68179, 68233, 68286, 68340, 68393, 68447, 68500, 68555, 69413, 69466, 69520, 69573, 69627, 69680, 69734, 69787, 69841, 69894, 69948, 70001, 70055, 70108, 70162, 70215, 70269, 71127, 71180, 71234, 71287, 71341, 71394, 71448, 71501, 71555, 71608, 71662, 71715, 71769, 71822, 71876, 71929, 71983, 72841, 72894, 72948, 73001, 73055, 73108, 73162, 73215, 73269, 73322, 73376, 73429, 73483, 73536, 73590, 73643, 73698, 75412, 75840, 75983, 76126, 76269, 76698, 76983, 77126, 77555, 77608, 77662, 77715, 77769, 77876, 77983, 78269, 78555, 78840, 79126, 79269, 79412, 79555, 79698, 80126, 80555, 80983, 81037, 81090, 81144, 81198, 81412, 81519, 81573, 81626, 81680, 81733, 81840, 81983, 82126, 82269, 82555, 82698, 82769, 82840, 82912, 82983, 83055, 83126, 83340, 83555, 83983, 84198, 84269, 84412, 84483, 84555, 84626, 84698, 84769, 84840, 85055, 85126, 85198, 85269, 85412, 85555, 85698, 87412, 87626, 89126, 89340, 90840, 91055, 92555, 92769, 94269, 94483, 95983, 96198, 97698, 97912, 99412, 99465, 99519, 99572, 99626, 99679, 99733, 99787, 99840, 99893, 99947, 100000, 100054, 100107, 100161, 100215, 100269, 100322, 100376, 100429, 100483, 100536, 100590, 100644, 100697, 100750, 100804, 100857, 100911, 100964, 101018, 101072, 101126, 101555, 101769, 101876, 101983, 102198, 102412, 102840, 103269, 103483, 103590, 103698, 103912, 104126, 104555, 104769, 104983, 105198, 105412, 105626, 105840, 106055, 106269, 106483, 106698, 106912, 107126, 107340, 107555, 107983, 108412, 108626, 108733, 108840, 109055, 109269, 109698, 110126, 110340, 110448, 110555, 110769, 110983, 111412, 111626, 111840, 112055, 112269, 112483, 112698, 112912, 113126, 113340, 113555, 113769, 113983, 114198, 114412, 114840, 115162, 115269, 115483, 115590, 115697, 115805, 115912, 116126, 116554, 116983, 117197, 117304, 117412, 117626, 117840, 118269, 118483, 118590, 118697, 118912, 119126, 119233, 119340, 119554, 119769, 119983, 120197, 120412, 120626, 120840, 121054, 121269, 121698, 122020, 122127, 122341, 122448, 122555, 122663, 122770, 122984, 123412, 123841, 124055, 124162, 124270, 124484, 124698, 125127, 125341, 125448, 125555, 125770, 125984, 126091, 126198, 126412, 126627, 126841, 127055, 127270, 127484, 127698, 127912, 128127, 128555, 129412, 129626, 129840, 130698, 131126, 131340, 131555, 132840, 133269, 133698, 134126, 134555, 134983, 135412, 136269, 136483, 136698, 137555, 137983, 138198, 138412, 139698, 139912, 140126, 140340, 140555, 140983, 141412, 141840, 142269, 142275, 142282, 142288],
		preload("res://assets/songs/marenol/audio.mp3"),
		"marenol",
		[35126, 46269],
		"Dikcy?"
	),
	Song.new(
		"LeaF", "Mopemope",
		[2379, 2529, 2679, 2829, 2979, 3129, 3279, 3429, 3579, 3729, 3879, 4029, 4179, 4329, 4479, 4629, 4779, 4929, 5079, 5229, 5379, 5529, 5679, 5829, 5979, 6129, 6279, 6429, 6579, 6729, 6879, 7029, 7179, 7479, 7779, 8079, 8379, 8529, 8679, 8829, 8979, 9279, 9429, 9579, 9879, 10029, 10179, 10479, 10779, 11079, 11379, 11454, 11529, 11604, 11679, 11754, 11829, 11904, 11979, 12279, 12579, 12879, 13179, 13329, 13479, 13629, 13779, 14079, 14229, 14379, 14679, 14829, 14979, 15279, 15579, 15879, 16179, 16254, 16329, 16404, 16479, 16554, 16629, 16704, 16779, 17079, 17229, 17379, 17679, 17979, 18129, 18279, 18429, 18579, 18879, 19029, 19179, 19479, 19629, 19779, 20079, 20379, 20679, 20979, 21054, 21129, 21204, 21279, 21354, 21429, 21504, 21579, 21879, 22029, 22179, 22479, 22779, 22929, 23079, 23229, 23379, 23679, 23829, 23979, 24279, 24429, 24579, 24879, 25179, 25479, 25497, 25779, 25797, 26079, 26229, 26379, 26679, 26829, 26979, 27279, 27579, 27729, 27879, 28029, 28179, 28479, 28629, 28779, 29079, 29229, 29379, 29679, 29979, 30279, 30579, 30654, 30729, 30804, 30879, 30954, 31029, 31104, 31179, 31479, 31629, 31779, 32079, 32379, 32529, 32679, 32829, 32979, 33279, 33429, 33579, 33879, 34029, 34179, 34479, 34779, 35079, 35379, 35454, 35529, 35604, 35679, 35754, 35829, 35904, 35979, 36579, 37179, 37779, 38379, 38979, 39579, 40179, 40779, 41379, 41979, 42579, 43179, 43329, 43629, 43779, 44079, 44379, 44679, 44829, 44979, 46179, 46779, 47379, 47979, 48579, 49179, 49779, 50379, 50979, 51279, 51429, 51579, 51879, 52179, 52329, 52479, 52629, 52779, 53079, 53229, 53379, 53679, 53829, 53979, 54279, 54579, 54879, 55179, 55254, 55329, 55404, 55479, 55554, 55629, 55704, 55779, 56079, 56229, 56379, 56679, 56979, 57129, 57279, 57429, 57579, 57879, 58029, 58179, 58479, 58629, 58779, 59079, 59379, 59679, 59979, 62079, 62154, 62229, 63129, 63204, 63279, 63354, 63729, 63804, 63879, 63954, 64029, 64104, 64179, 64779, 64854, 64929, 65004, 65079, 65154, 65229, 65304, 65379, 65979, 66204, 66429, 66579, 66654, 66729, 66804, 66879, 67029, 67104, 67179, 67329, 67479, 67629, 67779, 67929, 68004, 68079, 68154, 68229, 68379, 68454, 68529, 68679, 68754, 68829, 68979, 69129, 69279, 69354, 69429, 69504, 69579, 70179, 70329, 70404, 70479, 70629, 70779, 70854, 70929, 71004, 71079, 71154, 71229, 71304, 71379, 71529, 71679, 71829, 71979, 72129, 72279, 72429, 72579, 72654, 72729, 72804, 72879, 72954, 73029, 73104, 73179, 73329, 73479, 73629, 73779, 73929, 74079, 74229, 74379, 74454, 74529, 74604, 74679, 74754, 74829, 74904, 74979, 75054, 75129, 75279, 75429, 75579, 75654, 75729, 75879, 76029, 76179, 76254, 76329, 76479, 76554, 76629, 76779, 76929, 77079, 77154, 77229, 77304, 77379, 77679, 77754, 77829, 77979, 78129, 78204, 78279, 78429, 78579, 78654, 78729, 78804, 78879, 79029, 79179, 79254, 79329, 79404, 79479, 79554, 79629, 79704, 79779, 80079, 80379, 80679, 80979, 81129, 81279, 81429, 81579, 81879, 82029, 82179, 82479, 82629, 82779, 83079, 83379, 83679, 83979, 84579, 84879, 85179, 85479, 85779, 85929, 86079, 86229, 86379, 86679, 86829, 86979, 87279, 87429, 87579, 87879, 88179, 88479, 88779, 89379, 89398, 89979, 89998, 90579, 90598, 91179, 91198, 91779, 91798, 92379, 92398, 92979, 92998, 93579, 93598, 94179, 94198, 94779, 94798, 95379, 95398, 95979, 95998, 96579, 96598, 97179, 97198, 97779, 97798, 98379, 98398, 98979, 99279, 99579, 99879, 100179, 100329, 100479, 100629, 100779, 101079, 101229, 101379, 101679, 101829, 101979, 102279, 102579, 102879, 103179, 103254, 103329, 103404, 103479, 103554, 103629, 103704, 103779, 104079, 104379, 104679, 104979, 105129, 105279, 105429, 105579, 105879, 106029, 106179, 106629, 106779, 107079, 107379, 107979, 108279, 108579],
		preload("res://assets/songs/mopemope/audio.mp3"),
		"mopemope",
		[],
		"Memetius The Great"
	),

]

static func getSongs() -> Array[Song]:
	return songs