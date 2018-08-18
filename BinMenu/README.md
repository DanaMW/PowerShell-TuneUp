# BinMenu

```
BinMenu is my answer to not being able to find a PowerShell menu that worked for me.
I keep all my portable software in subfolders off one folder. (C:\bin)
Well i needed a menu that reads it in even when the software changes.
This is a tuned up second draft and is working pretty on my machines with
PowerShell Core 6.0.X.

To use it place BinMenu.ps1 desired folder. Run it aloneor with parameter -Base [<BaseFolder>]
A couple settings in the file are $Base, $editor and $ScriptRead $True or $False. (Do or dont read in the 
list of PS1 scripts in the folder. The ini can easily be edited once created.
It will auto create on run or there is a menu option to run it.
```
Note: I have not tested it in a folder with spaces in the path yet, but I assume it should work.
Since I am new to PowerShell as I learn more I keep improving it.

Many updates faster functions and reads. Now you can toggle the PS1 script reads-in $True or $False. Anyway love me some PowerShell.

<img src="/img/ShowBinMenu.png" alt="BinMenu"/>
