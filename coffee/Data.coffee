#Data
class window.Data
  constructor: ->
    @fs=require("fs")
    @AppPass=require('ipc').sendSync('getAppPath');
    @SaveDataList=[]

  GetSaveDataList: ->
    @SaveDataList=@fs.readdirSync(@AppPass+"/sav")
    for i in @SaveDataList.length
      @SaveDataList[i]=@SaveDataList[i].substr(0,(@SaveDataList[i].length-4))
    return @SaveDataList

  Save: (savname,World) ->
    @fs.writeFileSync("#{savname}.txt",World)
    console.log "保存しました"

  Load: (savname) ->
    return @fs.readFileSync("#{savname}.txt")

  Ajax: do ->
    xmlhttp=new XMLHttpRequest()
    return {
      GetVoice: ->
        xmlHttp.onreadystatechange= ->
          if (xmlHttp.readyState is 4) and (xmlHttp.status is 200)
            console.log(xmlHttp.responseText);
        xmlHttp.open("GET", "http://www.ajaxtower.jp/sample/plan.txt", false);
        xmlHttp.send(null);
    }
