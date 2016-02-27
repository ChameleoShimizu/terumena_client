#Renderer
class window.Renderer
  constructor: ->
    @cvs={}
    @cvs.s=document.createElement "canvas"
    @cvs.sx=@cvs.s.getContext("2d")
    @cvs.sx.textAlign="left"
    @cvs.sx.textBaseline="top"
    @cvs.c=document.createElement "canvas"
    @cvs.cx=@cvs.c.getContext("2d")
    @cvs.cx.textAlign="left"
    @cvs.cx.textBaseline="top"
    @cvs.m=document.createElement "canvas"
    @cvs.mx=@cvs.m.getContext("2d")
    @cvs.c.width=document.body.clientWidth
    @cvs.c.height=document.body.clientHeight
    @cvs.m.width=@cvs.c.width
    @cvs.m.height=@cvs.c.height
    @cvs.G_PX=32
    @cvs.L_PX=48
    @cvs.L_CENTER_X=Math.floor((@cvs.m.width/@cvs.L_PX)/2)
    @cvs.L_CENTER_Y=Math.floor((((@cvs.m.height/4)*3)/@cvs.L_PX)/2)
    @cvs.audio=new AudioPlayer()
    @cvs.image={
      title:new Image()
      menu_bg:new Image()
      character:new Image()
      glovalMap:new Image()
      localMap:new Image()
      item:new Image()
    }
    @cvs.image.title.src="./image/title.gif"
    @cvs.image.menu_bg.src="./image/menu_bg.gif"
    @cvs.image.character.src="./image/character.gif"
    @cvs.image.glovalMap.src="./image/glovalMap.gif"
    @cvs.image.localMap.src="./image/localMap.gif"
    @cvs.image.item.src="./image/item.gif"
    @cvs.m.style.zIndex="1"
    document.body.appendChild @cvs.m

  Clear: ->
    @cvs.sx.clearRect(0,0,@cvs.s.width,@cvs.s.height)
    @cvs.cx.clearRect(0,0,@cvs.c.width,@cvs.c.height)

  Rendering: (order) ->
    while order.length
      func=order.pop()
      func(@cvs)
    @cvs.mx.drawImage(@cvs.c,0,0,@cvs.c.width,@cvs.c.height);
    @cvs.audio.MusicLoop()
