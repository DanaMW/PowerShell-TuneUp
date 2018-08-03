# BinMenu

```
BinMenu is my answer to not being able to find a PowerShell menu that worked for me.
I keep all my portable software in subfolders off one folder. (C:\bin)
Well i needed a menu that reads it in even when the software changes.
This is a first draft and is working on my machines with PowerShell Core 6.0.3.
It Also will in the next release read in my scripts that are stored in that folder.


To use it place the two files in the desired folder.
Open with your text editor both BinMenuRW.ps1 and BinMenu.ps1 and change the "BASE" folder at the top.
Save BinMenu.ps1, then back to editing BinMenuRW.ps1.
Uncomment the "BREAK" (Comments show you where) then save and run it.
The file it creates you then edit.
Take out the lines of the programs that YOU WANT. NOTE Leave in the programs you DONT WANT.
Save that file as BinMenu.csv.
Then edit BinMenuRW.ps1 And recomment the BREAK that you uncommented and save.
Rerun BinMenuRW and it creates the BinMenu.ini that BinMenu reads. 
Run BinMenu.ps1 and ...
There you are .. a custom menu with your current exe programs.

```
Note: I have not tested it in a polder with spaces in the path yet. If you do ;et me know how it goes :)
