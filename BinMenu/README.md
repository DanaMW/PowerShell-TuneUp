# BinMenu

# Information

```
There are four scripts that make up this set, (1)BinMenu.ps1 is the main script and the one to run AFTER you edit (2)BinMenu.json, this configuration for the program. You can use (3)BinSM.ps1 (Settings Manager) to edit the JSON. Toggle settings on off and such. (4)BinIM.ps1 is the ini creator. More on that below. Two more notes. I use "SET-ALIAS SAY WRITE-HOST" in all my scripts so include it in your profile or edit all the SAY to WRITE-HOST.
Lastly I Use the PowerShell environment $ENV:BASE in all my scripts.
This is your base ps1 script folder.
----
Bin Menu is a simple console based menu that reads in what exe's are in the base sub-folders and which *PS1's are in the base and lists them on a menu for you. Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds. You can add your own entries to the end of the program menu list if you want up to 100. There is also a toggle to show the scripts or not, and a toggle to show the add entries or not. Edit the json put the bin* files in your base folder and run it. It will automatically run you through creating the INI it uses to store the Program Menu file list in. Have fun I did. And it works I use it EVERY day. (Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts. Then in all the sub folders of bin are all my programs I use that are portable. The list in the picture below sums it up.)
----
BinMenu is my answer to not being able to find a PowerShell menu that worked for me. I keep all my portable software in subfolders off one folder. (C:\bin) Well I needed a menu that reads it in even when the software changes. This is a tuned up second draft and is working pretty well on my machines with PowerShell Core 6.2.X. To use it place BinMenu.ps1 and BinMenu.json in the desired folder. Run it. The settings in the json file are editable easily in the BMSM.ps1 Settings manager. BinMenu will auto create the needed INI on run or there is a menu option to run it. Just say yes or no to each. Note: I have not tested it in a folder with spaces in the path yet, but I assume it should work. Since I am new to PowerShell as I learn more I keep improving it. Many updates faster functions and reads. Now you can toggle the PS1 script Reads in $True or $False. Anyway love me some PowerShell.
_Update_: Added window resize.
_Update_: Now reads config from a json file.
_Update_: Can load directories.
_Update_: can define user file/folder adds to be appended to the menu after the folders are loaded. You add those in the BinMenu.json file as you will see.
_Update_: can toggle Menu adds on off and Script reads On off.
 Corrected many small scripting methods concerning Integers.
_Update_: AddItems can now also be a Directory and explorer will open them.
_Update_: Added the ability to include a argument to command lines of read in and add items. That allows for you to call one program to run another and opens up almost anything.
_Update_: Created a BinMenu Settings Manager. All settings of BinMenu can be set changed or removed from it. I created it as a function but in its own file for now key Z from BinMenu to use it.
_Update_: Menuadds "0" now removes them from the menu as it should. "1" puts them back if you have any.
_Update_: Changed the JSON config format for faster reading (Cant use new menu or settings manager unless you change). Finished the BinMenu Settings manager. ALL settings can be edited from the settings manager.
_Update_: Shrunk up that way too big top of the menu.
_Update_: Finalized the json style completed all scripts Version 1 released.
_Update_: I improved the BinMenu Settings manager by cleaning up console window positioning as it runs. Added more options, mainly Verify and Test run. Verify will end up being something that runs auto every time you edit or add. Also added window fix routines when you hit enter in BinMenu similar to
 the Manager. Note: Script read is goofy when you have almost 100 ps1 scripts so I toggle it off and I am re-writing it.
_Update_: ScriptRead was re-written to simply be ON or OFF and neatly display as it should. To many options messed it up. Now it displays nicely on the bottom. Also it SHOULD redraw the screen to the correct dimensions, Just hit ENTER a couple of times if not.
_Update_: Got rid of the SLOW and limited switch menu and did my own While{} loop menu. REAL fast and no longer a numeric  limit to the number of menu items. Saved around 200 lines of script. (took out my debug crap too.)
_Update_: I put the INI maker back in it's own file BINIM.ps1 to make the menu a tiny bit faster.
_Update_: Added a small QuickMenu when you press G (run a ps1 script) to get to the clearlogs and reboot options I use ALL the time. (Saves me typing)
_Update_: Added an option 5 on the G QuickMenu to call the script Run-CheckDisk.ps1 Which I call Complete CheckDisk
_Update_: Pressing E allows you to switch back and forth from the Program Screen and the Script Screen where you find all your scripts numbered from 100 on up. Pressing that corresponding number at any time in the script will run that script for you. The Scripts screen does not need to be visible to run a ps1 script. I will tie this new stuff into the other menus and whole script completely over the next little while.
_Update_: Corrected when an entry is invalid to return "not valid" properly.
_Update_: Turned the script reads into their own script so I can do more with them. This is just a first draft of BinScript.ps1 a lot more to come. Also FINALLY got the math correct for the columns (I am pretty sure) so it splits up correctly. Took scriptmode OUT of the json and shortened the code.
_Update_: Added a call to the new script Put-WinPosition and entries in the BinMenu.json This added call centers the window for me when it runs or when you hit enter. You can edit window placement IN the call to the script.
```

<img src="/img/BinMenu1.png" alt="BinMenu"/>
<img src="/img/BinMenu2.png" alt="BinMenu"/>
