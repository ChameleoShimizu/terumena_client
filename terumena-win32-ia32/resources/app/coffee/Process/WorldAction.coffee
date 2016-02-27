#WorldAction
class window.WorldAction
  constructor: ->
    @LocalAction=new LocalAction()

  Renderer=
    BottomMenu: (cvs) ->
      cvs.cx.fillStyle="#000"
      cvs.cx.fillRect(0,(cvs.c.height/4)*3,cvs.c.width,(cvs.c.height/4))

  Run: do ->
    flag=0b0001

    return (Process_Seed,Renderer_Order,Input) ->

      if (Process_Seed.Player.Local)
        process_back=@LocalAction.Run(Process_Seed,Renderer_Order,Input)
        Process_Seed=process_back.Process_Seed
        Renderer_Order:Renderer_Order

      Renderer_Order.push(Renderer.BottomMenu)

      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
