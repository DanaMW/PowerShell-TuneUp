# Repository Information

For help and/or information on my PowerShell Core setup head to the Development tab on my site: <https://danamw.github.io>. You will also always find me (*recess*) on IRC at `irc.dal.net` or `irc.libera.chat` in room #StrangeScript.
Another note: Windows positioning does not work on the new tabbed Windows Terminal yet. But I am working on including it in all the scripts. (or disabling if detected) Not to long. Also proudest of my script Put-Pause.ps1 (below). This is something Powershell should have built in.

---

## PowerShell-TuneUp - Or as I like to say - I Love PowerShell

<a><p align=center>A couple notes about my scripts. I use `SET-ALIAS SAY WRITE-HOST` in *_all_* my scripts. So include that in your profile or edit all the SAY to WRITE-HOST, and edit out all the color codes. Lastly I Use the PowerShell environment \$ENV:BASE in all my scripts. This is your base \*.ps1 script folder. Feel free to write me at DanaMW at gmail.com if you want help. But I think just checking out the script will do it for ya. I wanted to mention that BinSM and DelaySM are a good example for writing to and reading from json files with PowerShell. Instructions on the net sucked but I worked it out and those two files work perfectly so you should have what you need to clip them and add them to yours.</p></a>

## My Profile Functions

```
Import-Module posh-git;
Import-Module oh-my-posh;
Import-Module Get-ChildItemColor;
Import-Module -Name PSReadline;
Import-Module PsGet;
Add-WindowsPSModulePath;
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
function Resolve-Error ($ErrorRecord = $Error[0]) {
    $ErrorRecord | Format-List * -Force
    $ErrorRecord.InvocationInfo | Format-List *
    $Exception = $ErrorRecord.Exception
    for ($i = 0; $Exception; $i++, ($Exception = $Exception.InnerException)) {
        $Exception | Format-List * -Force
        "$i" * 80
    }
}
function Write-Color($message = "") {
    [string]$pipedMessage = @($Input)
    if (!$message) {
        if ( $pipedMessage ) {
            $message = $pipedMessage
        }
    }
    if ( $message ) {
        $colors = @("black", "blue", "cyan", "darkblue", "darkcyan", "darkgray", "darkgreen", "darkmagenta", "darkred", "darkyellow", "gray", "green", "magenta", "red", "white", "yellow");
        $defaultFGColor = $host.UI.RawUI.ForegroundColor
        $CurrentColor = $defaultFGColor
        $message = $message.split("~")
        foreach ( $string in $message ) {
            if ( $colors -contains $string.Tolower() -and $CurrentColor -eq $defaultFGColor ) { $CurrentColor = $string }
            else {
                write-host -NoNewLine -f $CurrentColor $string
                $CurrentColor = $defaultFGColor
            }
        }
        write-host
    }
}
function Write-ColorPrompt($message = "") {
    [string]$pipedMessage = @($Input)
    if (!$message) {
        if ( $pipedMessage ) {
            $message = $pipedMessage
        }
    }
    if ( $message ) {
        $colors = @("black", "blue", "cyan", "darkblue", "darkcyan", "darkgray", "darkgreen", "darkmagenta", "darkred", "darkyellow", "gray", "green", "magenta", "red", "white", "yellow");
        $defaultFGColor = $host.UI.RawUI.ForegroundColor
        $CurrentColor = $defaultFGColor
        $message = $message.split("~")
        foreach ( $string in $message ) {
            if ( $colors -contains $string.Tolower() -and $CurrentColor -eq $defaultFGColor ) { $CurrentColor = $string }
            else {
                write-host -NoNewLine -f $CurrentColor $string
                $CurrentColor = $defaultFGColor
            }
        }
        write-host -NoNewline
    }
}
Function Get-SmallVer {
    $MyVer = $PSVersiontable | Select-Object -property PSVERSION | Format-Table -HideTableheader | Out-String -NoNewLine
    return WC "~darkcyan~[~~darkyellow~PowerShell $PSEdition $MyVer~~darkcyan~]~~white~ ~"
}
Set-Alias ghost Run-Ghost.ps1;
Set-Alias count countThis.ps1;
Set-Alias say Write-Host;
Set-Alias sayout Write-Output;
Set-Alias re Resolve-Error;
Set-Alias ge Get-Error;
Set-Alias l Get-ChildItemColor -option AllScope;
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope;
Set-Alias la Get-Files.ps1;
Set-Alias cc D:\bin\ccleaner\ccleaner64.exe;
Set-Alias whois "D:\bin\wscc\SysInternals Suite\WhoIs64.exe";
Set-Alias wc Write-Color;
Set-Alias wcp Write-ColorPrompt;
Set-Alias ClearRecycle Clear-RecycleBin;
Set-Alias ssh-agent "D:\bin\git\usr\bin\ssh-agent.exe";
Set-Alias ssh-add "D:\bin\git\usr\bin\ssh-add.exe";
Set-Alias wget Invoke-WebRequest;
Set-Alias mods Get-InstalledModule;
Set-Variable -Name BASE -Value D:\bin -Scope Global;
Set-Variable -Name ShellSpec -Value 'C:\Program Files\PowerShell\7\pwsh.exe' -Scope Global;
$agent_is_running = Get-Process | Where-Object { $_.ProcessName -like "ssh-agent*" };
if (!($agent_is_running)) { Start-SshAgent -Quiet; };
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete;
$host.privatedata.ProgressForegroundColor = "white";
$host.privatedata.ProgressBackgroundColor = "red";
# $host.UI.RawUI.BackgroundColor = “Black”;
$Host.UI.RawUI.ForegroundColor = “Gray”;
$Global:GetChildItemColorVerticalSpace = 0;
$Env:POWERSHELL_UPDATECHECK = 'GA';
# $ErrorView = 'CategoryView';
$Errorview = 'ConciseView';
D:\bin\repair-netloc.ps1;
WC "~darkcyan~[~~darkyellow~PowerShell Core~~darkcyan~][~~red~Profile.ps1~~darkcyan~]~~white~: Loaded all Functions and Aliases~";
```

