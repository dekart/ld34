NextLevelScene = cc.Scene.extend(
  speed: 1

  onEnter: ->
    @._super()

    @speed += globals.speedGrowthPerLevel

    @background = new BackgroundLayer()
    @ui = new NextLevelLayer(@level)

    @.addChild(@background)
    @.addChild(@ui)
)