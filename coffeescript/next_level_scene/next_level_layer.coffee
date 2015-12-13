NextLevelLayer = cc.Layer.extend(
  ctor: (@level)->
    @._super()

    windowSize = cc.director.getWinSize()

    @titleText = new cc.LabelTTF("Level #{ @level } Complete!", "Arial", 120)
    @titleText.setFontFillColor(cc.color(0, 180, 255))
    @titleText.setPosition(windowSize.width * 0.5, windowSize.height * 0.75)

    @.addChild(@titleText)

    @instructionText = new cc.LabelTTF("Starting speed grows with every level.", "Arial", 60)
    @instructionText.setFontFillColor(cc.color(255, 255, 255))
    @instructionText.textAlign = cc.TEXT_ALIGNMENT_CENTER
    @instructionText.setPosition(windowSize.width * 0.5, windowSize.height * 0.45)

    @.addChild(@instructionText)

    @nextLevelButton = new ccui.Button()
    @nextLevelButton.loadTextureNormal("button.png", ccui.Widget.PLIST_TEXTURE)
    @nextLevelButton.setPosition(windowSize.width * 0.5, windowSize.height * 0.15)
    @nextLevelButton.addTouchEventListener(@.onNextLevelTouch, @)

    @.addChild(@nextLevelButton)

    @buttonText = new cc.LabelTTF("Next Level", "Arial", 60)
    @buttonText.setFontFillColor(cc.color(255, 255, 130))
    @buttonText.setPosition(windowSize.width * 0.5, windowSize.height * 0.15)

    @.addChild(@buttonText)


  onNextLevelTouch: (sender, type)->
    if type == ccui.Widget.TOUCH_ENDED
      next_scene = new GameScene()
      next_scene.level = @level + 1

      cc.director.runScene(next_scene)
)