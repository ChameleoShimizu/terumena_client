#LocalAction
class window.LocalAction
  constructor: ->

  Renderer=
    Field: (map) ->
      map=map
      return (cvs) ->
        for i in [0..map.length-1]
          for j in [0..map[0].length-1]
            cvs.sx.drawImage(cvs.image.localMap,(map[i][j].chip%32)*cvs.L_PX,Math.floor(map[i][j].chip/32)*cvs.L_PX,cvs.L_PX,cvs.L_PX,i*cvs.L_PX,j*cvs.L_PX,cvs.L_PX,cvs.L_PX)

    Character: (chara) ->
      chara=chara
      return (cvs) ->
        for i in [0..chara.length-1]
          cvs.sx.drawImage(cvs.image.character,(chara[i].portrait[0]%32)*cvs.L_PX,Math.floor(chara[i].portrait[0]/32)*cvs.L_PX,cvs.L_PX,cvs.L_PX,chara[i].x*cvs.L_PX,chara[i].y*cvs.L_PX,cvs.L_PX,cvs.L_PX)

    CvsS_Resize: (map) ->
      map=map
      return (cvs) ->
        cvs.s.width=map.length*cvs.L_PX
        cvs.s.height=map[0].length*cvs.L_PX

    CvsS_CameraWork: (map,x,y) ->
      map=map
      x=x
      y=y
      return (cvs) ->
        map_x_PX=map.length*cvs.L_PX
        map_y_PX=map[0].length*cvs.L_PX
        x_PX=x*cvs.L_PX
        y_PX=y*cvs.L_PX

        if (x_PX < cvs.L_CENTER_X)
          x_PX=0
        else if(map_x_PX-cvs.L_CENTER_X <= x_PX)
          x_PX=map_x_PX-cvs.c.width
        else
          x_PX=x_PX-cvs.L_CENTER_X

        if (y_PX < cvs.L_CENTER_Y)
          y_PX=0
        else if(map_y_PX-cvs.L_CENTER_Y <= y_PX)
          y_PX=map_y_PX-((cvs.c.height/4)*3)
        else
          y_PX=y_PX-cvs.L_CENTER_Y

        cvs.cx.drawImage(cvs.s,x_PX,y_PX,cvs.c.width,cvs.c.height,0,0,cvs.c.width,cvs.c.height)

  Control=
    PlayerAction: (Process_Seed,Input,local) ->
      if (Input.state.Key.length)
        Process_Seed.Player._x=Process_Seed.Player.x
        Process_Seed.Player._y=Process_Seed.Player.y
        if (Input.state.Key[37])
          Process_Seed.Player.x--
        if (Input.state.Key[39])
          Process_Seed.Player.x++
        if (Input.state.Key[38])
          Process_Seed.Player.y--
        if (Input.state.Key[40])
          Process_Seed.Player.y++
        if (Input.state.Key[13])
          Control.NpcCreate(local)

        Process_Seed.Player.Collision(local)
        Control.NpcAction(local)

    NpcCreate: (local) ->
      new_c=new Character("Selenium","Home")
      new_c.x=Math.floor(Math.random()*local.map.length)
      new_c.y=Math.floor(Math.random()*local.map[0].length)
      new_c.flag.CONTROL_STATE=new_c.flag.CONTROL_STATE|0b001
      local.character.push(new_c)

    NpcAction: (local) ->
      for i in [0..local.character.length-1]
        if(local.character[i].flag.CONTROL_STATE&0b001) is 0b001
          local.character[i].LocalRandomMove(local)
          local.character[i].Collision(local)

  Run: do ->
    flag=0b0001
    action=0b0111
    local=""

    return (Process_Seed,Renderer_Order,Input) ->
      if (flag&0b0001) is 0b0001
        local=Process_Seed.World.Gloval[Process_Seed.Player.Gloval].Local[Process_Seed.Player.Local]
        Renderer_Order.push(Renderer.CvsS_Resize(local.map))
        Process_Seed.Log.Print("おかえりなさい。")
        flag=(flag<<1)
      else if (flag&0b0010) is 0b0010
        if (action&0b0001) is 0b0001
          Renderer_Order.push(Renderer.Field(local.map))
          Renderer_Order.push(Renderer.Character(local.character))
        if (action&0b0010) is 0b0010
          Control.PlayerAction(Process_Seed,Input,local)

        if (action&0b0100) is 0b0100
          Renderer_Order.push(Renderer.CvsS_CameraWork(local.map,Process_Seed.Player.x,Process_Seed.Player.y))

      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
