Asteroid = class extends FallingObject
  baseSpeed: 15

  constructor: ->
    @sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("asteroid.png"))

  launch: (speed)->
    super(speed)

    @sprite.runAction(
      new cc.RepeatForever(
        new cc.RotateBy(7, 360)
      )
    )

  onShieldHit: ->
    @sprite.getParent().performHit(2)

    @.removeFromScene()

  onShieldMissed: ->
    @sprite.getParent().performHit(5)

    @.removeFromScene()