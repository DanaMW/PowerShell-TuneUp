# Repository Information

For help and/or information on my PowerShell Core setup head to the Development tab on my site: <https://danamw.github.io>

---

## PowerShell-TuneUp

<a><p align=center>A couple notes about my scripts. I use "SET-ALIAS SAY WRITE-HOST" in all my scripts. So include that in your profile or edit all the SAY to WRITE-HOST, and edit out all the color codes. Lastly I Use the PowerShell environment $ENV:BASE in all my scripts. This is your base *.ps1 script folder. Feel free to write me an DanaMW at gmail.com if you want help. But I think just checking out the script will do it for ya. I wanted to mention that BinSM and DelaySM are a good example  for writing to and reading from json files with PowerShell. Instructions on the net sucked but I worked it out and those two files work perfectly so you should have what you need to clip them and add them to your</p></a>

<a><p align=center>PowerShell Scripts and snips for the learning curve. ALL are working in PowerShell Core 6.x unless they say otherwise. If you have improvements to them please share them with me, thats what this is about for me. Hope they help someone else. Enjoy. **NOTE: In a lot of the scripts here I use console window resizing code. If you get weird error(s) just make the window larger than the displayed script and hit enter. In a perfect world will resize to the size of the script display. Same thing with the Settings Managers** Note: **I also use calls to Put-Pause, Put-WinPosition, Clearlogs Run-Checkdisk AND ASAY and/or Notify (which uses BurntToast- see below) Add them to the $env:BASE folder or edit out the calls.**</p></a>

---

## BinMenu

<a><p align=center>Bin Menu is a simple console based menu that reads in what EXE's are in the base sub-folders and which *PS1's are in the base and lists them on a menu for you. Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds. You can add your own entries to the end of the program menu list if you want up to 100. There is a toggle to show the add entries or not. Edit the json put the bin* files in your base folder and run it. It will automatically run you through creating the INI it uses to store the Program Menu file list in. Have fun I did. And it works I use it EVERY day. (Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts. Then in all the sub folders of bin are all my programs I use that are portable. The list in the picture below sums it up.) See more extensive description in the readme in the folder. For Updates check the description in the readme in the BinMenu folder.</p></a>

- Usage: BINMENU

<img src="/img/BinMenu1.png" alt="BinMenu"/>
<img src="/img/BinMenu2.png" alt="BinMenu"/>

---

## Write-Color (WC) and Write-ColorPrompt (WCP)

<a><p align=center>Functions added To Profile For New Coloring Method. I use the "~" now. Not the "#" WC "#red~word1~ ~green~word 2~" Go to my website on the development tab for copies of my profiles. You might even find some help there, who knows.</p></a>

---

## Convert-Script

<a><p align=center>This is my user.CSS to user.JS UserStyle to UserScript converter. It is for use on scripts that you need to covert for use in Tampermonkey or any of the *monkey JS injection extensions. One example of a good use is for Old Edge browser. Update: Can convert VERY large files now. I don't read the whole file in now I read it in one line at a time so files can be huge. I open this script up and scared my self lol. I had written it very near the beginning of my learning curve I COMPLETELY rewrote it. Much smaller WAY safer and incredibly faster. NOW it deserves to be a public facing script.</p></a>

- Usage: Convert-Script1 -INFILE <FullPathToFileToRead> -OUTFILE <FullPathToFileToWrite>
- Usage: Convert-Script <FullPathToFileToRead> <FullPathToFileToWrite>`

---

## Imageto64

<a><p align=center>Feed it a filename of a image file and it feeds you back the base64 info ready to put into your script files.</p></a>

- Usage: IMAGETO64 -Path <FullPathToImageFile> -OutFile <OptionalFullPathForTextFileOut>`

---

## Clearlogs

