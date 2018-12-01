# PowerShell-TuneUp
```
PowerShell Scripts and snips for the learning curve. All are working in PowerShell Code 6.1.X unless they say otherwise. If you have improvements to them please share them with me, thats what this is about for me. Hope they help someone else. Enjoy. Note: In some of the scripts here I use console window resizing code. If you get weird error(s) just make the window larger than the displayed script and it wont error any more and in a perfect world will resize to the size of the script display. With the Settings managers you can hit enter a couple times to do just that.
```
# BinMenu
```
Bin Menu is a simple console based menu that reads in what exe's are in the base sub-folders and which *PS1's are in the base and lists them on a menu for you. Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds. The script list can be sorted using the settings as follows: VERT or HORZ then sort Alpha, Name length or randomly. You can set how many script names to list in each row. And you can add additional lines to the bottom of the list to help make it look better. Then you can add your own entries to the end of the program menu list if you want up to 100. There is also a toggle to show the scripts or not, and a toggle to show the add entries or not. it has some personal debug stuff in it that has a toggle. Edit the json put the bin* files in your base folder and run it. It will automatically run you through creating the INI it uses to store the Program Menu file list in. Have fun I did. And it works I use it EVERY day. (Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts. Then in all the sub folders of bin are all my programs i use that are portable . The list in the picture below sums it up.)
Note: Script read is goofy when you have almost 100 ps1 scripts so I toggle it off and I am re-writing it.
UpDate: ScriptRead was re-written to simply be ON or OFF and neatly display as it should.
To many options messed it up Now it displays nicely on  the bottom.
```
<img src="/img/ShowBinMenu.png" alt="BinMenu"/>

# Convert-Script
```
That is my CSS to JS converter for use on Tampermonkey and Edge browser. Very simply, it copies over most of the header to UserScript and puts quotes outside of the script. It also added the rest of the required JS and will work in its current form. You will need to edit the header and remove a Bracket in quotes in the bottom. (That one pared with the removed @Moz*, Don't forget to add an // @include <URL to match>) Update: Can convert larger files now.
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
## Get-Files
```
(It is in the GO anywhere directory) Just a simple little routine to get a directory listing in color and single file.
```
## The [[[GO]-]Anywhere] Group
```
This little group of scripts is my way for getting around in the console. You can enter folder names as follows: GO-FOLDER or GO FOLDER and if it is a repo folder you can add the third parameter GO-MAINREPO REPONAME or GO MAINREPO REPONAME. then because I wanted to stick with this simple short setup you can also use it just like Set-Location. GO .. or GO D:\Downloads or GO ROOT D or GO "\\MACHINENAME\SHAREDFOLDER"
```
## ASAY and NOTIFY
```
ASAY and NOTIFY are really the same file. They will send a notification to the standard windows notification center. I use it in my scripts to let me know when any event has happened i might want to see. The format is simple, without quote ASAY <any text you want to send to the notify>
```
