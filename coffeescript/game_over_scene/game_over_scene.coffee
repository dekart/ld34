GameOverScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    @background = new BackgroundLayer()
    @ui = new GameOverLayer()

    @.addChild(@background)
    @.addChild(@ui)
)