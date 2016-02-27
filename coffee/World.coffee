#World
class window.World
  constructor: (@name) ->
    @year=256
    @day=0
    @minuit=0
    @Gloval={}


#Gloval
class window.Gloval
  constructor: (@id,@name) ->
    @map= do ->
      v=[]
      for i in [0..50]
        v[i]=[]
        for j in [0..50]
          v[i][j]={
            chip:Math.floor(Math.random()*2)
            item:[]
          }
      return v

    #JSON.parse(require("fs").readFileSync("./GlovalMap.json",'utf-8'))[@id]
    @weather=0b0001
    @character=[]
    @Local={}

  CvsS_Resize: (cvs) ->
    cvs.s.width=@map.length*cvs.G_PX
    cvs.s.height=@map[0].length*cvs.G_PX

  Local_Registration: (l) ->
    @Local[l.id]=[l];

  Local_AppendFloor: (l) ->
    @Local[l.id].push l;


#Local
class window.Local
  constructor: (@id,@name,@x,@y) ->
    @map= do ->
      v=[]
      for i in [0..50]
        v[i]=[]
        for j in [0..50]
          v[i][j]={
            chip:Math.floor(Math.random()*2)
            item:[]
          }
      return v
    #@map=JSON.parse(require("fs").readFileSync("./LocalMap.json",'utf-8'))[@id]
    @character=[]

#Character
class window.Character
  constructor: (@Gloval,@Local) ->
    @name=""
    @nickname=""
    @race=""
    @gender=""
    @occupation=""
    @portrait=[0]
    @x=0
    @y=0
    @_x=0
    @_y=0
    @hpMax=128
    @hp=128
    @mpMax=64
    @mp=64
    @hunMax=96
    @hun=96
    @str=0
    @end=0
    @pow=0
    @dex=0
    @app=0
    @siz=0
    @int=0
    @edu=0
    @recovery=0
    @ability=[]
    @item=[]
    @weapon=
      head1:true
      neck1:true
      back1:true
      body1:true
      handedness:true
      hand1:true
      finger1:true
      finger2:true
      arm1:true
      hip1:true
      leg1:true
      remote:true
      ammunition:true
    @weightMax=48
    @weight=0
    @flag=
      CONTROL_STATE:0b0000 #[3:enemy][2:ally][1:neutral][0:player]

  LocalRandomMove: (Process_Seed,local) ->
    @_x=@x
    @_y=@y
    ram_x=Math.floor(Math.random()*256)
    ram_y=Math.floor(Math.random()*256)
    if(ram_x<16)
      @x--
    else if(240<=ram_x)
      @x++
    if(ram_y<16)
      @y--
    else if(240<=ram_y)
      @y++

  Collision: (Process_Seed,local) =>
    for i in [0..local.character.length-1]
      if(local.character[i] is @) or (local.character[i]? isnt true)
        continue

      if(local.character[i].x is @x) and (local.character[i].y is @y)
        @x=@_x
        @y=@_y
        if ((@flag.CONTROL_STATE&0b0001) is 0b0001) and ((local.character[i].flag.CONTROL_STATE&0b1000) is 0b1000)
          local.character[i]=Attack.call @,Process_Seed,local.character[i],local
        else if ((@flag.CONTROL_STATE&0b1000) is 0b1000) and ((local.character[i].flag.CONTROL_STATE&0b1000) isnt 0b1000)
          local.character[i]=Attack.call @,Process_Seed,local.character[i],local
        break

    if (@x < 0) or (local.map.length <= @x)
      @x=@_x
    if (@y < 0) or (local.map[0].length <= @y)
      @y=@_y

  Attack= (Process_Seed,target,field) ->
    damage=@str+Math.floor(@siz*(@hp/@hpMax))+Math.ceil(Math.random()*@dex)
    guard=target.end+Math.floor(target.siz*(target.hp/target.hpMax))+Math.ceil(Math.random()*target.pow)

    if(guard < damage)
      damage=damage-guard
    else
      damage=Math.floor(Math.random()*2)

    target.hp=target.hp-damage
    Process_Seed.Log.Print("#{@name}は#{target.name}を攻撃した。(#{damage})");

    if (target.hp<0)
      Process_Seed.Log.Print("#{target.name}はミンチになった。");
      target.item.push(new Meat(target))
      target=ItemDrop.call @,target,field
      target=null

    return target

  Recovery: (Process_Seed) ->
    if(8 <= Process_Seed.Player.hun)
      @recovery++
      if ( (16-Math.floor((@hp/@hpMax)*10)) < @recovery)
        @recovery=0
        @hp=@hp+((@end+@siz)*Math.ceil(@hp/@hpMax))+Math.floor(Math.random()*@pow)
        if(@hpMax<@hp)
          @hp=@hpMax

  ItemDrop= (target,field) ->
    bool=true
    probability=64
    while(bool)
      if( probability < Math.floor(Math.random()*256))
        bool=false
      else
        probability=Math.floor(probability/2)
        if(target.item.length)
          if( 128 < Math.floor(Math.random()*256))
            field.map[target.x][target.y].item.push(target.item.pop())
          else
            field.map[target.x][target.y].item.push(target.item.shift())
        else
          bool=false

    return target
