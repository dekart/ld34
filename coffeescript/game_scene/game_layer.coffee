GameLayer = cc.Layer.extend(
  bonuses: []
  health: 10
  fuelCollected: 0
  speed: 0
  asteroids: []
  rockets: []
  shieldsUp: false
  inactive: false

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

    @.scheduleOnce(=>
      @.scheduleNextObject()
    )


  onKeyPressed: (keycode)->
    return if @inactive

    switch keycode
      when 32
        @.raiseShields()
      when 90
        @.launchRocket() unless @shieldsUp
      when 82
        document.location = document.location
      else
        console.log("key pressed: ", keycode)

  raiseShields: ->
    @shieldsUp = !@shieldsUp

    if @shieldsUp
      @shield.setVisible(true)
      @shield.stopAllActions()
      @shield.setScale(0)
      @shield.runAction(
        cc.ScaleTo.create(0.1, 1)
      )
    else
      @shield.setVisible(false)

    cc.audioEngine.playEffect(
      if @shieldsUp then resources.shield_up_mp3 else resources.shield_down_mp3
    )

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

  launchRocket: ->
    target = _.min(@asteroids, (a)-> a.sprite.getPosition().y)

    rocket = new Rocket(@ship)

    @.addChild(rocket.sprite)

    rocket.launch(target)

  releaseObject: ->
    return if @inactive

    windowSize = cc.director.getWinSize()

    chance = Math.random()

    if chance < 0.40
      object = new Meteor()
    else if chance < 0.9
      object = new Bonus()
    else
      object = new Asteroid()

      @asteroids.push(object)

    object.sprite.setPosition(
      windowSize.width * Math.random(),
      windowSize.height * 1.1
    )

    @.addChild(object.sprite)

    object.launch(@speed * (Math.random() + 0.5))

  performHit: (scale)->
    return if @inactive

    @.getParent().particles.explodeAt(@ship.getPosition())

    @ship.runAction(
      cc.Sequence.create(
        cc.MoveBy.create(0.1, cc.p(10, 0)),
        cc.MoveBy.create(0.1, cc.p(0, -10)),
        cc.MoveBy.create(0.1, cc.p(0, 10)),
        cc.MoveBy.create(0.1, cc.p(-10, 0))
      )
    )

    @health -= scale

    if @health > 0
      @.getParent().ui.decreaseHealth(@health)
    else
      cc.audioEngine.playEffect(resources.ship_explosion_mp3)

      @inactive = true

      @ship.setVisible(false)

      @.getParent().particles.explodeShipAt(@ship.getPosition())

      @.runAction(
        cc.Sequence.create(
          cc.DelayTime.create(2)
          cc.CallFunc.create(
            ()=> cc.director.runScene(new GameOverScene())
          )
        )
      )


  collectFuel: ->
    return if @inactive

    cc.audioEngine.playEffect(resources.container_mp3)

    @fuelCollected += 1

    @.getParent().ui.setFuelCollected(@fuelCollected)

    @speed = @.getParent().speed + globals.speedGrowth * Math.ceil(@fuelCollected / globals.fuelPerSpeedPoint)

    @.getParent().background.speed = @speed

    if @fuelCollected >= globals.fuelPerSpeedPoint * 8
      @.goToWarp()

  goToWarp: ->
    @inactive = true

    @.getParent().ui.goToWarp()

    windowSize = cc.director.getWinSize()

    @ship.runAction(
      cc.EaseIn.create(
        cc.MoveBy.create(2, 0, windowSize.height),
        2
      )
    )

    @shield.setVisible(false)

    cc.audioEngine.playEffect(resources.warp_mp3)


  removeAsteroid: (asteroid)->
    @asteroids = _.without(@asteroids, asteroid)
)
