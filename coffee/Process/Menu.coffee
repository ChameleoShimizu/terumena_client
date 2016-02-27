#Menu
class window.Menu
  constructor: ->

  Renderer=
    Background: (cvs) ->
      x=(cvs.c.width/4)
      y=(cvs.c.height/10)
      w=(cvs.c.width/4)*2
      h=(cvs.c.height/10)*5

      cvs.cx.fillStyle="rgb(25,50,25)"
      cvs.cx.fillRect(x,y,w,h)

    Title: (cvs) ->
      x=(cvs.c.width/4)
      y=(cvs.c.height/10)
      w=(cvs.c.width/4)*2
      h=(cvs.c.height/10)*5
      cvs.cx.font="20px 'Droid Serif'"
      cvs.cx.fillStyle="#fff"
      cvs.cx.fillText("アイテム",x+16,y+32)

      cvs.cx.fillStyle="rgba(255,255,255,0.7)"
      cvs.cx.fillRect(x+8,y+48,w-16,1)

    Selection: (choice) ->
      choice=choice
      return (cvs) ->
        x=(cvs.c.width/4)
        y=(cvs.c.height/10)
        w=(cvs.c.width/4)*2
        h=(cvs.c.height/10)*5
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#fff"
        if choice.length
          for i in [0..choice.length-1]
            cvs.cx.drawImage(cvs.image.item,(choice[i].img%32)*cvs.L_PX,Math.floor(choice[i].img/32)*cvs.L_PX,cvs.L_PX,cvs.L_PX,x+16,(y+56)+(i*32),cvs.G_PX,cvs.G_PX)
            cvs.cx.fillText(choice[i].name,x+52,(y+80)+(i*32))

  Run: do ->
    flag=0b0001

    return (Process_Seed,Renderer_Order,Input) ->

      Renderer_Order.push(Renderer.Background)
      Renderer_Order.push(Renderer.Title)
      Renderer_Order.push(Renderer.Selection(Process_Seed.Player.item))

      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
