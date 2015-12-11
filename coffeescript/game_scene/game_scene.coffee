GameScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    # Cache all used sprites here
    cc.spriteFrameCache.addSpriteFrames(resources.ui_plist)

    @.addChild(new BackgroundLayer())
    @.addChild(new GameLayer())
)