$FileVersion = "Version: 0.1.0"
Clear-Host
WC "~white~System Profiles information $FileVersion~"
Say ""
WC "~darkyellow~The Main Profile For Your Account is~~white~:~"
WC "~white~=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=~"
WC "~yellow~$Profile~"
Say ""
WC "~darkyellow~The other possible profile files are~~white~:~"
WC "~white~=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=~"
$temp = $Profile.AllUsersAllHosts
$Filetest = Test-Path -path $temp
if (($Filetest)) { $used = "Used" }
else { $used = "Not used" }
WC "~darkcyan~[ ~~white~AllUsersAllHosts~~darkcyan~ ]~~white~......:~ ~yellow~$temp~ ~darkred~(~~white~$Used~~darkred~)~"
$temp = $Profile.AllUsersCurrentHost
$Filetest = Test-Path -path $temp
if (($Filetest)) { $used = "Used" }
else { $used = "Not used" }
WC "~darkcyan~[ ~~white~AllUsersCurrentHost~~darkcyan~ ]~~white~...:~ ~yellow~$temp~ ~darkred~(~~white~$Used~~darkred~)~"
$temp = $Profile.CurrentUserAllHosts
$Filetest = Test-Path -path $temp
if (($Filetest)) { $used = "Used" }
else { $used = "Not used" }
WC "~darkcyan~[ ~~white~CurrentUserAllHosts~~darkcyan~ ]~~white~...:~ ~yellow~$temp~ ~darkred~(~~white~$Used~~darkred~)~"
$temp = $Profile.CurrentUserCurrentHost
$Filetest = Test-Path -path $temp
if (($Filetest)) { $used = "Used" }
else { $used = "Not used" }
WC "~darkcyan~[ ~~white~CurrentUserCurrentHost~~darkcyan~ ]~~white~:~ ~yellow~$temp~ ~darkred~(~~white~$Used~~darkred~)~"
Say ""
