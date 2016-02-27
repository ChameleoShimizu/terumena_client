#Exit
class window.Exit
  constructer: () ->
    @image=new Image()

  Renderer=
    FillBlack: (cvs) ->
      cvs.cx.fillStyle="#000"
      cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    BlackFadeIn: (f) ->
      fadeCount=f
      return (cvs) ->
        cvs.cx.fillStyle="rgba(0,0,0,#{fadeCount})"
        cvs.cx.fillRect(0,0,cvs.c.width,cvs.c.height)

    SetImage: (cvs) ->
      cvs.screenshot=new Image()
      cvs.screenshot.src=cvs.m.toDataURL()

    DrawImage: (cvs) ->
      cvs.cx.drawImage(cvs.screenshot,0,0,cvs.c.width,cvs.c.height)

    StreamingText: (t) ->
      text=t
      return (cvs) ->
        cvs.cx.font="16px 'Droid Serif'"
        cvs.cx.fillStyle="#fff"
        cvs.cx.shadowColor="#fff"
        cvs.cx.shadowBlur=1;
        cvs.cx.fillText(text,256,256)
        cvs.cx.shadowBlur=0;

  Run: do ->
    flag=0b0011
    fadeCount=0
    textCount=0
    exitText="何かキーを押すと終了します。お疲れ様でした。"

    return (Process_Seed,Renderer_Order,Input) ->
      if (flag&0b0001) is 0b0001
        Renderer_Order.push(Renderer.SetImage)
        flag=flag&~0b0001

      if (flag&0b0010) is 0b0010
        fadeCount+=0.01
        Renderer_Order.push(Renderer.DrawImage)
        Renderer_Order.push(Renderer.BlackFadeIn(fadeCount))
        if 1 <= fadeCount
          fadeCount=0
          flag=flag&~0b0010
          flag=flag|0b0100

      if (flag&0b0100) is 0b0100
        Renderer_Order.push(Renderer.FillBlack)
        if textCount <= exitText.length
          textCount+=1
        Renderer_Order.push(Renderer.StreamingText(exitText.substr(0,textCount)))
        if Input.state.Key.length
          window.close()

      return {
        Process_Seed:Process_Seed
        Renderer_Order:Renderer_Order
      }
