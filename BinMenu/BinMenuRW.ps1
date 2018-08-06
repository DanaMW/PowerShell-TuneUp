#FileVersion = 0.1.7
Clear-Host
#Setup Base Folder.
$Base = "C:\bin\"
#Setup Base files
$Filetxt = "$Base" + "BinMenuRW.txt"
$Filecsv = "$Base" + "BinMenuRW.csv"
$FileExc = "$Base" + "BinMenu.csv"
$FileMen = "$Base" + "BinMenu.ini"

#Cleanup files for redoing.
#Remember not to remove the Exclude file. (FileExc) You create that manually.
$Filetest = Test-Path -path $Filetxt
if ($Filetest -eq $true) { Remove-Item –path $Filetxt }
$Filetest = Test-Path -path $filecsv
if ($Filetest -eq $true) { Remove-Item –path $Filecsv }
$Filetest = Test-Path -path $fileMen
if ($Filetest -eq $true) { Remove-Item –path $FileMen }

#Reads in all valid (runable exe ) entries from your base folder.
Write-host "Reading in directory $Base..."
Get-ChildItem -Path "$Base" -Recurse -Include *.exe | Select-Object `
@{ n = 'Foldername'; e = { ($_.PSPath -split '[\\]')[3] } } ,
Name,
FullName ` | Export-Csv -path $filetxt -NoTypeInformation

#Sorting the entries and eporting to file. This is the one you use to create the exclude file.
Write-host "Exporting folder info..."
Import-Csv -Path $filetxt | Sort-Object -Property "Foldername" | Export-Csv -NoTypeInformation $filecsv

#run the first time with this break uncommented to allow you to create the EXCLUDE file.
#You create the exclude file by removing the files YOU WANT from <filecvs> and saving it as <fileExc>
#Leave the entries you DONT WANT in <fileExc>
#break

#Reading in the entries you removed
Write-Host "Time to read in valid menu entries..."
$writer = [System.IO.file]::CreateText($FileMen)
$i = 1
try {
    $Exlist = Import-Csv $FileExc | Select-Object name
    Import-Csv $Filecsv | Foreach-Object {


        # These are excludes to allow it to not error. (Add them Below)
        if ($_.name -match "notepad\+\+") { return }
        if ($_.name -eq "[.exe") { return }
        #end excludes

        if ($Exlist -match $_.name) {
            return
        }
        $NameFix = $_.name
        $NameFix = $NameFix.tolower()
        $NameFix = $NameFix.substring(0, 1).toupper() + $NameFix.substring(1)
        $NameFix = $NameFix.replace(".exe", "")
        Write-Host "Adding to Menu: " $NameFix
        $Writer.WriteLine("[" + $i + "A]=" + $NameFix)
        #$Writer.WriteLine("[" + $i + "A]=" + $_.name.replace(".exe", ""))
        $Writer.WriteLine("[" + $i + "B]=" + $_.fullname)
        #export-Csv -Path $FileMen -Append -Delimiter "," -InputObject $_
        $i++
    }
}
finally { $writer.close() }
Write-Host "Done Writing EXE files to the Menu ini."
Write-Host ""

#All files written so now we can clean up.
#Remember not to remove the Exclude file. (FileExc) You create that manually.
#Here remember not to remove the ini file either. (Fileini) The BinMenu read it.
$Filetest = Test-Path -path $filetxt
if ($Filetest -eq $true) { Remove-Item –path $Filetxt }
$Filetest = Test-Path -path $filecsv
if ($Filetest -eq $true) { Remove-Item –path $Filecsv }

#Lastly We read in any PowerShell scripts in the folder.
#ScripTRead Needs to be done!!

#Run the BinMenu.
return
