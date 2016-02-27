#Process
class window.Process
  constructor: (@Process_Seed,@Process_Page) ->

  Runner= (Input) ->
    process_back=@Process_Page[@Process_Seed.Flag.Current](@Process_Seed,Input)
    @Process_Seed=process_back.Process_Seed
    return process_back.Renderer_Order.reverse()

  Run: (Input) =>
    return Runner.call @,Input


#Process_Seed
class window.Process_Seed
  constructor: (@World,@Method) ->
    @Flag=
      Current:"Title"
      Next_Current:"Title"
    @Player={}
    @Log=new Log()

  SetPlayer: (p) ->
    @Player=p


#Process_Page
class window.Process_Page
  constructor: ->

  Reset_Renderer_Order= ->
    return []

  Title: (Process_Seed,Input) =>
    @Renderer_Order=Reset_Renderer_Order.call @
    return Process_Seed.Method.Title.Run(Process_Seed,@Renderer_Order,Input)

  Resumption: (Process_Seed,Input) =>

  CharaMake: (Process_Seed,Input) =>
    @Renderer_Order=Reset_Renderer_Order.call @
    return Process_Seed.Method.CharaMake.Run(Process_Seed,@Renderer_Order,Input)

  Inheriting: (Process_Seed,Input) =>
  Config: (Process_Seed,Input) =>

  Exit: (Process_Seed,Input) =>
    @Renderer_Order=Reset_Renderer_Order.call @
    return Process_Seed.Method.Exit.Run(Process_Seed,@Renderer_Order,Input)

  WorldAction: (Process_Seed,Input) =>
    @Renderer_Order=Reset_Renderer_Order.call @
    return Process_Seed.Method.WorldAction.Run(Process_Seed,@Renderer_Order,Input)
