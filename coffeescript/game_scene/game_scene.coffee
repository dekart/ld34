GameScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    # Cache all used sprites here
    cc.spriteFrameCache.addSpriteFrames(resources.ui_plist)

    @background = new BackgroundLayer()
    @game = new GameLayer()
    @particles = new ParticleLayer()

    @.addChild(@background)
    @.addChild(@game)
    @.addChild(@particles)
)