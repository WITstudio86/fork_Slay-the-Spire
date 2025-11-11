# 复刻杀戮尖塔

## E1-c1
- 设置尺寸 256*144 , 覆盖尺寸1280*720
- 创建 Battle 场景, 添加背景修改位置和亮度
- 修改纹理渲染形式保证像素艺术的清晰 

## E1-c2
- 创建新的用户界面场景实现一张卡牌 CardUI
- 添加两个子节点
  - 颜色矩形 用于临时占位并区分状态 , Color\
  - 标签节点State
- 调整父节点尺寸 25 * 30 , 注意最小尺寸也需要修改, 不认 hbox 中会重叠 
- 颜色矩形锚点预设改为整个矩形
- State 添加文本 State, 居中对齐 , 并锚点预设为整个矩形
- 实现一个 theme
  - 在根目录下创建一个新资源 , theme , main_theme.tres
  - 右侧检测器中将默认字体设置为 pixel_rpg.ogg , 子号 6
- 将主题分配给根节点的 theme 属性
- 添加一个 Area2D DropPointDetector , 开启监视 , 关闭可被监视
- 重命名 layer1 为 card_target_selector , 取消 mask1  , 勾选 2 , 重命名为card_drop_area

- 在 Battle 中添加Area2D CardDropArea , layer 为 2 ,mask 为 1
- 添加 canvaslayer , BattleUI , layer 为 1 , 确保其在游戏本身只上渲染
  - 添加子节点Hbox , 在其中实例化卡片 , 多复制 2 张卡片
  - 锚点预设为底部居中 , 并将 layout 中的 size 改为 150 * 30px , 偏移可以重新锚点预设一下s

> todo: 实现扇形卡牌 
