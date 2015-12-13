UILayer = cc.Layer.extend(
  warpLines: []

  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    @redFrame = new cc.Sprite(resources.red_frame_png)

    @redFrame.setPosition(windowSize.width / 2, windowSize.height /2)
    @redFrame.setLocalZOrder(255)
    @redFrame.setVisible(false)

    @.addChild(@redFrame)

    @speedFrame = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("speed_frame.png"))

    @speedFrame.setPosition(windowSize.width * 0.95, windowSize.height * 0.168)

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

      unless index == 0
        marker.setVisible(false)
        marker.setOpacity(0)

      @.addChild(marker)

    @fuelCollectedText = new cc.LabelTTF("0", "Arial", 60)
    @fuelCollectedText.setFontFillColor(cc.color(0, 180, 255))
    @fuelCollectedText.setPosition(windowSize.width * 0.95, windowSize.height * 0.03)

    @.addChild(@fuelCollectedText)

    @healthFrame = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("health_frame.png"))

    @healthFrame.setPosition(windowSize.width * 0.05, windowSize.height * 0.168)

    @.addChild(@healthFrame)

    @healthProgress = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("health_progress.png"))

    @healthProgress.setAnchorPoint(cc.p(0.5, 0))
    @healthProgress.setPosition(windowSize.width * 0.05, windowSize.height * 0.055)

    @.addChild(@healthProgress)

  decreaseHealth: (new_value)->
    @healthProgress.setScaleY(0.1 * new_value)

    @.blinkRedFrame()

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

  setFuelCollected: (new_value)->
    @fuelCollectedText.setString(new_value)

    if new_value % globals.fuelPerSpeedPoint == 0
      @.updateSpeedIndicator(new_value)

  updateSpeedIndicator: (new_fuel)->
    lastMarkerIndex = Math.floor(new_fuel / globals.fuelPerSpeedPoint)
    lastMarkerIndex = @speedMarkers.length - 1 if lastMarkerIndex >= @speedMarkers.length

    for i in [0..lastMarkerIndex]
      marker = @speedMarkers[i]

      unless marker.isVisible()
        marker.setVisible(true)
        marker.runAction(
          new cc.FadeTo(0.5, 255)
        )


  goToWarp: ->
    windowSize = cc.director.getWinSize()

    for i in [0..500]
      line = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("warp_line.png"))

      line.setPosition(
        windowSize.width * _.random(0, 300) * 0.01,
        windowSize.height * _.random(0, 300) * 0.01
      )

      line.setOpacity(0)

      @.addChild(line)

      line.runAction(
        cc.Spawn.create(
          cc.FadeTo.create(2, 255)
          cc.MoveBy.create(5, 0, -windowSize.height * 2)
        )
      )

)