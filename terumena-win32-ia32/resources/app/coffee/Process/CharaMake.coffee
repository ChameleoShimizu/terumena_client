#CharaMake_Race
class window.CharaMake
  constructer: () ->

  Renderer=
    FillBlack: (cvs) ->
      cvs.cx.fillStyle="#000"
      cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    FadeBlack: (f) ->
      fadeCount=f
      return (cvs) ->
        cvs.cx.fillStyle="rgba(0,0,0,#{fadeCount})"
        cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    SetImage: (cvs) ->
      cvs.screenshot=new Image()
      cvs.screenshot.src=cvs.m.toDataURL()

    DrawlastImage: (cvs) ->
      cvs.cx.drawImage(cvs.screenshot,0,0,cvs.c.width,cvs.c.height)

    DrawBg: (cvs) ->
      cvs.cx.drawImage(cvs.image.menu_bg,0,0,cvs.c.width,cvs.c.height)

    Selection: (f,cursor,choices,title) ->
      fadeCount=f
      cursor=cursor
      choices=choices
      title=title
      return  (cvs) ->
        cvs.cx.fillStyle="rgba(25,50,25,#{fadeCount})"
        cvs.cx.shadowColor="rgba(0,0,0,#{fadeCount})"
        cvs.cx.shadowBlur=5;
        cvs.cx.fillRect(96,106,832,32)
        cvs.cx.shadowBlur=0;

        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="rgba(255,255,255,#{fadeCount})"
        cvs.cx.fillText(title,108,128)

        cvs.cx.fillStyle="rgba(192,192,192,#{fadeCount/2})"
        cvs.cx.shadowColor="rgba(0,0,0,#{fadeCount})"
        cvs.cx.shadowBlur=2;
        cvs.cx.fillRect(120,170+(cursor*32),128,32)
        cvs.cx.shadowBlur=0;

        cvs.cx.fillStyle="rgba(0,0,0,#{fadeCount})"
        for i in [0..choices.length-1]
          cvs.cx.fillText(choices[i],128,192+(i*32))

        cvs.cx.fillText("[Enter]決定",768,732)
        cvs.cx.fillText("[Shtft]戻る",768,764)

    Status: (s,l) ->
      status=s
      lock=l
      return (cvs) ->
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#000"
        for i in [0..status.length-1]
          cvs.cx.fillText(status[i],192,256+(32*i))
          if (i is lock[0]) or (i is lock[1])
            cvs.cx.fillText("Lock",224,256+(32*i))

        cvs.cx.font="12px 'Droid Serif'"
        cvs.cx.fillText("ロックされた能力は変化しません",274,256)
        cvs.cx.fillText("残りロック：#{2-lock.length}",274,288)

    Nickname: (n) ->
      nickname=n
      return (cvs) ->
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#000"
        for i in [0..nickname.length-1]
          cvs.cx.fillText(nickname[i],128,224+(32*i))

    Portrait: (p) ->
      portrait=p
      return (cvs) ->
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#000"
        for i in [0..portrait.length-1]
          cvs.cx.fillText("< #{portrait[i]} >",192,224+(32*i))
          cvs.cx.drawImage(cvs.image.character,(portrait[i]%32)*cvs.L_PX,Math.floor(portrait[i]/32)*cvs.L_PX,cvs.L_PX,cvs.L_PX,256,224,cvs.L_PX,cvs.L_PX)

    Profile: (p,t) ->
      player=p
      title=t
      return (cvs) ->
        cvs.cx.fillStyle="rgb(25,50,25)"
        cvs.cx.shadowColor="rgb(0,0,0)"
        cvs.cx.shadowBlur=5;
        cvs.cx.fillRect(96,106,832,32)
        cvs.cx.shadowBlur=0;

        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="rgb(255,255,255)"
        cvs.cx.fillText(title,108,128)

        cvs.cx.fillStyle="#000"
        cvs.cx.fillText("[Enter]決定",768,732)
        cvs.cx.fillText("[Shtft]戻る",768,764)

        cvs.cx.drawImage(cvs.image.character,(player.portrait[0]%32)*cvs.L_PX,Math.floor(player.portrait[0]/32)*cvs.L_PX,cvs.L_PX,cvs.L_PX,560,160,cvs.L_PX,cvs.L_PX)

        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#000"
        count=0
        for k,v of player
          d=k
          if (d is "Gloval") or (d is "Local")
            continue
          else if (d is "name")
            d="名前"
          else if (d is "nickname")
            d="異名"
          else if (d is "race")
            d="種族"
          else if (d is "gender")
            d="性別"
          else if (d is "occupation")
            d="職業"
          else if (d is "portrait")
            d="肖像"
          else if (d is "x" ) or (d is "y" ) or (d is "_x" ) or (d is "_y" )
            continue
          else if (d is "hpMax")
            d="体力最大値"
          else if (d is "hp")
            d="体力"
          else if (d is "mpMax")
            d="魔力最大値"
          else if (d is "mp")
            d="魔力"
          else if (d is "hunMax")
            d="満腹度最大値"
          else if (d is "hun")
            d="満腹度"
          else if (d is "str")
            d="筋力"
          else if (d is "end")
            d="耐久力"
          else if (d is "pow")
            d="精神力"
          else if (d is "dex")
            d="敏捷性"
          else if (d is "app")
            d="外見"
          else if (d is "siz")
            d="体格"
          else if (d is "int")
            d="知力"
          else if (d is "edu")
            d="教育"
          else if (d is "ability")
            d="特徴"
          else if (d is "item")
            d="アイテム"
          else if (d is "weapon")
            d="装備"
          else if (d is "weightMax")
            d="重量許容値"
          else if (d is "weight")
            d="重量"
          else if (d is "flag")
            continue

          if count < 12
            cvs.cx.fillText("#{d} : #{v}",128,176+(32*count))
          else
            cvs.cx.fillText("#{d} : #{v}",352,176+(32*(count-12)))

          count++

  String=
    Race: ->
      return {
        choices:["人間","ドワーフ","妖精","アトラス","リッチ","神族"]
        title:"種族を選んでください。"
      }
    Gender: ->
      return {
        choices:["男","女"]
        title:"性別を選んでください。"
      }
    Occupation: ->
      return {
        choices:["兵士","魔道士","神官","技術者","商人","芸術家","放浪者"]
        title:"職業を選んでください。"
      }
    Status: ->
      return {
        choices:["リロード","決定","筋力","耐久力","精神力","敏捷性","外見","体格","知力","教育"]
        title:"生き延びるには、ある程度の能力が必要だね。"
      }
    Ability: ->
      return {
        choices:["幸運の持ち主","苦行者見習い","吸血鬼","俊足","腕相撲","石の守備","見極め"]
        title:"特徴を選んでください。"
      }
    Nickname: ->
      return {
        choices:["リロード","","","","","","","","","","","",""]
        title:"異名を選んでください。"
      }
    Portrait: ->
      return {
        choices:["決定","肖像"]
        title:"肖像を選んでください。"
      }

  Reload=
    Status: do ->
      status=[]
      lock=[]
      return {
        SetFunc: ->
          for i in [0..7]
            if (lock[0] isnt i) and (lock[1] isnt i)
              status[i]=(1+Math.floor(Math.random()*21))

        GetStatus: ->
          return status

        Lock: (c) ->
          lock_cursor=c-2
          if (lock_cursor is lock[0])
            lock.shift()
          else if (lock_cursor is lock[1])
            lock.pop()
          else if(lock.length < 2)
            lock.push(lock_cursor)

        GetLock: ->
          return lock

      }

    Nickname: do ->
      dat=["ラルクアンシエル","超人","変な人","おじさん","アブラゼミ"]
      nickname=[]
      return {
        SetFunc: ->
          for i in [0..11]
            nickname[i]=dat[(Math.floor(Math.random()*5))]

        GetNickname: ->
          return nickname
      }

    Portrait: do ->
      dat=[[0..32]]
      portrait=[0]
      return {
        Select: (c,bool) ->
          if bool
            portrait[c]++
            if dat[c].length <= portrait[c]
              portrait[c]=0
          else
            portrait[c]--
            if portrait[c] < 0
              portrait[c]=dat[c].length-1

          return portrait

        GetPortrait: ->
          return portrait
      }


  Run: do ->
    flag=0b00000011
    fadeCount=0
    player=new Character("Selenium","Home")
    cursor=0
    str=String.Race()

    page=0b00000001

    return (Process_Seed,Renderer_Order,Input) ->
      if (flag&0b00000001) is 0b00000001
        Renderer_Order.push(Renderer.SetImage)
        flag=flag&~0b00000001
        flag=flag|0b00000010

      if (flag&0b00000010) is 0b00000010
        Renderer_Order.push(Renderer.DrawlastImage)
        fadeCount+=0.05
        Renderer_Order.push(Renderer.FadeBlack(fadeCount))
        if 1 <= fadeCount
          fadeCount=1
          flag=flag&~0b00000010
          flag=flag|0b00000100

      if (flag&0b00000100) is 0b00000100
        Renderer_Order.push(Renderer.DrawBg)
        fadeCount-=0.05
        Renderer_Order.push(Renderer.FadeBlack(fadeCount))
        Renderer_Order.push(Renderer.Selection(1-fadeCount,cursor,str.choices,str.title))

        if fadeCount <= 0
          fadeCount=0

        if Input.state.Key[13]
          if(page&0b00000001) is 0b00000001
            player.race=str.choices[cursor]
            str=String.Gender()
            page=(page << 1)
            cursor=0
          else if(page&0b00000010) is 0b00000010
            player.gender=str.choices[cursor]
            str=String.Occupation()
            page=(page << 1)
            cursor=0
          else if(page&0b00000100) is 0b00000100
            player.occupation=str.choices[cursor]
            str=String.Status()
            Reload.Status.SetFunc()
            page=(page << 1)
            cursor=0
          else if(page&0b00001000) is 0b00001000
            if(cursor is 0)
              Reload.Status.SetFunc()
            else if(cursor is 1)
              prop=Reload.Status.GetStatus()
              player.str=prop[0]
              player.end=prop[1]
              player.pow=prop[2]
              player.dex=prop[3]
              player.app=prop[4]
              player.siz=prop[5]
              player.int=prop[6]
              player.edu=prop[7]
              str=String.Ability()
              page=(page << 1)
              cursor=0
            else if(2 <= cursor)
              Reload.Status.Lock(cursor)

          else if(page&0b00010000) is 0b00010000
            player.ability.push(str.choices[cursor])
            str=String.Nickname()
            Reload.Nickname.SetFunc()
            page=(page << 1)
            cursor=0

          else if(page&0b00100000) is 0b00100000
            if (cursor is 0)
              Reload.Nickname.SetFunc()
            else
              player.nickname=Reload.Nickname.GetNickname()[cursor-1]
              str=String.Portrait()
              page=(page << 1)
              cursor=0

          else if(page&0b01000000) is 0b01000000
            player.portrait=Reload.Portrait.GetPortrait()
            player.flag.CONTROL_STATE=0b000
            flag=(flag<<1)

        else if Input.state.Key[16]
          cursor=0
          if(page&0b00000001) is 0b00000001
            Process_Seed.Flag.Next_Current="Title"
          else
            page=(page>>1)
            if(page&0b00000001) is 0b00000001
              str=String.Race()
            else if(page&0b00000010) is 0b00000010
              str=String.Gender()
            else if(page&0b00000100) is 0b00000100
              str=String.Occupation()
            else if(page&0b00001000) is 0b00001000
              str=String.Status()
            else if(page&0b00010000) is 0b00010000
              str=String.Ability()
            else if(page&0b00100000) is 0b00100000
              str=String.Nickname()
            else if(page&0b01000000) is 0b01000000
              str=String.Portrait()

        else
          if Input.state.Key[38]
            cursor--
            if cursor < 0
              cursor=str.choices.length-1
          if Input.state.Key[40]
            cursor++
            if str.choices.length <= cursor
              cursor=0

        if (page&0b00001000) is 0b00001000
          Renderer_Order.push(Renderer.Status(Reload.Status.GetStatus(),Reload.Status.GetLock()))

        if (page&0b00100000) is 0b00100000
          Renderer_Order.push(Renderer.Nickname(Reload.Nickname.GetNickname()))

        if (page&0b01000000) is 0b01000000
          if(0<cursor)
            if (Input.state.Key[37])
              Renderer_Order.push(Renderer.Portrait(Reload.Portrait.Select(cursor-1,false)))
            else if (Input.state.Key[39])
              Renderer_Order.push(Renderer.Portrait(Reload.Portrait.Select(cursor-1,true)))
          Renderer_Order.push(Renderer.Portrait(Reload.Portrait.GetPortrait()))

      else if (flag&0b00001000) is 0b00001000
        Renderer_Order.push(Renderer.DrawBg)
        Renderer_Order.push(Renderer.Profile(player,"満足できたかな？"))
        if (Input.state.Key[13])
          Process_Seed.Player=player
          Process_Seed.World.Gloval.Selenium=new Gloval("Selenium","セレニウム")
          Process_Seed.World.Gloval.Selenium.Local.Home=new Local("Home","我が家")
          Process_Seed.Flag.Next_Current="WorldAction"
          Process_Seed.World.Gloval.Selenium.Local.Home.character.push(Process_Seed.Player)
        else if (Input.state.Key[16])
          flag=(flag>>1)

      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
