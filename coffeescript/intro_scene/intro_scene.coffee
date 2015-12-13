IntroScene = cc.Scene.extend(
  speed: 1

  onEnter: ->
    @._super()

    @background = new BackgroundLayer()
    @ui = new IntroLayer()

    @.addChild(@background)
    @.addChild(@ui)
)