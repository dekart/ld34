IntroLayer = cc.Layer.extend(
  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    @titleText = new cc.LabelTTF("Hyperspace", "Arial", 160)
    @titleText.setFontFillColor(cc.color(0, 180, 255))
    @titleText.setPosition(windowSize.width * 0.5, windowSize.height * 0.75)

    @.addChild(@titleText)

    @instructionText = new cc.LabelTTF("Collect fuel crates to grow your speed.\n\nPress Space to rise shields.\nPress Z to fire rockets.\n\nTurn on Full Screen for smoother art.", "Arial", 60)
    @instructionText.setFontFillColor(cc.color(255, 255, 255))
    @instructionText.textAlign = cc.TEXT_ALIGNMENT_CENTER
    @instructionText.setPosition(windowSize.width * 0.5, windowSize.height * 0.45)

    @.addChild(@instructionText)

    @fullScreenButton = new ccui.Button()
    @fullScreenButton.loadTextureNormal("full_screen.png", ccui.Widget.PLIST_TEXTURE)
    @fullScreenButton.setPosition(windowSize.width * 0.5, windowSize.height * 0.30)
    @fullScreenButton.addTouchEventListener(@.onfullScreenTouch, @)

    @.addChild(@fullScreenButton)

    @startButton = new ccui.Button()
    @startButton.loadTextureNormal("button.png", ccui.Widget.PLIST_TEXTURE)
    @startButton.setPosition(windowSize.width * 0.5, windowSize.height * 0.15)
    @startButton.addTouchEventListener(@.onStartTouch, @)

    @.addChild(@startButton)

    @startButtonText = new cc.LabelTTF("Start Game", "Arial", 60)
    @startButtonText.setFontFillColor(cc.color(255, 255, 130))
    @startButtonText.setPosition(windowSize.width * 0.5, windowSize.height * 0.15)

    @.addChild(@startButtonText)


  onStartTouch: (sender, type)->
    if type == ccui.Widget.TOUCH_ENDED
      first_level = new GameScene()
      first_level.level = 1

      cc.director.runScene(first_level)

  onfullScreenTouch: (sender, type)->
    element = document.getElementById("body")

    if element.requestFullscreen?
      element.requestFullscreen()
    else if element.msRequestFullscreen?
      element.msRequestFullscreen()
    else if element.mozRequestFullScreen?
      element.mozRequestFullScreen()
    else if element.webkitRequestFullscreen?
      element.webkitRequestFullscreen()
)