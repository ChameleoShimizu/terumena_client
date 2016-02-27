var app=require('app');
var ipcMain=require('ipc');
var BrowserWindow=require('browser-window');

require('crash-reporter').start();

app.on('ready',function(){
  mainWindow=new BrowserWindow({
    width:1024,
    height:856,
    resizable:false,
    darkTheme:true
  });

  mainWindow.loadUrl('file://'+__dirname+'/index.html');

  mainWindow.on('closed',function(){
    mainWindow=null;
  });

});

app.on('window-all-closed',function(){
  app.quit();
});

ipcMain.on('getAppPath', function(event,arg){
  event.returnValue=app.getAppPath();
});
