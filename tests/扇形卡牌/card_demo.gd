extends Control

# ------------------------------
# 曲线资源，用于控制卡牌的不同属性
# ------------------------------
@export var pos_curve:Curve       # 水平位置曲线 (0~1)，控制卡牌在 X 方向的位置
@export var angle_curve:Curve     # 旋转角度曲线 (0~1)，控制卡牌旋转
@export var height_curve:Curve    # 垂直位置曲线 (0~1)，控制卡牌在 Y 方向的偏移

# ------------------------------
# 重要节点
# ------------------------------
@onready var card_root: Control = %CardRoot   # 卡牌父节点，所有卡牌的容器
@onready var card: Control = $CardRoot/Card  # 单张卡牌模板（用于获取卡牌大小等）

# ------------------------------
# 容器宽度相关
# ------------------------------
@onready var width = card_root.size.x         # 父容器宽度
@onready var max_width = card_root.size.x - card.size.x   # 最大可用水平空间，减去单张卡牌宽度
@onready var left = 0                         # 最左边的起点，当前设置为 0（左上角对齐）

# ------------------------------
# 扇形角度相关
# ------------------------------
@onready var total_angle = 60                 # 扇形总角度
@onready var start_angle = -1 * (total_angle / 2.0)  # 扇形起始角度（中心对称）

# ------------------------------
# 容器高度相关
# ------------------------------
@onready var height = card_root.size.y       # 父容器高度
@onready var max_height = card_root.size.y - card.size.y   # 最大可用垂直空间
@onready var bottom = 0                       # Y 坐标起点，左上角为 0

# ------------------------------
# 布局函数
# ------------------------------
func layout_cards():
	var cards = card_root.get_children()               # 获取所有卡牌节点
	var count : float = cards.size()                   # 卡牌总数
	
	for i in range(count):
		# 归一化索引 t ∈ [0,1]
		var t = i / (count - 1) if count > 1 else 0.5
		
		# ------------------------------
		# X 坐标计算
		# ------------------------------
		var x_percent = pos_curve.sample(t)            # 通过曲线获取水平位置百分比
		var x = left + max_width * x_percent          # 计算最终 X 坐标
		
		# ------------------------------
		# Y 坐标计算
		# ------------------------------
		var y_percent = height_curve.sample(t)        # 通过高度曲线获取垂直百分比
		var y = bottom + max_height * y_percent      # 计算最终 Y 坐标
		# 注意：Control 坐标系 Y 向下为正
		
		# ------------------------------
		# 旋转角度计算
		# ------------------------------
		var angle_percent = angle_curve.sample(t)    # 获取角度曲线值 0~1
		var angle = start_angle + total_angle * angle_percent  # 映射到实际角度
		
		# ------------------------------
		# 应用到卡牌
		# ------------------------------
		cards[i].position = Vector2(x,y)            # 设置位置
		prints("card", i, "y:", cards[i].position.y)  # 调试输出
		cards[i].rotation_degrees = angle           # 设置旋转角度（单位：度）

# ------------------------------
# _ready 回调，初始化布局
# ------------------------------
func _ready() -> void:
	prints("height:", height, "maxHeight", max_height)  # 输出高度信息用于调试
	layout_cards()                                     # 布局卡牌

# ------------------------------
# _physics_process 回调，可实时更新布局（目前禁用）
# ------------------------------
func _physics_process(_delta: float) -> void:
	# layout_cards()   # 如果想实时更新，可取消注释
	pass