<a><p align=center>PowerShell Scripts and snips for the learning curve. ALL are working in PowerShell Core 7.x unless they say otherwise. If you have improvements to them please share them with me, thats what this is about for me. Hope they help someone else. Enjoy. **NOTE: In a lot of the scripts here I use console window resizing code. If you get weird error(s) just make the window larger than the displayed script and hit enter. In a perfect world will resize to the size of the script display. Same thing with the Settings Managers

**Note:** `I also use calls to Put-Pause, Put-WinPosition, Clearlogs, Run-Checkdisk and ASAY/Notify (which uses Module BurntToast- see below) Add these scripts to the $env:BASE folder or edit out ALL the calls.`</p></a>

---

## BinMenu

<a><p align=center>Bin Menu is a simple console based menu that reads in what EXE's are in the base sub-folders and which _PS1's are in the base and lists them on a menu for you. Comes with a Settings Manager script that's deals with the BinMenu.json settings and Adds. You can add your own entries to the end of the program menu list if you want up to 100. There is a toggle to show the add entries or not. Edit the json put the bin_ files in your base folder and run it. It will automatically run you through creating the INI it uses to store the Program Menu file list in. Have fun I did. And it works I use it EVERY day. (Structure of my bin folder is c:\bin is in my path and contains all my ps1 scripts. Then in all the sub folders of bin are all my programs I use that are portable. The list in the picture below sums it up.) See more extensive description in the readme in the folder. For Updates check the description in the readme in the BinMenu folder. The second image is the Scripts option (e) on the menu.</p></a>

- Usage: `BINMENU`

<img src="/img/BinMenu1.jpg" alt="BinMenu"/>
<img src="/img/BinMenu2.jpg" alt="BinMenu"/>

---

## Write-Color (WC) and Write-ColorPrompt (WCP)

<a><p align=center>Functions added To Profile For New Coloring Method. I use the `~` now. Not the `#`. The funtion is shown above.</p></a>

