FallingObject = class
  sprite: null
  baseSpeed: 5
  startingPosition: null

  constructor: ->
    # Should be extended

  launch: (speed)->
    myPosition = @sprite.getPosition()

    @startingPosition = myPosition

    shipPosition = @sprite.getParent().getChildByTag("ship").getPosition()
    shipPosition.x += 130 * (0.5 - Math.random())

    distanceToShield = 1 - 90 / 1242

    totalTime = @baseSpeed / speed
    timeToShield = totalTime * distanceToShield

    shieldPointPosition = {
      x: (myPosition.x - shipPosition.x) * (1 - distanceToShield) + shipPosition.x
      y: (myPosition.y - shipPosition.y) * (1 - distanceToShield) + shipPosition.y
    }

    @sprite.runAction(
      new cc.Sequence(
        new cc.MoveTo(timeToShield, shieldPointPosition.x, shieldPointPosition.y),
        new cc.CallFunc(()=>
          @.checkShields()
        )
      )
    )

  checkShields: ->
    if @sprite.getParent().shieldsUp
      @.onShieldHit()
    else
      @.onShieldMissed()

  removeFromScene: ->
    @sprite.stopAllActions()
    @sprite.getParent().removeChild(@sprite)
