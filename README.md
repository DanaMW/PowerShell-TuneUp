# PowerShell-TuneUp
```
PowerShell Scripts and snips for the learning curve.
All are working in Powershell Code 6.0.X unless they say otherwise.
If you have improvements to them please share them with me, thats what this is about for me.
Hope they help someone else. Enjoy.
Note: In some of the scripts here I use console window resizing code. If you get weird error(s)
    just make the window larger than the displayed script and it wont error any more and in a perfect
    world will resize to the size of the script display. With the Settings managers you can hit enter
    a couple times to do just that.
```
# BinMenu
```
Bin Menu is a simple console based menu that reads in what exe's are in the sub-folders and which
*PS1's are in it and lists them on a menu for you.
```
<img src="/img/ShowBinMenu.png" alt="BinMenu"/>

# Convert-Script
```
That is my CSS to JS converter for use on Tampermonkey and Edge browser. Very simply,
it copies over most of the header to UserScript and puts quotes outside of the script.
It also added the rest of the required JS and will work in its current form.
You will need to edit the header and remove a Bracket in quotes in the bottom.
(That one pared with the removed @Moz*, Dont forget to add an // @include <url to match>)
Update: Can convert larger files now.
```
# Imageto64
```
Feed it a filename of a image file and it feeds you back the base64 info ready to put into
your script files.
```
# Clearlogs
```
This clears most to all of your windows logs for you. (All of thwm except locked or in use as we fly by them).
Update: Added Write Progress to the script so that there is some interaction with users in the form of a Progrss Bar.
Update: Added the [bool] $Loud so that you can see the Verbose output. Clearlogs -Loud 1 or -Loud $True
Updated: It now gets the total number of log files, sets the math for the Progress
bar and runs the routines. It also checks if it is ADMIN (Elevated) and if not, Elevates
and runs. (It needs to be admin to delete clear logs). Should work for everyone well now.
```
# Get-SysInfo
```
A simple system information example containing how to expand a
looped composed ($var + #) variable, and how to  draw out
simple info using Get-CimInstance.
Updated: To only use Get-CimInstance.
```
<img src="/img/ShowSysInfo.png" alt="SysInfo"/>

# Set-ConWin
```
My script paste-in that allows the console buffer and window to
be resized. I tried 3 or 4 from others and they didnt work so I
put this together and use it because it simply works.
(Going to turn it into a Function soon)
```
# Discord Stuff
```
Here is where I put any Discord related powershell script stuff.
```
# Google
```
This is my console script example that sends your search to Google
in the browser. You can add -IMAGE, -VIDEO or -NEWS to the begining
or end of the line to go directly to those search pages.
```
# Remove-Empty
```
Remove-Empty is a simple little script that removes all empty Lines
in a given text file. Feed it a file and all the blank lines are remmoved.
```