- Usage: `WC "~red~Word 1~ ~green~Word 2~"`

---

## MiniMenu

<a><p align=center>This is a simple menu that you just edit in the options and then the commands to run. Then you just run the menu and pick the option. You should be able to easily figure this one out.</p></a>

- Usage: `MiniMenu`

---

## Nano

<a><p align=center>This is a simple call to nano in Windows WSL bash. It convert a windows path into a linux one and opens the file to edit. The routines in this script with strip off ".\" if your indicating a file in the current folder. You can do it without that bit if you use tab expanding of files/folders I stripped it out for us.</p></a>

- Usage: `nano Filename.txt`
- Usage: `nano C:\Windows\Filename.txt`

---

## Check-Prof

<a><p align=center>This is a simple script to display the path of your profile files. It is an example of reading and writing files along with simple formatting. It requires Write-Color in your profile.ps1 and the external script of Remove-Empty.ps1</p></a>

- Usage: `Check-Prof`

---

## Convert-Script

<a><p align=center>*No Longer Needed* This is my user.CSS to user.JS UserStyle to UserScript converter. It is for use on scripts that you need to covert for use in Tampermonkey or any of the \*monkey JS injection extensions. One example of a good use is for Old Edge browser. Update: Can convert VERY large files now. I don't read the whole file in now I read it in one line at a time so files can be huge. I open this script up and scared my self lol. I had written it very near the beginning of my learning curve I COMPLETELY rewrote it. Much smaller WAY safer and incredibly faster. NOW it deserves to be a public facing script.</p></a>

- Usage: `Convert-Script -INFILE FullPathToFileToRead -OUTFILE FullPathToFileToWrite`
- Usage: `Convert-Script FullPathToFileToRead FullPathToFileToWrite`

---

## Imageto64

<a><p align=center>Feed it a filename of a image file and it feeds you back the base64 info ready to put into your script files.</p></a>

- Usage: `IMAGETO64 -Path FullPathToImageFile -OutFile OptionalFullPathForTextFileOut`

---

## Clearlogs

<a><p align=center>This clears most to all of your windows logs for you. (All of them except locked or in use as we fly by them). I use this every day in my clean up routine. Update: Added Write Progress to the script so that there is some interaction with users in the form of a Progress Bar. Added the [bool] $Loud so that you can see the Verbose output. Clearlogs -Loud 1 or -Loud $true. It now gets the total number of log files, sets the math for the Progress bar and runs the routines. It also checks if it is ADMIN (Elevated) and if not, Elevates and runs. (It needs to be admin to delete clear logs). Should work for everyone well now. Added my own super simple progress bar that you can change the progress character. Updated to Version 2. If you want fast do it silently its pretty damn fast then without all the drawing stuff. I added a "hidden" mode so you can run it from any console. I doesn't resize and runs faster since there is limited info to the screen.</p></a>

- Usage: `CLEARLOGS`
- Usage: `CLEARLOGS -LOUD 1`
- Usage: `CLEARLOGS -SILENT 1`
- Usage: `CLEARLOGS -HIDDEN 1`

---

## countThis

<a><p align=center>It simply gives a count of characters between quotes</p></a>

- Usage: `countThis "anything you want a count of."`

---

## Cycle-Background

<a><p align=center>Working on a background script because i have 470 backgrounds and I want to control the minutes between. Windows 10 does not seem to display all the images and this stupid thing might help me figure out why.</p></a>

- Usage: `Cycle-background`

---

## Get-Files

<a><p align=center>A script I call from the other scripts. Just a DIR sort of replacement. With colors. I call it from the root group files. It works but is a very old and simple example.</p></a>

- Usage: `GET-FILES normal_filesearch_parameters`
- Usage: `GET-FILES .` or `GET-FILES` (Displays current folder)

---

## Get-SysInfo

