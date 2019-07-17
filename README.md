# PowerShell-TuneUp
```
A couple notes about my scripts. I use "SET-ALIAS SAY WRITE-HOST" in all my scripts.
I also use "$ESC = [char]27"
So include them in your profile or edit all the SAY to WRITE-HOST,
and edit out all the color codes.
Lastly I Use the PowerShell environment $ENV:BASE in all my scripts.
This is your base *.ps1 script folder.
Feel free to write me an DanaMW at gmail.com if you want help.
But I think just checking out the script will do it for ya.
----
PowerShell Scripts and snips for the learning curve.
All are working in PowerShell Code 6.2.X unless they say otherwise.
If you have improvements to them please share them with me, thats what this is about for me.
Hope they help someone else. Enjoy.
NOTE: **In some of the scripts here I use console window resizing code.
If you get weird error(s) just make the window larger than the displayed
 script and hit enter. In a perfect world will resize to the size of the
 script display.
 Sane thing with the Settings Managers**
```
# BinMenu
```
Bin Menu is a simple console based menu that reads in what exe's are in the base sub-folders
 and which *PS1's are in the base and lists them on a menu for you.
Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds.
You can add your own entries to the end of the program menu list if you want up to 100.
There is a toggle to show the add entries or not.
Edit the json put the bin* files in your base folder and run it.
It will automatically run you through creating the INI it uses to store
 the Program Menu file list in.
Have fun I did. And it works I use it EVERY day.
(Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts.
 Then in all the sub folders of bin are all my programs I use that are portable.
 The list in the picture below sums it up.)
See more extensive description in the readme in the folder.
For Updates check the description in the readme in the BinMenu folder.

Usage: BINMENU.PS1
```
<img src="/img/BinMenu1.png" alt="BinMenu"/>
<img src="/img/BinMenu2.png" alt="BinMenu"/>

# Convert-Script
```
This is my user.CSS to user.JS UserStyle to UserScript converter.
It is for use on scripts that you need to covert for use in Tampermonkey
 or any of the *monkey JS injection extensions.
One example of a good use is for Old Edge browser.
Update: Can convert VERY large files now.
 I don't read the whole file in now I read it in one line at a time so files can be huge.
Update:  I open this script up and scared my self lol.
 I had written it very near the beginning of my learning curve I COMPLETELY rewrote it.
 Much smaller WAY safer and incredibly faster. NOW it deserves to be a public facing script.

Usage: Convert-Script.PS1 -INFILE [<FullPathToFileToRead>] -OUTFILE [<FullPathToFileToWrite>]
Usage: Convert-Script.PS1 [<FullPathToFileToRead>] [<FullPathToFileToWrite>]
```
# Imageto64
```
Feed it a filename of a image file and it feeds you back the base64 info ready to put into your script files.

Usage: IMAGETO64.PS1 -Path [<FullPathToImageFile>] -OutFile [<OptionalFullPathForTextFileOut>]
```
# Clearlogs
```
This clears most to all of your windows logs for you.
(All of them except locked or in use as we fly by them).
Update: Added Write Progress to the script so that there is some interaction with users
 in the form of a Progress Bar.
Update: Added the [bool] $Loud so that you can see the Verbose output.
 Clearlogs -Loud 1 or -Loud $True
Updated: It now gets the total number of log files, sets the math for the Progress bar and runs the routines.
 It also checks if it is ADMIN (Elevated) and if not, Elevates and runs.
 (It needs to be admin to delete clear logs). Should work for everyone well now.
Update: Added my own super simple progress bar that you can change the progress character. Updated to Version 2

Usage: CLEARLOGS.PS1
```
# Get-SysInfo
```
A simple system information example containing how to expand a looped composed ($var + #) variable,
 and how to  draw out simple info using Get-CimInstance. Updated: To only use Get-CimInstance.

Usage: GET-SYSINFO.PS1
```
<img src="/img/ShowSysInfo.png" alt="SysInfo"/>

