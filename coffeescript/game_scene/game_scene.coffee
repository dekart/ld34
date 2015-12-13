GameScene = cc.Scene.extend(
  speed: 0.5

  onEnter: ->
    @._super()

    @background = new BackgroundLayer()
    @background.speed = @speed

    @game = new GameLayer()
    @game.speed = @speed

    @particles = new ParticleLayer()
    @ui = new UILayer()

    @.addChild(@background)
    @.addChild(@game)
    @.addChild(@particles)
    @.addChild(@ui)
)