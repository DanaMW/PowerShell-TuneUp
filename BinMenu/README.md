# BinMenu

```
BinMenu is my answer to not being able to find a PowerShell menu that worked for me.
I keep all my portable software in subfolders off one folder. (C:\bin)
Well i needed a menu that reads it in even when the software changes.
This is a tuned up second draft and is working pretty on my machines with
PowerShell Core 6.0.X.

To use it place BinMenu.ps1 desired folder. Run it alone or with parameter -Base [<BaseFolder>]
A couple settings in the file are $Base, $editor and $ScriptRead $True or $False. (Do or dont read in the
list of PS1 scripts in the folder). The ini can easily be edited once created to add custom programs.
It will auto create the needed INI on run or there is a menu option to run it. Just say yes or no to each.

Note: I have not tested it in a folder with spaces in the path yet, but I assume it should work.
Since I am new to PowerShell as I learn more I keep improving it.
Many updates faster functions and reads. Now you can toggle the PS1 script reads-in $True or $False.
Anyway love me some PowerShell.
Update: My new SysInfo is also built into the BinMenu now as a function.
Update: Added window resize.
Update: Now reads config from a json file.
Update: Can load directories.
Update: Moved SysInfo to its own file.
Update: can define user file/folder adds to be appended to the menu after the folders are loaded.
    You add those in the BinMenu.jsom file as you will see.
Update: can toggle Menu adss on off and Script reads On off.
Update: Added setting DBug and SortMethod for ScriptRead. Corrected many small scripting methods
    concerning Intergers.
Update: Added new $SortMethod for scripts can sort 0-Alphabetical 1-Random 2-Length of scriptname.
    Added $ExtraLine so you can add lines to the Vertical script sort to fit them to your liking.
    Added $SortDir so you can sort them HORZ or VERT (In rows or columns).
    $SPLine for how many scripts to list in a line when Horizonal. $ExtraLine handles Vertical.
    AddItems can ow also be a Directory and explorer will open them.
Update: Added the ability to include a argument to command lines of read in and additems.
    That allows for you to call one program to run another and opens up almost anything.
Update: Created a BinMenu Settings Manager. All settings of BinMenu can be set changed or removed from it.
    I created it as a function but in its own file for now key Z from bunmenu to use it.
Update: Menuadds "0" now removes them from the menu as it should. "1" puts them back if you have any.
UpDate: Changed the JSON config format for faster readng (Cant use new menu or settings manageunless you change).
Finished the BinMenu Settings manager. ALL settings can be edited from the settings manager.
```
<img src="/img/ShowBinMenu.png" alt="BinMenu"/>
