BackgroundLayer = cc.Layer.extend(
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

    @.scheduleForegroundMovement()
    @.scheduleBackgroundMovement()

  scheduleForegroundMovement: ->
    windowSize = cc.director.getWinSize()

    @sprite1.setPosition(windowSize.width * 0.5, windowSize.height * 0.5)
    @sprite2.setPosition(windowSize.width * 0.5, windowSize.height * 1.5)

    @sprite1.runAction(new cc.MoveBy(5, 0, -windowSize.height))
    @sprite2.runAction(
      new cc.Sequence(
        new cc.MoveBy(5, 0, -windowSize.height),
        new cc.CallFunc(()=>
          @.scheduleForegroundMovement()
        )
      )
    )

  scheduleBackgroundMovement: ->
    windowSize = cc.director.getWinSize()

    @sprite3.setPosition(windowSize.width * 0.5, windowSize.height * 0.5)
    @sprite4.setPosition(windowSize.width * 0.5, windowSize.height * 1.5)

    @sprite3.runAction(new cc.MoveBy(25, 0, -windowSize.height))
    @sprite4.runAction(
      new cc.Sequence(
        new cc.MoveBy(25, 0, -windowSize.height),
        new cc.CallFunc(()=>
          @.scheduleBackgroundMovement()
        )
      )
    ))
