Bonus = class extends FallingObject
  constructor: ->
    @sprite = new cc.Sprite(cc.spriteFrameCache.getSpriteFrame("bonus.png"))

  onShieldHit: ->
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
    shipPosition = @sprite.getParent().getChildByTag("ship").getPosition()

    @sprite.runAction(new cc.MoveTo(0.1, shipPosition.x, shipPosition.y))

    @sprite.runAction(
      new cc.Sequence(
        new cc.ScaleTo(0.2, 0),
        new cc.CallFunc(()=>
          @.removeFromScene()
        )
      )
    )