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

    @health = 10
    @fuelCollected = 0

    @speed = 1

    cc.eventManager.addListener(
      event: cc.EventListener.KEYBOARD
      onKeyPressed: (e)=> @.onKeyPressed(e),
      @
    )

    @.scheduleNextObject()

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

    bonus.launch(@speed * (Math.random() + 0.5))

  scheduleNextObject: ->
    @.scheduleOnce(
      =>
        @.releaseObject()
        @.scheduleNextObject()
      1 / @speed
    )

  releaseObject: ->
    windowSize = cc.director.getWinSize()

    if Math.random() < 0.5
      object = new Meteor()
    else
      object = new Bonus()

    object.sprite.setPosition(
      windowSize.width * Math.random(),
      windowSize.height * 1.1
    )

    @.addChild(object.sprite)

    object.launch(@speed * (Math.random() + 0.5))

  performHit: ->
    @.getParent().particles.explodeAt(@ship.getPosition())

    @ship.runAction(
      cc.Sequence.create(
        cc.MoveBy.create(0.1, cc.p(10, 0)),
        cc.MoveBy.create(0.1, cc.p(0, -10)),
        cc.MoveBy.create(0.1, cc.p(0, 10)),
        cc.MoveBy.create(0.1, cc.p(-10, 0))
      )
    )

    @health -= 1

    if @health > 0
      @.getParent().ui.decreaseHealth(@health)
    else
      cc.director.runScene(new GameOverScene())

  collectFuel: ->
    @fuelCollected += 1

    @.getParent().ui.setFuelCollected(@fuelCollected)

    @speed = 1 + globals.speedGrowth * Math.ceil(@fuelCollected / globals.fuelPerSpeedPoint)

    @.getParent().background.speed = @speed
)
