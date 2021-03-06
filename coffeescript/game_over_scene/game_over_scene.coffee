GameOverScene = cc.Scene.extend(
  speed: 1

  onEnter: ->
    @._super()

    @background = new BackgroundLayer()
    @ui = new GameOverLayer(@level)

    @.addChild(@background)
    @.addChild(@ui)
)