# Put-Pause
```
I Wanted something to replace Read-Host that timed out for my scripts.
Update: I included "$ESC = [char]27" so I can use a color Prompt.
  That addition is in most of my scripts and how I do ASCII color.
  Normally in My scripts I use "$ESC = [chr]27"
  In the Prompt of this script ESC is replaced with that value. replace("ESC", $ESC)
  So the following will result in a colored prompt.
  Example: Put-Pause -Prompt "ESC[1;91m[ESC[1;97mMake A SelectionESC[1;91m]ESC[1;97m:"
Updated: Added -Max 0 When you use -Max 0 the prompt does not time out and continues to
 wait for a keypress. -Default is disabled and -Echo is set to True.
Updated: Added a clear keyboard buffer to catch extra input and throw it away.

Usage: Put-Pause -Prompt <[String] Standard prompt> -Max <[int] Milliseconds> -Default <[string] single key default>
Usage: Put-Pause -Prompt "[Make A Selection]:"
Usage: Example: $a = Put-Pause -Prompt "Do you seem interested? (Y/N):" -Default "N"; Say $a
Usage: Color Example: Put-Pause -Prompt "ESC[1;91m[ESC[1;97mMake A SelectionESC[1;91m]ESC[1;97m:"
Usage: Color Example: Put-Pause -Prompt "[Make A Selection]:" -Max 0
```
# Put-WinSize (Formally Set-WinSize)
```
My script paste-in that allows the console buffer and window to be resized.
I tried 3 or 4 from others and they didn't work so I put this together and use it because it simply works.
(Going to turn it into a Function soon) Update: Moved it closer to a function, Working well.

Usage: Paste into your script file as a function and call to it.
```
# Put-Winposition
```
This will set a named window to the desired position.

Usage: Put-WinPosition.ps1 [-WinName] <String> [-WinX] <Int32> [-WinY] <Int32>
       Optionally
Usage: Put-WinPosition.ps1 [-WinName] <String> [-WinX] <Int32> [-WinY] <Int32> [[-Width] <Int32>] [[-height] <Int32>]
```
# Discord Stuff
```
Here is where I put any Discord related PowerShell script stuff.
```
# Google
```
This is my console script example that sends your search to Google in the browser.
You can add IMAGE, VIDEO or NEWS to the beginning of the line to go directly to those search pages.

Usage: GOOGLE.PS1 [<something to search>] Searches ALL normally.
Usage: GOOGLE.PS1 IMAGE [<something to search>]
Usage: GOOGLE.PS1 VIDEO [<something to search>]
Usage: GOOGLE.PS1 NEWS [<something to search>]
```
# Remove-Empty
```
Remove-Empty is a simple little script that removes all empty Lines in a given text file.
Feed it a file and all the blank lines are removed.

Usage: REMOVE-EMPTY.PS1 [<FullPathToFileToProcess>]
```
# Remove-WindowsApps
```
Remove-WindowsApps deletes Windows 10 apps from your system.
  Also makes it so they shouldn't reinstall by removing AppX Provisioning.
  Edit the file and comment out those that you want to keep.

Usage: REMOVE-WINDOWSAPPS.PS1
```
# ASAY and NOTIFY
```
This now uses BurntToast from the PowerShellGallery
https://www.powershellgallery.com/packages/BurntToast

ASAY and NOTIFY are really the same file. They will send a notification to the standard
 windows notification center.
I use it in my scripts to let me know when any event has happened I might want to see.
The format is simple, without quote ASAY <any text you want to send to the notify>
  or WITH quotes if you use punctuation ASAY "This text, and that text"
I also call these scripts from a LOT of my scripts to give notifications on windows 10.
There is also a Linux and Dos version.
The Linux files you need to edit and put your username over mine and edit atune
 to set the path to a valid sound file.

Usage: Without Quotes do NOTIFY.PS1 [<message to send to output>]
 or ASAY.PS1 [<message to send to output>]
Usage: With Quotes do NOTIFY.PS1 [<"message to send, include punctuation, to output">]
 or ASAY.PS1 [<"message to send, include punctuation, to output">]
Usage: Linux: Without Quotes do notify [<message to send to output>] or asay [<message to send to output>]
```
# Search
```
Search is a script that searches any text, as a filename parameter, in the path you give.
From the whole drive down to just a folder it will list all matches found.

Usage: Without Star (SHIFT-8) SEARCH.PS1 [<SearchPhrase>] [<BasePathToStartIn>] (The star is added automatically)
```
# Env (environment)
```
This is my script to list a (one) environment variable from system ENV variable (no quotes)
 or from the variable drive ENV 'variable' (single quote). If you just do ENV it will list ALL variable

Usage: Does all variables ENV.PS1
Usage: Without quotes ENV.PS1 [<VaribleToSearch>]
Usage: With single quote ENV.PS1 [<'VaribleToSearch'>] (Works on variable drive)
```
# Ver (Version)
```
I was missing the sort of version program I wanted so here it is. Just type VER.

Usage: VER.PS1
```
# Reboot
```
I wanted (needed) a reboot command in windows. So TaDA :) It is used REBOOT.PS1 STOP|SHUTDOWN|RESTART|REBOOT
Just REBOOT alone is the same as REBOOT RESTART
I also call this script from the BinMenu above

Usage: REBOOT.PS1 (The same as REBOOT RESTART)
Usage: REBOOT.PS1 STOP or REBOOT.PS1 SHUTDOWN
Usage: REBOOT.PS1 RESTART or REBOOT.PS1 REBOOT`
```
# Run-CheckDisk
```
This script is my once a week CHKNTFS routine. It Sets drive C: and D: dirty then reboots to preform the disk check.
I also call this script from the G QuickMenu of the BinMenu above.
NOTE: Check out the script because it DOES NOT ask again it JUST RUNS. But it does what it should.
It Will produce a message in Windows that you need to reboot to check the drives, which is the idea.

Usage: RUN-CHECKDISK.PS1
```
# Repair-windows
```
This is just a pretty console menu for SCF and DISM.
I wrote it for my family and friends with plenty of help and explanations
 to get them through running it correctly.
It includes the 4 normal possibilities.
And we all have used it hundreds of times to make sure our Windows 10 was operating well.

Usage: REPAIR-WINDOWS.PS1 (Runs Menu)
Usage: REPAIR-WINDOWS.PS1 SCAN (Directly runs SFC.EXE /SCANNOW)
Usage: REPAIR-WINDOWS.PS1 Check (Directly runs DISM.EXE /Online /Cleanup-Image /ScanHealth)
Usage: REPAIR-WINDOWS.PS1 REPAIR (Directly runs DISM.EXE /Online /Cleanup-Image /e /RestoreHealth /Source:WIM:E:\ sources\install.wim:1 /Source:WIM:E:\sources\install.wim:1) (E=Cd Drive where I mount the windows cd when I run it.)
Usage: REPAIR-WINDOWS.PS1 RESET (Directly runs DISM.EXE /Online /Cleanup-Image /StartComponentCleanup /Source:WIM:E:\ sources\install.wim:) (E=Cd Drive)
```
<img src="/img/Repair-Windows1.png" alt="Repair-Windows"/>
<img src="/img/Repair-Windows2.png" alt="Repair-Windows"/>
