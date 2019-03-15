# PowerShell-TuneUp
```
A couple notes about my scripts. I use "SET-ALIAS SAY WRITE-HOST" in all my scripts so include it in your profile or edit all the SAY to WRITE-HOST. Lastly I Use the PowerShell environment $ENV:BASE in all my scripts. This is your base ps1 script folder. Feel free to write me an DanaMW at gmail.com if you want help. But I think just checking out the script will do it for ya.
----
PowerShell Scripts and snips for the learning curve. All are working in PowerShell Code 6.2.X unless they say otherwise. If you have improvements to them please share them with me, thats what this is about for me. Hope they help someone else. Enjoy. Note: In some of the scripts here I use console window resizing code. If you get weird error(s) just make the window larger than the displayed script and it wont error any more and in a perfect world will resize to the size of the script display. With the Settings managers you can hit enter a couple times to do just that.
```
# BinMenu
```
Bin Menu is a simple console based menu that reads in what exe's are in the base sub-folders and which *PS1's are in the base and lists them on a menu for you. Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds. You can add your own entries to the end of the program menu list if you want up to 100. There is also a toggle to show the scripts or not, and a toggle to show the add entries or not. Edit the json put the bin* files in your base folder and run it. It will automatically run you through creating the INI it uses to store the Program Menu file list in. Have fun I did. And it works I use it EVERY day. (Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts. Then in all the sub folders of bin are all my programs I use that are portable . The list in the picture below sums it up.) See more extensive description in the readme in the folder.
```
<img src="/img/BinMenu1.png" alt="BinMenu"/>
<img src="/img/BinMenu2.png" alt="BinMenu"/>

# Convert-Script
```
This is my user.CSS to user.JS UserStyle to UserScript converter. It is for use on scripts that you need to covert for use in Tampermonkey or any of the *monkey JS injection extensions. One example of a good use is for Edge browser. There are no style injectors for Edge so you have to use TM. And to style CSS in Tampermonkey you need this convertor to hook up your *.user.css to a useable *.user.js Very simply, it copies over and converts the header to UserScript and wraps your code with quotes. It also added the rest of the required JS you need in it to allow it to run. You will need to edit the header in the finished JS to add a valid address include. Example: `// @include  /https?://discordapp\.com/channels/*/` Also you will need to remove one Bracket in quotes at the very bottom. just before the JS starts. (That one pared with the removed @-Moz* that is no longer there. I will figure out a way to get it soon.
Update: Can convert VERY large files now. I don't read the whole file in now I read it in one line at a time so files can be huge.
Update:  I open this script up and scared my self lol. I had written it very near the beginning of my learning curve I COMPLETELY rewrote it. Much smaller WAY safer and incredibly faster. NOW it deserves to be a public facing script.
```
# Imageto64
```
Feed it a filename of a image file and it feeds you back the base64 info ready to put into your script files.
```
# Clearlogs
```
This clears most to all of your windows logs for you. (All of them except locked or in use as we fly by them). Update: Added Write Progress to the script so that there is some interaction with users in the form of a Progress Bar. Update: Added the [bool] $Loud so that you can see the Verbose output. Clearlogs -Loud 1 or -Loud $True Updated: It now gets the total number of log files, sets the math for the Progress bar and runs the routines. It also checks if it is ADMIN (Elevated) and if not, Elevates and runs. (It needs to be admin to delete clear logs). Should work for everyone well now.
Update: Added my own super simple progress bar that you can change the progress character. Updated to Version 2
```
# Get-SysInfo
```
A simple system information example containing how to expand a looped composed ($var + #) variable, and how to  draw out simple info using Get-CimInstance. Updated: To only use Get-CimInstance.
```
<img src="/img/ShowSysInfo.png" alt="SysInfo"/>

# Set-WinSize (Formally Fix-Window)
```
My script paste-in that allows the console buffer and window to be resized. I tried 3 or 4 from others and they didn't work so I put this together and use it because it simply works. (Going to turn it into a Function soon) Update: Moved it closer to a function, Working well.
```
# Discord Stuff
```
Here is where I put any Discord related PowerShell script stuff.
```
# Google
```
This is my console script example that sends your search to Google in the browser. You can add -IMAGE, -VIDEO or -NEWS to the beginning or end of the line to go directly to those search pages.
```
# Remove-Empty
```
Remove-Empty is a simple little script that removes all empty Lines in a given text file. Feed it a file and all the blank lines are removed.
```
## ASAY and NOTIFY
```
ASAY and NOTIFY are really the same file. They will send a notification to the standard windows notification center. I use it in my scripts to let me know when any event has happened I might want to see. The format is simple, without quote ASAY <any text you want to send to the notify>
I also call these scripts from a LOT of my scripts to give notifications on windows 10. there is also a Linux and Dos version.
```
## Search
```
Search is a script that searches any text, as a filename parameter, in the path you give. From the whole drive down to just a folder it will list all matches found. It does this quickly.
```
## Env (environment)
```
This is my script to list a (one) environment variable from system ENV variable (no quotes) or from the variable drive ENV 'variable' (single quote). If you just do ENV it will list ALL variable
```
## Ver (Version)
```
I was missing the sort of version program I wanted so here it is. Just type VER.
```
## Reboot
```
I wanted (needed) a reboot command in windows. So TaDA :) It is used REBOOT.PS1 STOP|SHUTDOWN|RESTART|REBOOT
Just REBOOT alone is the same as REBOOT RESTART
I also call this script from the BinMenu above
```
## Run-CheckDisk
```
This script is my once a week CHKNTFS routine. It Sets drive C: and D: dirty then reboots to preform the disk check.
I also call this script from the G QuickMenu of the BinMenu above
```
