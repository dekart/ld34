GameLayer = cc.Layer.extend(
  location: null
  currentLevel: null

  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    @ship = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("ship.png"))

    @ship.setPosition(windowSize.width / 2, windowSize.height * 0.1)

    @.addChild(@ship)

    @shield = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("shield.png"))

    @shield.setPosition(windowSize.width / 2, windowSize.height * 0.13)

    @.addChild(@shield)

    @shield.setVisible(false)

    cc.eventManager.addListener(
      event: cc.EventListener.KEYBOARD
      onKeyPressed: (e)=> @.onKeyPressed(e),
      @
    )

  onKeyPressed: (keycode)->
    switch keycode
      when 32
        @shield.setVisible(!@shield.isVisible())
      else
        console.log("key pressed: ", keycode)
)
