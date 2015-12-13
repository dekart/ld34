BackgroundLayer = cc.Layer.extend(
  speed: 1

  ctor: ->
    @._super()

    @sprite1 = new cc.Sprite(resources.background_jpg)
    @sprite2 = new cc.Sprite(resources.background_jpg)
    @sprite1.setOpacity(100)
    @sprite2.setOpacity(100)

    @sprite3 = new cc.Sprite(resources.background_jpg)
    @sprite4 = new cc.Sprite(resources.background_jpg)

    @.addChild(@sprite1)
    @.addChild(@sprite2)
    @.addChild(@sprite3)
    @.addChild(@sprite4)

    @sprite1.setLocalZOrder(3)
    @sprite2.setLocalZOrder(4)
    @sprite3.setLocalZOrder(2)
    @sprite4.setLocalZOrder(1)

    @.scheduleOnce(=>
      @.scheduleForegroundMovement()
      @.scheduleBackgroundMovement()
    )

  scheduleForegroundMovement: ->
    windowSize = cc.director.getWinSize()

    if @sprite2.getPosition().y <= windowSize.height * 0.5
      @sprite1.setPosition(windowSize.width * 0.5, windowSize.height * 0.5)
      @sprite2.setPosition(windowSize.width * 0.5, windowSize.height * 1.5)

    scrollSpeed = 0.25 / @speed

    @sprite1.runAction(new cc.MoveBy(scrollSpeed, 0, -windowSize.height * 0.05))
    @sprite2.runAction(
      new cc.Sequence(
        new cc.MoveBy(scrollSpeed, 0, -windowSize.height * 0.05),
        new cc.CallFunc(()=>
          @.scheduleForegroundMovement()
        )
      )
    )

  scheduleBackgroundMovement: ->
    windowSize = cc.director.getWinSize()

    if @sprite4.getPosition().y <= windowSize.height * 0.3
      @sprite3.setPosition(windowSize.width * 0.5, windowSize.height * 0.3)  # Twist backgrounds a little to avoid blurring effect
      @sprite4.setPosition(windowSize.width * 0.5, windowSize.height * 1.3)

    scrollSpeed = 0.25 / @speed

    @sprite3.runAction(new cc.MoveBy(scrollSpeed, 0, -windowSize.height * 0.0125))
    @sprite4.runAction(
      new cc.Sequence(
        new cc.MoveBy(scrollSpeed, 0, -windowSize.height * 0.0125),
        new cc.CallFunc(()=>
          @.scheduleBackgroundMovement()
        )
      )
    ))
