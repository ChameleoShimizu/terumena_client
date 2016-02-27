#Method.Title
class window.Title
  constructor: ->

  Renderer=
    FillBlack: (cvs) ->
      cvs.cx.fillStyle="#000"
      cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    BlackFadeIn: (f) ->
      fadeCount=f
      return (cvs) ->
        cvs.cx.fillStyle="rgba(0,0,0,#{fadeCount})"
        cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    BlackFadeOut: (f) ->
      fadeCount=1-f
      return (cvs) ->
        cvs.cx.fillStyle="rgba(0,0,0,#{fadeCount})"
        cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    TitleLogFadeIn: (f) ->
      fadeCount=f
      return (cvs) ->
        cvs.cx.fillStyle="rgba(50,100,50,#{fadeCount})"

        cvs.cx.shadowColor="rgba(0,0,0,#{fadeCount})"

        cvs.cx.shadowBlur=50;
        cvs.cx.font="128px 'Droid Serif'"
        cvs.cx.fillText("T",96,384)
        cvs.cx.font="64px 'Droid Serif'"
        cvs.cx.fillText("erumena",160,384)

        cvs.cx.shadowBlur=40;
        cvs.cx.font="128px 'Droid Serif'"
        cvs.cx.fillText("T",96,384)
        cvs.cx.font="64px 'Droid Serif'"
        cvs.cx.fillText("erumena",160,384)

        cvs.cx.shadowBlur=30;
        cvs.cx.font="128px 'Droid Serif'"
        cvs.cx.fillText("T",96,384)
        cvs.cx.font="64px 'Droid Serif'"
        cvs.cx.fillText("erumena",160,384)

        cvs.cx.shadowBlur=20;
        cvs.cx.font="128px 'Droid Serif'"
        cvs.cx.fillText("T",96,384)
        cvs.cx.font="64px 'Droid Serif'"
        cvs.cx.fillText("erumena",160,384)

        cvs.cx.shadowBlur=10;
        cvs.cx.font="128px 'Droid Serif'"
        cvs.cx.fillText("T",96,384)
        cvs.cx.font="64px 'Droid Serif'"
        cvs.cx.fillText("erumena",160,384)

        cvs.cx.shadowBlur=0;

    BackGroundFadeIn: (f,obj) ->
      fadeCount=f
      bgobj=obj
      return (cvs) ->
        for i in [0...bgobj.length]
          alpha=fadeCount*bgobj[i].a
          cvs.cx.fillStyle="rgba(#{bgobj[i].c[0]},#{bgobj[i].c[1]},#{bgobj[i].c[2]},#{alpha})"
          cvs.cx.fillRect(bgobj[i].x+bgobj[i].x_swing,bgobj[i].y,bgobj[i].r,bgobj[i].r);
          bgobj[i].y-=bgobj[i].s
          if bgobj[i].b
            bgobj[i].x_swing+=0.1
            if bgobj[i].x_swing > bgobj[i].x_swing_weight
              bgobj[i].b=false
          else
            bgobj[i].x_swing-=0.1
            if bgobj[i].x_swing < -(bgobj[i].x_swing_weight)
              bgobj[i].b=true
          if bgobj[i].y < Math.floor(document.body.clientHeight)
            bgobj[i].a-=0.002
            if bgobj[i].y < Math.floor(document.body.clientHeight/4)*3
              bgobj[i].a-=0.003
            if bgobj[i].a < 0
              bgobj[i].x=Math.floor(Math.random()*document.body.clientWidth)
              bgobj[i].y=document.body.clientHeight+Math.floor(Math.random()*((document.body.clientHeight)/2))
              bgobj[i].a=Math.random()

    DrawTitleImage: (cvs) ->
      cvs.cx.drawImage(cvs.image.title,0,0,cvs.c.width,cvs.c.height)

    MenuFadeIn: (f) ->
      fadeCount=f
      return (cvs) ->
        cvs.cx.fillStyle="rgba(0,0,0,#{fadeCount*0.8})"
        cvs.cx.fillRect(108,482,280,176)

    Selection: (f,cursor,choices) ->
      fadeCount=f
      cursor=cursor
      choices=choices
      return (cvs) ->
        cvs.cx.fillStyle="rgba(255,255,255,#{fadeCount/10})"
        cvs.cx.fillRect(120,490+(cursor*32),256,32)
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="rgba(255,255,255,#{fadeCount})"
        for i in [0...choices.length]
          cvs.cx.fillText(choices[i],128,512+(i*32))

  Run: do ->
    flag=0b00000001
    fadeCount=0
    bgobj=[]
    bgmaterial=
      x:0
      y:0
      r:0
      s:0
      a:0
      x_swing:0
      x_swing_weight:0
      b:true
      c:[]
    for i in [0...1024]
      bgobj.push(Object.create(bgmaterial))
      bgobj[i].x=Math.floor(Math.random()*document.body.clientWidth)
      bgobj[i].y=((document.body.clientHeight/4)*3)+Math.floor(Math.random()*((document.body.clientHeight)/2))
      bgobj[i].r=0.5+Math.random()
      bgobj[i].s=0.3+Math.random()
      if (document.body.clientHeight/3)*2 <= bgobj[i].y
        bgobj[i].a=Math.random()
      bgobj[i].x_swing_weight=1+Math.random()
      bgobj[i].c[0]=Math.floor(Math.random()*64)
      bgobj[i].c[1]=128+Math.floor(Math.random()*32)
      bgobj[i].c[2]=Math.floor(Math.random()*64)
    cursor=0
    choices=["冒険を再開する","新しい冒険者を作成する","冒険者の引継ぎ","設定の変更","終了"]

    return (Process_Seed,Renderer_Order,Input) ->
      if (flag&0b00000001) is 0b00000001
        fadeCount+=0.01
        Renderer_Order.push(Renderer.BlackFadeIn(fadeCount))
        if fadeCount >= 1
          fadeCount=0
          flag=flag&~0b00000001
          flag=flag|0b00001110

      if (flag&0b00000010) is 0b00000010
        Renderer_Order.push(Renderer.FillBlack)

      if (flag&0b00000100) is 0b00000100
        fadeCount+=0.05
        if fadeCount >= 1
          fadeCount=1
          flag=flag&~0b00000100

      if (flag&0b00001000) is 0b00001000
        Renderer_Order.push(Renderer.DrawTitleImage)
        Renderer_Order.push(Renderer.BlackFadeOut(fadeCount))
        Renderer_Order.push(Renderer.BackGroundFadeIn(fadeCount,bgobj))
        Renderer_Order.push(Renderer.TitleLogFadeIn(fadeCount))
        Renderer_Order.push(Renderer.MenuFadeIn(fadeCount))
        Renderer_Order.push(Renderer.Selection(fadeCount,cursor,choices))
        if Input.state.Key[13]
          if cursor is 1
            Process_Seed.Flag.Next_Current="CharaMake"
          if cursor is 4
            Process_Seed.Flag.Next_Current="Exit"
        else
          if Input.state.Key[38]
            cursor--
            if cursor < 0
              cursor=choices.length-1
          if Input.state.Key[40]
            cursor++
            if choices.length <= cursor
              cursor=0


      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
