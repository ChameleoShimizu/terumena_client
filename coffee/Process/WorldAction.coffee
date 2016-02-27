#WorldAction
class window.WorldAction
  constructor: ->
    @LocalAction=new LocalAction()
    @Menu=new Menu()

  Renderer=
    BottomMenu: (Process_Seed) ->
      Process_Seed=Process_Seed

      return (cvs) ->
        cvs.cx.fillStyle="#000"
        cvs.cx.fillRect(0,(cvs.c.height/4)*3,cvs.c.width,(cvs.c.height/4))

        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#fff"
        cvs.cx.fillText(Process_Seed.Player.name,48,((cvs.c.height/4)*3)+32)
        cvs.cx.fillText("HP #{Process_Seed.Player.hp}/#{Process_Seed.Player.hpMax}",48,((cvs.c.height/4)*3)+64)
        cvs.cx.fillText("MP #{Process_Seed.Player.mp}/#{Process_Seed.Player.mpMax}",48,((cvs.c.height/4)*3)+96)
        if (Process_Seed.Player.hun<32)
          if (Process_Seed.Player.hun<16)
            cvs.cx.fillStyle="#d00"
            if (Process_Seed.Player.hun<8)
              if (Process_Seed.Player.hun<=0)
                cvs.cx.fillText("餓死中",48,((cvs.c.height/4)*3)+128)
              else
                cvs.cx.fillText("餓死",48,((cvs.c.height/4)*3)+128)
            else
              cvs.cx.fillText("空腹",48,((cvs.c.height/4)*3)+128)
          else
            cvs.cx.fillStyle="#fff"
            cvs.cx.fillText("空腹",48,((cvs.c.height/4)*3)+128)

    Time: (Process_Seed) ->
      Process_Seed=Process_Seed
      return (cvs) ->
        cvs.cx.fillStyle="rgba(0,0,0,.5)"
        cvs.cx.fillRect(8,8,192,128)
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#fff"
        year=Process_Seed.World.year
        date=Math.floor(Process_Seed.World.day/31)+1
        day=(Process_Seed.World.day%31)+1
        time=Math.floor(Process_Seed.World.minuit/60)
        minuit=Process_Seed.World.minuit%60
        gloval=Process_Seed.World.Gloval[Process_Seed.Player.Gloval]
        local=Process_Seed.World.Gloval[Process_Seed.Player.Gloval].Local[Process_Seed.Player.Local]
        cvs.cx.fillText("#{year}年#{date}月#{day}日#{time}時#{minuit}分",16,48)
        cvs.cx.fillText(gloval.name,16,80)
        cvs.cx.fillText(local.name,16,112)


  Run: do ->
    flag=0b0001

    return (Process_Seed,Renderer_Order,Input) ->

      if (Process_Seed.Player.flag.Menu&0b00000001) isnt 0b00000001
        if (Input.state.Key[16])
          Process_Seed.Player.flag.Menu=0b00000001
        else
          Input.Clear("Key")

      if (Process_Seed.Player.Local)
        process_back=@LocalAction.Run(Process_Seed,Renderer_Order,Input)
        Process_Seed=process_back.Process_Seed
        Renderer_Order=process_back.Renderer_Order
        console.log "renderer:#{Process_Seed.Player.flag.Menu}"

      if (Process_Seed.Player.flag.Menu&0b00000001) isnt 0b00000001
        process_back=@Menu.Run(Process_Seed,Renderer_Order,Input)
        Process_Seed=process_back.Process_Seed
        Renderer_Order=process_back.Renderer_Order

      Renderer_Order.push(Renderer.Time(Process_Seed))
      Renderer_Order.push(Renderer.BottomMenu(Process_Seed))

      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
