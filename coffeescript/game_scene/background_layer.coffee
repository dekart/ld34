BackgroundLayer = cc.Layer.extend(
  speed: 0

  ctor: ->
    @._super()

    @sprite1 = new cc.Sprite(resources.background_jpg)
    @sprite2 = new cc.Sprite(resources.background_jpg)
    @sprite1.setOpacity(100)
    @sprite2.setOpacity(100)
    @sprite1.setScaleX(-1)
    @sprite2.setScaleX(-1)

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

    windowSize = cc.director.getWinSize()

    @sprite1.setPosition(windowSize.width * 0.5, windowSize.height * 0.5)
    @sprite2.setPosition(windowSize.width * 0.5, windowSize.height * 1.5)
    @sprite3.setPosition(windowSize.width * 0.5, windowSize.height * 0.5)
    @sprite4.setPosition(windowSize.width * 0.5, windowSize.height * 1.5)

    @.scheduleOnce(=>
      @.scheduleForegroundMovement()
      @.scheduleBackgroundMovement()
    )

  scheduleForegroundMovement: ->
    windowSize = cc.director.getWinSize()

    if @sprite2.getPosition().y <= windowSize.height * 0.5
      @sprite1.setPositionY(@sprite1.getPositionY() + windowSize.height)
      @sprite2.setPositionY(@sprite2.getPositionY() + windowSize.height)

    baseSpeed = @.getParent().speed

    scrollTime = 0.25 / ((@speed - baseSpeed) * 5 + baseSpeed)

    @sprite1.runAction(new cc.MoveBy(scrollTime, 0, -windowSize.height * 0.05))
    @sprite2.runAction(
      new cc.Sequence(
        new cc.MoveBy(scrollTime, 0, -windowSize.height * 0.05),
        new cc.CallFunc(()=>
          @.scheduleForegroundMovement()
        )
      )
    )

  scheduleBackgroundMovement: ->
    windowSize = cc.director.getWinSize()

    if @sprite4.getPosition().y <= windowSize.height * 0.5
      @sprite3.setPositionY(@sprite3.getPositionY() + windowSize.height)
      @sprite4.setPositionY(@sprite4.getPositionY() + windowSize.height)

    baseSpeed = @.getParent().speed

    scrollTime = 0.25 / ((@speed - baseSpeed) * 5 + baseSpeed)

    @sprite3.runAction(new cc.MoveBy(scrollTime, 0, -windowSize.height * 0.01))
    @sprite4.runAction(
      new cc.Sequence(
        new cc.MoveBy(scrollTime, 0, -windowSize.height * 0.01),
        new cc.CallFunc(()=>
          @.scheduleBackgroundMovement()
        )
      )
    ))
