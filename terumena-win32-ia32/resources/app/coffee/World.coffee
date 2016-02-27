#World
class window.World
  constructor: (@name) ->
    @year=256
    @day=1
    @time=0
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
    @weather=0b0000
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
      CONTROL_STATE:0b000 #[3:enemy][2:ally][1:neutral][0:player]

  LocalRandomMove: (local) ->
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

  Collision: (local) ->
    for i in [0..local.character.length-1]
      if(local.character[i]) is @
        continue

      if(local.character[i].x is @x) and (local.character[i].y is @y)
        @x=@_x
        @y=@_y
        if (@flag.CONTROL_STATE&0b100 is 0b100) and (local.character[i].flag.CONTROL_STATE&0b100 isnt 0b100)
          Attack(local.character[i])
        break

  Attack: (target) ->
    damage=(@str+@siz)*Math.floor(@hp/@hpMax)
    guard=(target.end+target.siz)*Math.floor(target.hp/target.hpMax)
    if(guard < damage)
      target.hp=damage-guard
