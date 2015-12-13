GameScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    @speed = globals.startingSpeed + (@level - 1) * globals.speedGrowthPerLevel

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