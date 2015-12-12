UILayer = cc.Layer.extend(
  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    @redFrame = new cc.Sprite(resources.red_frame_png)

    @redFrame.setPosition(windowSize.width / 2, windowSize.height /2)
    @redFrame.setLocalZOrder(255)
    @redFrame.setVisible(false)

    @.addChild(@redFrame)

    @speedFrame = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_frame.png"))

    @speedFrame.setPosition(windowSize.width * 0.95, windowSize.height * 0.15)


    @.addChild(@speedFrame)

    @speedMarkers = [
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_green.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_green.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_green.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_green.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_green.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_yellow.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_yellow.png"))
      new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_red.png"))
    ]


    for marker, index in @speedMarkers
      marker.setPosition(windowSize.width * 0.95, windowSize.height * (0.063 + 0.0245 * index))
      marker.setVisible(index == 0)

      @.addChild(marker)

  blinkRedFrame: ->
    @redFrame.stopAllActions()
    @redFrame.setVisible(true)
    @redFrame.setOpacity(255)

    @redFrame.runAction(
      new cc.Sequence(
        new cc.FadeTo(0.5, 0)
        new cc.CallFunc(()=>
          @redFrame.setVisible(false)
        )
      )
    )
)