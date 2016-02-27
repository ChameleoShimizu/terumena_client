#Item
class window.Item
  constructor: (@name) ->
    @img=0
    @weight=0
    @Action={}

class window.Potion extends Item
  constructor: () ->
    super()
    @name="ポーション"
    @img=0
    @weight=0.1
    @Action.x= ->
      return ["飲むと回復するちょっと苦い薬。","体力を50回復する"]
    @Action.q= (user) ->
      user.hp=user.hp+50
      if(user.hpMax<user.hp)
        user.hp=user.hpMax
      return user

class window.Meat extends Item
  constructor: (obj) ->
    super()
    @name="#{obj.name}の肉"
    @img=1
    @weight=obj.siz
    @Action.x= ->
      return ["#{obj.name}の肉。調理することができる。","満腹度を#{@weigth}回復する。"]
    @Action.e= (user) ->
      user.hun=user.hun+@weight
      if(user.hunMax<user.hun)
        user.hun=user.hunMax
      return user
