# The Premise Here
<p><a>The idea here is to modify the windows registry to allow me to run PS1 files with just a click. No problem. <a/></p>

I use the following run line myself

`"pwsh.exe" "-NoLogo" "-NoProfile" "-WindowStyle" "Hidden" "-Command" ""& {Start-Process pwsh.exe -ArgumentList '-NoLogo -ExecutionPolicy RemoteSigned -File \"%1\"' -Verb RunAs}"`

We put the above run line in the below registry location

`Computer\HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\0\Command`

Add pwsh.exe location to the path.
Edit the system variable PATHEXT. Correctly add .PS1
