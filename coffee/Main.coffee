#Main
class window.Main
  constructor: ->
    @Input=new Input()
    document.onkeydown= (e) =>
      @Input.state.Key[e.keyCode]=true

    document.onmousedown= (e) =>
      @Input.state.Mouse=true

    @Process=new Process(new Process_Seed(new World(),new Method()),new Process_Page())
    @Renderer=new Renderer()

  Runner= ->
    console.log "Frame Start."
    #@Renderer.cvs.audio.PlayMusic "glovalfield"
    timer=setInterval( =>
      if @Process.Process_Seed.Flag.Next_Current isnt @Process.Process_Seed.Flag.Current
        @Process.Process_Seed.Flag.Current=@Process.Process_Seed.Flag.Next_Current
      @Renderer.Clear()
      try
        @Renderer.Rendering(@Process.Run(@Input))
      catch error
        console.log error
        clearInterval timer
      @Input.Clear("Key")
    ,32)

  Run: =>
    @timer=Runner.call @
