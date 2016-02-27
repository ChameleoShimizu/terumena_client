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
            for k in [0..map[i][j].item.length-1]
              if(map[i][j].item.length)
                cvs.sx.drawImage(cvs.image.item,(map[i][j].item[k].img%32)*cvs.L_PX,Math.floor(map[i][j].item[k].img/32)*cvs.L_PX,cvs.L_PX,cvs.L_PX,i*cvs.L_PX,(j*cvs.L_PX)-(8*k),cvs.L_PX,cvs.L_PX)

    Character: (chara) ->
      chara=chara
      return (cvs) ->
        for i in [0..chara.length-1]
          if(chara[i]?)
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
        if (x < cvs.L_CENTER_X)
          x_PX=0
        else if(map.length-cvs.L_CENTER_X <= x)
          x_PX=(map.length*cvs.L_PX)-cvs.c.width
        else
          x_PX=(x-cvs.L_CENTER_X)*cvs.L_PX

        if (y < cvs.L_CENTER_Y)
          y_PX=0
        else if(map[0].length-cvs.L_CENTER_Y <= y)
          y_PX=((map[0].length-Math.floor(((cvs.c.height/4)*3)/cvs.L_PX)-1)*cvs.L_PX)
        else
          y_PX=(y-cvs.L_CENTER_Y)*cvs.L_PX

        cvs.cx.drawImage(cvs.s,x_PX,y_PX,cvs.c.width,cvs.c.height,0,0,cvs.c.width,cvs.c.height)

  Control=
    GabageCheck:(character)->
      bool=true
      while(bool)
        bool=false
        for i in [character.length-1]
          if(character[i]? isnt true)
            character.splice(i,1)
            bool=true
            break
      return character

    PlayerAction: (Process_Seed,Input,local) ->
      if (Input.state.Key.length) and (((Process_Seed.Player.flag.Menu&0b00000001) is 0b00000001))
        Process_Seed.TimerAdvance(Process_Seed)
        Process_Seed.Player._x=Process_Seed.Player.x
        Process_Seed.Player._y=Process_Seed.Player.y

        if (Input.state.Key[88])
          Process_Seed.Player.flag.Menu=0b00000010
          console.log "x:#{Process_Seed.Player.flag.Menu}"
        else if (Input.state.Key[13])
          Control.NpcCreate(local)
        else
          if (Input.state.Key[37])
            Process_Seed.Player.x--
          if (Input.state.Key[39])
            Process_Seed.Player.x++
          if (Input.state.Key[38])
            Process_Seed.Player.y--
          if (Input.state.Key[40])
            Process_Seed.Player.y++

        Process_Seed.Player.Recovery(Process_Seed)
        Process_Seed.Player.Collision(Process_Seed,local)
        Control.HungerCount(Process_Seed,local)
        Control.NpcAction(Process_Seed,local)

    HungerCount: (Process_Seed,local) ->
      Process_Seed.Player.hun=Process_Seed.Player.hun-0.1
      if(Process_Seed.Player.hun<=0)
        Process_Seed.Player.hun=0
        Process_Seed.Player.hp--
        Process_Seed.Log.Print("空腹で死にそうだ！(1)")

    NpcCreate: (local) ->
      new_c=new Character("Selenium","Home")
      new_c.name="エヌ"
      new_c.x=Math.floor(Math.random()*local.map.length)
      new_c.y=Math.floor(Math.random()*local.map[0].length)
      new_c.hpMax=32
      new_c.hp=new_c.hpMax
      new_c.mpMax=16
      new_c.mp=new_c.mpMax
      new_c.str=6+Math.ceil(Math.random()*6)
      new_c.end=6+Math.ceil(Math.random()*6)
      new_c.pow=6+Math.ceil(Math.random()*6)
      new_c.dex=6+Math.ceil(Math.random()*6)
      new_c.app=6+Math.ceil(Math.random()*6)
      new_c.siz=2+Math.ceil(Math.random()*3)
      new_c.int=6+Math.ceil(Math.random()*6)
      new_c.edu=6+Math.ceil(Math.random()*6)
      new_c.flag.CONTROL_STATE=new_c.flag.CONTROL_STATE|0b1000
      new_c.item.push(new Potion())
      local.character.push(new_c)

    NpcAction: (Process_Seed,local) ->
      for i in [0..local.character.length-1]
        if(local.character[i]?)
          if(local.character[i].flag.CONTROL_STATE&0b1000) is 0b1000
            local.character[i].LocalRandomMove(Process_Seed,local)
            local.character[i].Recovery(Process_Seed)
            local.character[i].Collision(Process_Seed,local)

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
          local.character=Control.GabageCheck(local.character)
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
