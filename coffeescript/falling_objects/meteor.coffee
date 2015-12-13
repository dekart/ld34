Meteor = class extends FallingObject
  constructor: ->
    @sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("meteor.png"))

  launch: (speed)->
    super(speed)

    @sprite.runAction(
      new cc.RepeatForever(
        new cc.RotateBy(1, 360)
      )
    )

  onShieldHit: ->
    @sprite.getParent().getParent().particles.breakMeteorAt(@sprite.getPosition())

    @sprite.runAction(new cc.FadeTo(0.1, 0))
    @sprite.runAction(
      new cc.Sequence(
        new cc.ScaleTo(0.1, 2),
        new cc.CallFunc(()=>
          @.removeFromScene()
        )
      )
    )

  onShieldMissed: ->
    @sprite.getParent().performHit()

    @.removeFromScene()