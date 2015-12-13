GameOverLayer = cc.Layer.extend(
  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    @gameOverText = new cc.LabelTTF("Game Over", "Arial", 160)
    @gameOverText.setFontFillColor(cc.color(0, 180, 255))
    @gameOverText.setPosition(windowSize.width * 0.5, windowSize.height * 0.55)

    @.addChild(@gameOverText)

    @instructionText = new cc.LabelTTF("Please reload page to restart the game", "Arial", 60)
    @instructionText.setFontFillColor(cc.color(255, 255, 130))
    @instructionText.setPosition(windowSize.width * 0.5, windowSize.height * 0.45)

    @.addChild(@instructionText)

)