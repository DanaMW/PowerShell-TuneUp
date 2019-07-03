Lets Begin
==========

Search
======
Open the regedit.exe and do a find for `PowerShellScript.1`
Once there you should be at:
`Computer\HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\`
Look For The Key
`Computer\HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\0\Command`

My Original Registry Entry for the key was:
Key: `Computer\HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\0\Command`
Entry: `"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "-Command" "if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; & '%1'"`

Make Some Changes
=================
This is the EXACT line I entered into `Computer\HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\0\Command` (EXACTLY AS SHOWN)

`"pwsh.exe" "-NoLogo" "-NoProfile" "-WindowStyle" "Hidden" "-Command" ""& {Start-Process pwsh.exe -ArgumentList '-NoLogo -ExecutionPolicy RemoteSigned -File \"%1\"' -Verb RunAs}"`

In Environment Variables (Right click This PC or My PC and select Properties. Then Advanced system Settings. Then Environment Variables)
look for PATHEXT it looks like this: *.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC*
Change it to include ps1 files like this: `.COM;.EXE;.BAT;.PS1;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC`

Now when I click a *.ps1 it elevates and runs.

I changed the following key to 0 (zero):
`Computer\HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell`

I also deleted the following key: (as i had used the "Open With" option in my session)
And deleting the key cleared anything I associated with it.

`Computer\HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ps1\UserChoice`
=============================================================================
