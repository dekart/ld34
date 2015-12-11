BackgroundLayer = cc.Layer.extend(
  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    sprite = new cc.Sprite(resources.background_jpg)

    sprite.setPosition(windowSize.width / 2, windowSize.height / 2)

    @.addChild(sprite)
)
