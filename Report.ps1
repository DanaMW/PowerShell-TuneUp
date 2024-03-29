﻿<#
.SYNOPSIS
        Report
        Created By: Dana Meli-Wischman
        Created Date: February, 2018
        Last Modified Date: February 08, 2022

.DESCRIPTION
        Returns a list of files from your chosen folder
        to a Text file of your choice.

.EXAMPLE
        report -In "D:\Software\_Games" -Out "D:\Downloads\OutFile.txt"

.NOTES
        Still under development.

#>
param([string]$In, [string]$Out)
$FileVersion = "0.0.3"
Say "Report $FileVersion"
if (!($In)) {
        Say "What directory do you want to read into the text file?"
        Read-Host -Prompt "[Full Path to read in.]"
}
if (!($In)) { return }
Say "IN set as $In"
if (!($Out)) {
        Say "What File to write the output to?"
        Read-Host -Prompt "[Full Path/filename to write to.]"
}
if (!($Out)) { return }
Say "OUT set as $Out"
$Filetest = Test-Path -Path $Out
if ($Filetest -eq $true) { Remove-Item –Path $Out }
Say "Writing your output file for you."
Get-ChildItem -Path $In -Name -Recurse | Sort-Object | Out-File $Out
