# BinMenu
```
Bin Menu is a simple console based menu that reads in what exe's are in the base sub-folders and which *PS1's are in the base and lists them on a menu for you. Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds. The script list can be sorted using the settings as follows: VERT or HORZ then sort Alpha, Name length or randomly. You can set how many script names to list in each row. And you can add additional lines to the bottom of the list to help make it look better. Then you can add your own entries to the end of the program menu list if you want up to 100. There is also a toggle to show the scripts or not, and a toggle to show the add entries or not. it has some personal debug stuff in it that has a toggle. Edit the json put the bin* files in your base folder and run it. It will automatically run you through creating the INI it uses to store the Program Menu file list in. Have fun I did. And it works I use it EVERY day. (Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts. Then in all the sub folders of bin are all my programs I use that are portable . The list in the picture below sums it up.)
----
BinMenu is my answer to not being able to find a PowerShell menu that worked for me. I keep all my portable software in subfolders off one folder. (C:\bin) Well i needed a menu that reads it in even when the software changes. This is a tuned up second draft and is working pretty well on my machines with PowerShell Core 6.1.X.
To use it place BinMenu.ps1 and BinMenu.json in the desired folder. Run it. The settings in the json file are editable easily in the BMSM.ps1 Settings manager. BinMenu will auto create the needed INI on run or there is a menu option to run it. Just say yes or no to each. Note: I have not tested it in a folder with spaces in the path yet, but I assume it should work. Since I am new to PowerShell as I learn more I keep improving it. Many updates faster functions and reads. Now you can toggle the PS1 script reads-in $True or $False. Anyway love me some PowerShell.
Update: Added window resize.
Update: Now reads config from a json file.
Update: Can load directories.
Update: can define user file/folder adds to be appended to the menu after the folders are loaded. You add those in the BinMenu.json file as you will see.
Update: can toggle Menu adds on off and Script reads On off.
Corrected many small scripting methods concerning Integers.
Update: AddItems can now also be a Directory and explorer will open them.
Update: Added the ability to include a argument to command lines of read in and add items. That allows for you to call one program to run another and opens up almost anything.
Update: Created a BinMenu Settings Manager. All settings of BinMenu can be set changed or removed from it. I created it as a function but in its own file for now key Z from BinMenu to use it. Update: Menuadds "0" now removes them from the menu as it should. "1" puts them back if you have any.
Update: Changed the JSON config format for faster reading (Cant use new menu or settings manager unless you change).
Finished the BinMenu Settings manager. ALL settings can be edited from the settings manager.
Update: Shrunk up that way too big top of the menu.
Update: Finalized the json style completed all scripts Version 1 released.
Update: I improved the BinMenu Settings manager by cleaning up console window positioning as it runs.
Added more options, mainly Verify and Test run. Verify will end up being something that runs auto every time you edit or add.
Also added window fix routines when you hit enter in BinMneu similar to the Manager.
Note: Script read is goofy when you have almost 100 ps1 scripts so I toggle it off and I am re-writing it.
UpDate: ScriptRead was re-written to simply be ON or OFF and neatly display as it should.
To many options messed it up. Now it displays nicely on the bottom.
Also it SHOULD redraw the screen to the correct dimensions, Just hit ENTER a couple of times.
```
<img src="/img/ShowBinMenu.png" alt="BinMenu"/>
