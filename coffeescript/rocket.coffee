Rocket = class
  sprite: null
  baseTime: 2

  constructor: (ship)->
    @sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("rocket.png"))
    @sprite.setPosition(ship.getPosition())

    @windowSize = cc.director.getWinSize()

    @speed = @windowSize.height / 2

  launch: (target)->
    myPosition = @sprite.getPosition()
    targetPosition = target.startingPosition

    distance = Math.sqrt(
      Math.pow((myPosition.x - targetPosition.x), 2) + Math.pow(myPosition.y - targetPosition.y, 2)
    )

    time = @baseTime * distance / @speed
    angle = cc.pAngleSigned(
      cc.pAdd(targetPosition, cc.p(-@windowSize.width / 2, 0)), cc.p(0, 1)
    ) * 180 / Math.PI

    @sprite.setRotation(angle)

    @sprite.runAction(
      new cc.Spawn(
        new cc.Sequence(
          new cc.MoveTo(time, targetPosition),

          new cc.CallFunc(()=>
            @.removeFromScene()
          )
        )
      )
    )

    @.scheduleTargetCheck()

  scheduleTargetCheck: ->
    @sprite.scheduleOnce(
      ()=> @.checkTargetHit()
      0.1
    )

  checkTargetHit: ->
    targets = @sprite.getParent().asteroids

    myPosition = @sprite.getPosition()

    targetHit = false

    for target in targets
      if cc.pDistance(myPosition, target.sprite.getPosition()) < @windowSize.width * 0.1
        target.takeHit()

        @sprite.getParent().getParent().particles.explodeAt(@sprite.getPosition())

        @.removeFromScene()

        targetHit = true

        break

    @.scheduleTargetCheck() unless targetHit

  removeFromScene: ->
    @sprite.unscheduleAllCallbacks()
    @sprite.stopAllActions()
    @sprite.getParent().removeChild(@sprite)