<a><p align=center>A simple system information example containing how to expand a looped composed (\$var + #) variable, and how to draw out simple info using Get-CimInstance. Updated so it uses Get-CimInstance.</p></a>

- Usage: `GET-SYSINFO`

<img src="/img/ShowSysInfo.png" alt="SysInfo"/>

---

## Put-Input

<a><p align=center>This is new for PowerShell Core 7 and allows you to have a WinForm dialog for input. Make sure you have the newest DotNet SDK's.</p></a>

- Usage: `Put-Input`
- Usage: `Put-Input "Any text you want on the dialog:"`
- Usage: `$ans = Put-Input "What is your answer this this question?"`

---

## Put-Pause

<a><p align=center>*I Use this A LOT* I Wanted something to replace Read-Host that timed out for my scripts. Added -Max 0 When you use -Max 0 the prompt does not time out and continues to wait for a keypress. -Default is disabled and -Echo is set to True. Added a clear keyboard buffer to catch extra input and throw it away. It now uses the color method Write-ColorPrompt (WCP) (This is a function in my profile above) Changed the Separator from # to ~.</p></a>

- Usage: `Put-Pause -Prompt <String> -Max <Milliseconds> -Default <single key default> -Echo <Boolean>`
- Usage: `Put-Pause -Prompt "[Make A Selection]: "`
- Usage: `$a = Put-Pause -Prompt "Do you seem interested? (Y/N): " -Default "N"`
- Color Usage: `Put-Pause -Prompt "~white~Clear the Screen?~ ~cyan~(~~white~Y~~cyan~/~~white~N~~cyan~)~~white~:~ "`
- Color Usage: `Put-Pause -Prompt "~white~Clear the Screen?~ ~cyan~(~~white~Y~~cyan~/~~white~N~~cyan~)~~white~:~ " -Max 0`

---

## Put-Vivaldi

<a><p align=center>I use Vivaldi browser sometimes because it, like Firefox, can have a custom user interface. My only beef was that they update it a lot and I would have to edit the files and copy over the custom css to add my changes every time they did. Well this script does the changes for me. You will only need to edit the top two folders in the script once. Add your custom css and your Vivaldi install base folder then just run it.</p><a>

- Usage: `Put-Vivaldi`

---

## Put-WinSize (Formally Set-WinSize)

<a><p align=center>My script paste-in that allows the console buffer and window to be resized. I tried 3 or 4 from others and they didn't work so I put this together and use it because it simply works. (Going to turn it into a Function soon) Update: Moved it closer to a function, Working well.</p></a>

- Usage: Paste into your script file as a function and call to it.`

---

## Put-Winposition

<a><p align=center>*I call this* This will set a named window to the desired position.</p></a>

- Usage: `Put-WinPosition -WinName String -WinX Int32 -WinY Int32`
  Optionally
- Usage: `Put-WinPosition -WinName String -WinX Int32 -WinY Int32 -Width Int32 -height Int32`

---

## Discord Stuff

<a><p align=center>Here is where I put any Discord related PowerShell script stuff.</p></a>

---

## Google

<a><p align=center>This is my console script example that sends your search to Google in the browser. You can add IMAGE, VIDEO or NEWS to the beginning of the line to go directly to those search pages.</p></a>

- Usage: `GOOGLE somethingtosearch` (Searches ALL normally.)
- Usage: `GOOGLE IMAGE somethingtosearch`
- Usage: `GOOGLE VIDEO somethingtosearch`
- Usage: `GOOGLE NEWS somethingtosearch`

---

## Remove-Empty

<a><p align=center>Remove-Empty is a simple little script that removes all empty Lines in a given text file. Feed it a file and all the blank lines are removed.

</p></a>

- Usage: `REMOVE-EMPTY FullPathToFileToProcess`

---

## Remove-WindowsApps

<a><p align=center>Remove-WindowsApps deletes Windows 10 apps from your system. Edit it to comment out ones you want. Also makes it so they shouldn't reinstall by removing AppX Provisioning. Edit the file and comment out those that you want to keep.</p></a>

- Usage: `REMOVE-WINDOWSAPPS`

---

## ASAY and NOTIFY

<a><p align=center>*I call this* This now uses BurntToast from the PowerShellGallery</p></a>

<a><center><https://www.powershellgallery.com/packages/BurntToast></center></a>

<a><p align=center>ASAY and NOTIFY are really the same file. They will send a notification to the standard windows notification center. I use it in my scripts to let me know when any event has happened I might want to see. The format is simple, without quote ASAY <any text you want to send to the notify> or WITH quotes if you use punctuation ASAY "This text, and that text" I also call these scripts from a LOT of my scripts to give notifications on windows 10. There is also a Linux and Dos version. The Linux files you need to edit and put your username over mine and edit atune to set the path to a valid sound file.</p></a>

- Usage: `NOTIFY or ASAY message to send to output`
- Usage: `NOTIFY or ASAY "message to send, include punctuation, to output"`
- Usage: Linux: Without Quotes do notify message to send to output or asay message to send to output

---

## Search

<a><p align=center>Search is a script that searches any text, as a filename parameter, in the path you give. From the whole drive down to just a folder it will list all matches found.</p></a>

- Usage: `SEARCH SearchPhrase BasePathToStartIn` (The star is added automatically)

---

## Edit-Config

<a><p align=center>This is my generic read and write to json files as config files.</p></a>

- Usage: `Edit-Config -Confile [string] -Count [string] -Read [string] -Write [string] -Section [string] -SValue [string] -BValue [bool] -Sub [int]`

---

## Edit-SiteHost

<a><p align=center>This adds and removes and views contents of Windows HOSTS file. Great for quickly blocking/unblocking internet addresses like shitty facebook.</p></a>

- Usage: `Edit-SiteHost Add address`
- Usage: `Edit-SiteHost Remove address`
- Usage: `Edit-SiteHost View`

---

## Env (environment)

<a><p align=center>This is my script to list a (one) environment variable from system ENV variable (no quotes) or from the variable drive ENV 'variable' (single quote) If you just do ENV it will list ALL variable</p></a>

- Usage: `ENV` (Does all variables)
- Usage: `ENV VaribleToSearch` (Without quotes)
- Usage: `ENV 'VaribleToSearch'` (With single quote)(Works on variable drive)

---

## Ver (Version)

<a><p align=center>I was missing the sort of version program I wanted so here it is. Just type VER.</p></a>

- Usage: `VER`

---

## Reboot

<a><p align=center>I wanted (needed) a reboot command in windows. So TaDA :) It is used REBOOT.PS1 STOP|SHUTDOWN|RESTART|REBOOT Just REBOOT alone is the same as REBOOT RESTART I also call this script from the BinMenu above. I removed rebooting on REBOOT with no parameter. REBOOT.ps1 REBOOT is now required.</p></a>

- Usage: `REBOOT STOP` or `REBOOT SHUTDOWN`
- Usage: `REBOOT` Gives you the option to type Y to reboot. Anything else no reboot.
- Usage: `REBOOT RESTART` or `REBOOT REBOOT`

---

## Run-CheckDisk

<a><p align=center>This script is my once a week CHKNTFS routine. It Sets drive C: and D: dirty then reboots to preform the disk check. I also call this script from the G QuickMenu of the BinMenu above. NOTE: Check out the script because it DOES NOT ask again it JUST RUNS. But it does what it should. It Will produce a message in Windows that you need to reboot to check the drives, which is the idea.</p></a>

- Usage: `RUN-CHECKDISK`

---

## Repair-windows

<a><p align=center>This is just a pretty console menu for SCF and DISM. I wrote it for my family and friends with plenty of help and explanations to get them through running it correctly. It includes the 4 normal possibilities. And we all have used it hundreds of times to make sure our Windows 10 was operating well.</p></a>

- Usage: `REPAIR-WINDOWS` (Runs Menu)
- Usage: `REPAIR-WINDOWS SCAN`
- Usage: `REPAIR-WINDOWS Check`
- Usage: `REPAIR-WINDOWS Image`
- Usage: `REPAIR-WINDOWS REPAIR`
- Usage: `REPAIR-WINDOWS RESET`

<img src="/img/Repair-Windows1.png" alt="Repair-Windows"/>
<img src="/img/Repair-Windows2.png" alt="Repair-Windows"/>
