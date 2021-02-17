$FileVersion = "0.0.4"
Import-Module AppX
Import-Module Dism
#
#Use "#" to comment out apps you don't want to remove.
#You must comment out both commands for each app if in both.
#The Remove-AppXpackage and Remove-AppXProvisionedPackage must both be commented out.
#
#Remove AppX Packages for unnecessary Windows 10 AppX Apps
Get-AppxPackage *Microsoft.BingNews* | Remove-AppxPackage
Get-AppxPackage *Microsoft.DesktopAppInstaller* | Remove-AppxPackage
Get-AppxPackage *Microsoft.GetHelp* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Getstarted* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.Messaging* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Microsoft3DViewer* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MicrosoftOfficeHub* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *Microsoft.NetworkSpeedTest* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Office.OneNote* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Office.Sway* | Remove-AppxPackage
Get-AppxPackage *Microsoft.OneConnect* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.People* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Print3D* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.RemoteDesktop* | Remove-AppxPackage
Get-AppxPackage *Microsoft.SkypeApp* | Remove-AppxPackage
Get-AppxPackage *Microsoft.StorePurchaseApp* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.WindowsAlarms* | Remove-AppxPackage
Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage
#Get-AppxPackage *microsoft.windowscommunicationsapps* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.WindowsMaps* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.WindowsSoundRecorder* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Xbox.TCUI* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxApp* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxGameOverlay* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage
Get-AppxPackage *Microsoft.ZuneMusic* | Remove-AppxPackage
Get-AppxPackage *Microsoft.ZuneVideo* | Remove-AppxPackage
#
#Remove AppX Packages for Sponsored Windows 10 AppX Apps
Get-AppxPackage *EclipseManager* | Remove-AppxPackage
Get-AppxPackage *ActiproSoftwareLLC* | Remove-AppxPackage
Get-AppxPackage *AdobeSystemsIncorporated.AdobePhotoshopExpress* | Remove-AppxPackage
Get-AppxPackage *Duolingo-LearnLanguagesforFree* | Remove-AppxPackage
Get-AppxPackage *PandoraMediaInc* | Remove-AppxPackage
Get-AppxPackage *CandyCrush* | Remove-AppxPackage
Get-AppxPackage *Wunderlist* | Remove-AppxPackage
Get-AppxPackage *Flipboard* | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
#Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *Spotify* | Remove-AppxPackage
#
#Optional: Typically not removed but you can if you need to for some reason
Get-AppxPackage *Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe* | Remove-AppxPackage
Get-AppxPackage *Microsoft.BingWeather* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage
Get-AppxPackage *Microsoft.MicrosoftStickyNotes* | Remove-AppxPackage
Get-AppxPackage *Microsoft.Windows.Photos* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.WindowsCalculator* | Remove-AppxPackage
#Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage
#
#Use "#" to comment out apps you don't want to remove.
#You must comment out both commands for each app if in both.
#The Remove-AppXpackage and Remove-AppXProvisionedPackage must both be commented out.
#
#Remove AppX Provisioning for unnecessary Windows 10 AppX apps
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.DesktopAppInstaller" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.GetHelp" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Getstarted" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Messaging" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Microsoft3DViewer" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.MicrosoftOfficeHub" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Office.OneNote" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.OneConnect" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.People" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Print3D" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.SkypeApp" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.StorePurchaseApp" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsAlarms" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsCamera" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "microsoft.windowscommunicationsapps" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsFeedbackHub" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsMaps" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsSoundRecorder" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Xbox.TCUI" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.XboxApp" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.XboxGameOverlay" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.XboxIdentityProvider" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.XboxSpeechToTextOverlay" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.ZuneMusic" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.ZuneVideo" | Remove-AppxProvisionedPackage -Online
#
#Sponsored Windows 10 AppX apps don't have corresponding provisioning packages
#Optional: Typically not removed but you can if you need to for some reason
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.BingWeather" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.MSPaint" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.MicrosoftStickyNotes" | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.Windows.Photos" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsCalculator" | Remove-AppxProvisionedPackage -Online
#Get-AppxProvisionedPackage -Online | where Displayname -EQ "Microsoft.WindowsStore" | Remove-AppxProvisionedPackage -Online
