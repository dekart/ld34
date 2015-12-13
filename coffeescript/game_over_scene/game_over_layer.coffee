GameOverLayer = cc.Layer.extend(
  ctor: (@level)->
    @._super()

    windowSize = cc.director.getWinSize()

    @gameOverText = new cc.LabelTTF("Game Over", "Arial", 160)
    @gameOverText.setFontFillColor(cc.color(0, 180, 255))
    @gameOverText.setPosition(windowSize.width * 0.5, windowSize.height * 0.55)

    @.addChild(@gameOverText)

    @instructionText = new cc.LabelTTF("Your highest level: #{@level}\nPlease vote and share you score :)", "Arial", 60)
    @instructionText.setFontFillColor(cc.color(255, 255, 255))
    @instructionText.textAlign = cc.TEXT_ALIGNMENT_CENTER
    @instructionText.setPosition(windowSize.width * 0.5, windowSize.height * 0.45)

    @.addChild(@instructionText)

    @retryButton = new ccui.Button()
    @retryButton.loadTextureNormal("button.png", ccui.Widget.PLIST_TEXTURE)
    @retryButton.setPosition(windowSize.width * 0.5, windowSize.height * 0.35)
    @retryButton.addTouchEventListener(@.onRestartTouch, @)

    @.addChild(@retryButton)

    @instructionText = new cc.LabelTTF("Try Again", "Arial", 60)
    @instructionText.setFontFillColor(cc.color(255, 255, 130))
    @instructionText.setPosition(windowSize.width * 0.5, windowSize.height * 0.35)

    @.addChild(@instructionText)


  onRestartTouch: (sender, type)->
    if type == ccui.Widget.TOUCH_ENDED
      document.location = document.location
)