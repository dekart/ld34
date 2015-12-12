GameScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    # Cache all used sprites here
    cc.spriteFrameCache.addSpriteFrames(resources.ui_plist)

    @background = new BackgroundLayer()
    @game = new GameLayer()

    @.addChild(@background)
    @.addChild(@game)
)