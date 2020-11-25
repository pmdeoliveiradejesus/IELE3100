set x=createobject("wscript.shell")
x.run "runATP.exe BFR.atp" 
wscript.sleep 3000
x.sendkeys"{enter}"
