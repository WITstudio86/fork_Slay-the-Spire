extends Control

var card_szize := Vector2(25.0,30)

# 曲线准备
@export var x_curve : Curve
@export var y_curve : Curve
@export var angle_curve : Curve

@onready var cards := get_children()
@onready var count := cards.size()
# 宽度相关
@onready var width := size.x
@onready var max_width := size.x - card_szize.x
@onready var left := 0.0
# 高度相关
@onready var height := size.y
@onready var max_height := height - card_szize.y
@onready var top := 0.0 
# 角度相关
@onready var total_angle : float = 40.0
@onready var start_angle : float = -1.0 * (total_angle / 2)

func layout_cards():
	# 根据卡牌数量动态改变左侧起点和最大宽度 , 避免卡牌之间距离过大
	max_width = min(size.x - card_szize.x , card_szize.x * 0.7 * count)
	left = (width - max_width) / 2
	for i in range(count):
		var t : float = i / (count - 1.0) if count > 1 else 0.5
		# 宽度相关
		var x_percent = x_curve.sample(t)
		var x = left + x_percent * max_width
		# 高度相关
		var y_percent = y_curve.sample(t)
		var y = top + y_percent * max_height
		# 角度相关
		var angle_percent = angle_curve.sample(t)
		var angle = start_angle + angle_percent * total_angle
		# 应用根据曲线得到的值
		cards[i].position = Vector2(x , y)
		cards[i].rotation_degrees = angle

func _ready() -> void:
	layout_cards()

func _physics_process(_delta: float) -> void:
	layout_cards()
