# BinMenu

```
BinMenu is my answer to not being able to find a PowerShell menu that worked for me.
I keep all my portable software in subfolders off one folder. (C:\bin)
Well i needed a menu that reads it in even when the software changes.
This is a tuned up first draft and is working on my machines with PowerShell Core 6.0.3.
In this update it scans the folder and lists all the *.PS1 scripts files for you.
Use the A of SCRIPT menu option to run scripts. A include the ps1 extension.
No need to if you typoe SCRIPT.


To use it place the two files in the desired folder.
Open with your text editor both BinMenuRW.ps1 and BinMenu.ps1 and change the "BASE" folder at the top.
Save them then run BinMenuRW.ps1 -MAKE [<1> or <$True>](Required to make)
You can optionally include -BASE [<BaseFolder>] -Editor [<FullPathToYourPreferredEditor>]
The file it creates you should automaticlly edit.
Take out the lines of the programs that YOU WANT. NOTE Leave in the programs you DONT WANT.
Save that file then back at the run window hit enter. It automaticlly runs BinMenuRW.
It runs it with not parameters. You can do that at any time yourself to adjust for any manual edits.
It should then run BinMenu.ps1 and ...
There you are, a custom menu with your current exe programs and ps1 scripts.
```
Note: I have not tested it in a folder with spaces in the path yet, but I assume it should work.
Since I am new to PowerShell as I learn more I keep improving it.
