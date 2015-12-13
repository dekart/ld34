ParticleLayer = cc.Layer.extend(
  ctor: ->
    @._super()

  explodeAt: (position)->
    explosion = cc.ParticleSystem.create(resources.explosion_plist)
    explosion.setPosition(position)
    explosion.setAutoRemoveOnFinish(true)

    @.addChild(explosion)

    cc.audioEngine.playEffect(resources.explosion_mp3)

  explodeShipAt: (position)->
    explosion = cc.ParticleSystem.create(resources.ship_explosion_plist)
    explosion.setPosition(position)
    explosion.setAutoRemoveOnFinish(true)

    @.addChild(explosion)

  breakContainerAt: (position)->
    explosion = cc.ParticleSystem.create(resources.container_break_plist)
    explosion.setPosition(position)
    explosion.setAutoRemoveOnFinish(true)

    @.addChild(explosion)

    cc.audioEngine.playEffect(resources.shield_hit_mp3)

  breakMeteorAt: (position)->
    explosion = cc.ParticleSystem.create(resources.meteor_break_plist)
    explosion.setPosition(position)
    explosion.setAutoRemoveOnFinish(true)

    @.addChild(explosion)

    cc.audioEngine.playEffect(resources.shield_hit_mp3)

)