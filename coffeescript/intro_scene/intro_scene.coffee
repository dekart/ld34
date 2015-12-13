IntroScene = cc.Scene.extend(
  onEnter: ->
    @._super()

    @background = new BackgroundLayer()
    @ui = new IntroLayer()

    @.addChild(@background)
    @.addChild(@ui)
)