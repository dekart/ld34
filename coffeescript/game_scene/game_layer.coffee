GameLayer = cc.Layer.extend(
  bonuses: []

  ctor: ->
    @._super()

    windowSize = cc.director.getWinSize()

    @ship = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("ship.png"))

    @ship.setPosition(windowSize.width / 2, windowSize.height * 0.1)
    @ship.setTag("ship")

    @.addChild(@ship)

    @shield = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("shield.png"))

    @shield.setPosition(windowSize.width / 2, windowSize.height * 0.13)
    @shield.setTag("shield")
    @shield.setVisible(false)

    @.addChild(@shield)

    cc.eventManager.addListener(
      event: cc.EventListener.KEYBOARD
      onKeyPressed: (e)=> @.onKeyPressed(e),
      @
    )

    @.scheduleNextBonus()
    @.scheduleNextMeteor()

  onKeyPressed: (keycode)->
    switch keycode
      when 32
        @shield.setVisible(!@shield.isVisible())
      when 82
        document.location = document.location
      else
        console.log("key pressed: ", keycode)

  releaseBonus: ->
    windowSize = cc.director.getWinSize()

    bonus = new Bonus()

    bonus.sprite.setPosition(
      windowSize.width * Math.random(),
      windowSize.height * 1.1
    )

    @.addChild(bonus.sprite)

    bonus.launch(Math.random() + 0.7)

  scheduleNextBonus: ->
    @.scheduleOnce(
      =>
        @.releaseBonus()
        @.scheduleNextBonus()
      1
    )

  releaseMeteor: ->
    windowSize = cc.director.getWinSize()

    meteor = new Meteor()

    meteor.sprite.setPosition(
      windowSize.width * Math.random(),
      windowSize.height * 1.1
    )

    @.addChild(meteor.sprite)

    meteor.launch(Math.random() + 0.7)

  scheduleNextMeteor: ->
    @.scheduleOnce(
      =>
        @.releaseMeteor()
        @.scheduleNextMeteor()
      1.5
    )

  animateHit: ->
    @.getParent().particles.explodeAt(@ship.getPosition())

    @ship.runAction(
      cc.Sequence.create(
        cc.MoveBy.create(0.1, cc.p(10, 0)),
        cc.MoveBy.create(0.1, cc.p(0, -10)),
        cc.MoveBy.create(0.1, cc.p(0, 10)),
        cc.MoveBy.create(0.1, cc.p(-10, 0))
      )
    )

    @.getParent().ui.blinkRedFrame()
)