<a><p align=center>This clears most to all of your windows logs for you. (All of them except locked or in use as we fly by them). Update: Added Write Progress to the script so that there is some interaction with users  in the form of a Progress Bar. Added the [bool] $Loud so that you can see the Verbose output. Clearlogs -Loud 1 or -Loud $True. It now gets the total number of log files, sets the math for the Progress bar and runs the routines. It also checks if it is ADMIN (Elevated) and if not, Elevates and runs. (It needs to be admin to delete clear logs). Should work for everyone well now. Added my own super simple progress bar that you can change the progress character. Updated to Version 2.</p></a>

- Usage: CLEARLOGS

---

## Get-Files

<a><p align=center>A script I call from the other scripts. Just a DIR sort of replacement. With colors. Includes a /w (wide) display</p></a>

- Usage: GET-FILES <normal filesearch parameters>
- Usage: GET-FILES <normal filesearch parameters> /w (Wide format)
- Usage: GET-FILES . or with no parmeters (Displays current folder)
- Usage: GET-FILES . /w (Displays current folder WIDE format)

---

## Get-SysInfo

<a><p align=center>A simple system information example containing how to expand a looped composed ($var + #) variable, and how to  draw out simple info using Get-CimInstance. Updated yo only use Get-CimInstance.</p></a>

- Usage: GET-SYSINFO

<img src="/img/ShowSysInfo.png" alt="SysInfo"/>

---

## Put-Pause

<a><p align=center>I Wanted something to replace Read-Host that timed out for my scripts. Added -Max 0 When you use -Max 0 the prompt does not time out and continues to wait for a keypress. -Default is disabled and -Echo is set to True. Added a clear keyboard buffer to catch extra input and throw it away. It now uses the color method Write-ColorPrompt (WCP) Changed the Separator from # to ~.</p></a>

- Usage: Put-Pause -Prompt <String> -Max <Milliseconds> -Default <single key default>
- Usage: Put-Pause -Prompt "[Make A Selection]: "
- Usage: $a = Put-Pause -Prompt "Do you seem interested? (Y/N): " -Default "N"
- Color Usage: Put-Pause -Prompt "~white~Clear the Screen?~ ~cyan~(~~white~Y~~cyan~/~~white~N~~cyan~)~~white~:~ "
- Color Usage: Put-Pause -Prompt "~white~Clear the Screen?~ ~cyan~(~~white~Y~~cyan~/~~white~N~~cyan~)~~white~:~ " -Max 0`

---

## Put-Vivaldi

<a><p align=center>I use Vivaldi browser sometimes because it, like Firefox, can have a custom user interface. My only beef was that they update it a lot and I would have to edit the files and copy over the custom css to add my changes every time they did. Well this script does the changes for me. You will only need to edit the top two folders in the script. Your custom css and your Vivaldi install base folder. then just run it.</p><a>

- Usage: Put-Vivaldi

---

## Put-WinSize (Formally Set-WinSize)

<a><p align=center>My script paste-in that allows the console buffer and window to be resized. I tried 3 or 4 from others and they didn't work so I put this together and use it because it simply works. (Going to turn it into a Function soon) Update: Moved it closer to a function, Working well.</p></a>

- Usage: Paste into your script file as a function and call to it.`

---

## Put-Winposition

<a><p align=center>This will set a named window to the desired position.</p></a>

- Usage: Put-WinPosition -WinName <String> -WinX <Int32> -WinY <Int32>
Optionally
- Usage: Put-WinPosition -WinName <String> -WinX <Int32> -WinY <Int32> -Width <Int32> -height <Int32>

---

## Discord Stuff

<a><p align=center>Here is where I put any Discord related PowerShell script stuff.</p></a>

---

## Google

<a><p align=center>This is my console script example that sends your search to Google in the browser. You can add IMAGE, VIDEO or NEWS to the beginning of the line to go directly to those search pages.</p></a>

- Usage: GOOGLE <something to search> Searches ALL normally.
- Usage: GOOGLE IMAGE <something to search>
- Usage: GOOGLE VIDEO <something to search>
- Usage: GOOGLE NEWS <something to search>

---

## Remove-Empty

<a><p align=center>Remove-Empty is a simple little script that removes all empty Lines in a given text file. Feed it a file and all the blank lines are removed.
</p></a>

- Usage: REMOVE-EMPTY <FullPathToFileToProcess>

---

## Remove-WindowsApps

<a><p align=center>Remove-WindowsApps deletes Windows 10 apps from your system. Also makes it so they shouldn't reinstall by removing AppX Provisioning. Edit the file and comment out  those that you want to keep.</p></a>

- Usage: REMOVE-WINDOWSAPPS

---

## ASAY and NOTIFY

<a><p align=center>This now uses BurntToast from the PowerShellGallery</p></a>


<a><center><https://www.powershellgallery.com/packages/BurntToast></center></a>

<a><p align=center>ASAY and NOTIFY are really the same file. They will send a notification to the standard  windows notification center. I use it in my scripts to let me know when any event has happened I might want to see. The format is simple, without quote ASAY <any text you want to send to the notify> or WITH quotes if you use punctuation ASAY "This text, and that text" I also call these scripts from a LOT of my scripts to give notifications on windows 10. There is also a Linux and Dos version. The Linux files you need to edit and put your username over mine and edit atune to set the path to a valid sound file.</p></a>

- Usage: NOTIFY or ASAY <message to send to output>
- Usage: NOTIFY or ASAY <"message to send, include punctuation, to output">
- Usage: Linux: Without Quotes do notify [<message to send to output>] or asay [<message to send to output>]

---

## Search

<a><p align=center>Search is a script that searches any text, as a filename parameter, in the path you give. From the whole drive down to just a folder it will list all matches found.</p></a>

- Usage: SEARCH <SearchPhrase> [<BasePathToStartIn> (The star is added automatically)

---

## Env (environment)

<a><p align=center>This is my script to list a (one) environment variable from system ENV variable (no quotes) or from the variable drive ENV 'variable' (single quote) If you just do ENV it will list ALL variable</p></a>

- Usage: ENV (Does all variables)
- Usage: ENV <VaribleToSearch> (Without quotes)
- Usage: ENV <'VaribleToSearch'> (With single quote)(Works on variable drive)

---

## Ver (Version)

<a><p align=center>I was missing the sort of version program I wanted so here it is. Just type VER.</p></a>

- Usage: VER.PS1

---

## Reboot

<a><p align=center>I wanted (needed) a reboot command in windows. So TaDA :) It is used REBOOT.PS1 STOP|SHUTDOWN|RESTART|REBOOT Just REBOOT alone is the same as REBOOT RESTART I also call this script from the BinMenu above</p></a>

- Usage: REBOOT (The same as REBOOT RESTART)
- Usage: REBOOT STOP or REBOOT SHUTDOWN
- Usage: REBOOT RESTART or REBOOT REBOOT

---

## Run-CheckDisk

<a><p align=center>This script is my once a week CHKNTFS routine. It Sets drive C: and D: dirty then reboots to preform the disk check. I also call this script from the G QuickMenu of the BinMenu above. NOTE: Check out the script because it DOES NOT ask again it JUST RUNS. But it does what it should. It Will produce a message in Windows that you need to reboot to check the drives, which is the idea.</p></a>

- Usage: RUN-CHECKDISK.PS1

---

## Repair-windows

<a><p align=center>This is just a pretty console menu for SCF and DISM. I wrote it for my family and friends with plenty of help and explanations to get them through running it correctly. It includes the 4 normal possibilities. And we all have used it hundreds of times to make sure our Windows 10 was operating well.</p></a>

- Usage: REPAIR-WINDOWS.PS1 (Runs Menu)
- Usage: REPAIR-WINDOWS.PS1 SCAN
- Usage: REPAIR-WINDOWS.PS1 Check
- Usage: REPAIR-WINDOWS.PS1 REPAIR
- Usage: REPAIR-WINDOWS.PS1 RESET

<img src="/img/Repair-Windows1.png" alt="Repair-Windows"/>
<img src="/img/Repair-Windows2.png" alt="Repair-Windows"/>
