class window.Log
  constructor: (@Data) ->
    Log=document.createElement "div"
    Log.id="Log"
    Log.style.width=((document.body.clientWidth/4)*3)-16+"px"
    Log.style.height=(document.body.clientHeight/4)-16+"px"
    Log.style.padding=8+"px"
    Log.style.position="absolute"
    Log.style.left=(document.body.clientWidth/4)+"px"
    Log.style.top=((document.body.clientHeight/4)*3)+"px"
    Log.style.zIndex="2"
    Log.style.color="#fff"
    Log.style.fontFamily="'Droid Serif'"
    Log.style.fontSize="16px"
    document.body.appendChild Log
    @id=document.querySelector "#Log"

  Delete: ->
    document.body.removeChild @id

  Print: (t) ->
    Text=document.createElement "span"
    Text.appendChild(document.createTextNode("#{t} "))
    @id.appendChild Text

  Clear: ->
    @id.innerHTML=""

  AutoUpdate: (I_state) ->
    if I_state.Key.length
      clearTimeout @AutoUpdateCheck
    else
      @AutoUpdateCheck=setTimeout(=>
        Print.call @ @Data.Ajax.GetVoice()
      ,3000)
