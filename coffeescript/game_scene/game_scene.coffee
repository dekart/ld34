GameScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    @background = new BackgroundLayer()
    @game = new GameLayer()
    @particles = new ParticleLayer()
    @ui = new UILayer()

    @.addChild(@background)
    @.addChild(@game)
    @.addChild(@particles)
    @.addChild(@ui)
)