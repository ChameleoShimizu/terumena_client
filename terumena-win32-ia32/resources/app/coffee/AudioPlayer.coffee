#Audio
class window.AudioPlayer
  constructor: () ->
    @music={
      glovalfield:new Audio("./music/glovalfield.mp3")
    }
    #@music.glovalfield.loop=true
    @music.glovalfield.loop=false
    @music.glovalfield.loop_start=0
    @music.glovalfield.loop_end=80

    @choice={
      music:"glovalfield"
    }

  PlayMusic: (c) ->
    @choice.music=c
    @music[@choice.music].play()

  MusicLoop: ->
    if @music[@choice.music].loop_end <= @music[@choice.music].currentTime
      @music[@choice.music].currentTime=@music[@choice.music].loop_start
