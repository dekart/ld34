GameLayer = cc.Layer.extend(
  location: null
  currentLevel: null

  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("player.png"))

    sprite.setPosition(windowSize.width / 2, windowSize.height / 2)

    @.addChild(sprite)

)
