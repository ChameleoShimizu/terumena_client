#Input
class window.Input
  constructor: ->
    @state=
      Key:[]
      Mouse:false
      Mouse_x:0
      Mouse_y:0

  Clearer=
    Key: ->
      @state.Key=[]
    Mouse: ->
      @state.Mouse=false
      @state.Mouse_x=0
      @state.Mouse_y=0
    All: ->
      @state.Key=[]
      @state.Mouse=false
      @state.Mouse_x=0
      @state.Mouse_y=0

  Clear: (c) =>
    Clearer[c].call @
