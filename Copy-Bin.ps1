<#
.SYNOPSIS
        Copy-Bin.PS1
        Created By: Dana L. Meli-Wischman
        Created Date: November 02, 2025
.DESCRIPTION
        Copy my bin folder to the other two machines using Robocopy for optimal speed.
        Use -FixCorrupt to force overwriting corrupt or identical files.
        Use -SingleFolder to copy only a specific folder within Bin.
#>
param(
        [string]$myargs,
        [switch]$FixCorrupt,
        [string]$SingleFolder
)

$FileVersion = "0.0.19"
$FileDate = "10-06-2026"

# Helper wrapper fallback if custom 'Say' is not loaded in current scope
function Invoke-Say {
        param([string]$Message, $ForegroundColor)
        if (Get-Command -Name 'Say' -ErrorAction SilentlyContinue) {
                if ($ForegroundColor) { Say $Message -ForegroundColor $ForegroundColor }
                else { Say $Message }
        }
        else {
                if ($ForegroundColor) { Write-Host $Message -ForegroundColor $ForegroundColor }
                else { Write-Host $Message }
        }
}

try {
        if ($env:userdomain -ne "Titan") {
                Invoke-Say "You are not authorized to run this script." -ForegroundColor Red
                return
        }

        if ([string]::IsNullOrWhiteSpace($myargs)) {
                Invoke-Say ""
                Invoke-Say "Copy-Bin $FileVersion $FileDate"
                Invoke-Say ""
                Invoke-Say "Usage: Copy-Bin D: [-FixCorrupt] [-SingleFolder <FolderName>]"
                Invoke-Say "       Include -FixCorrupt to overwrite identical/corrupt files."
                Invoke-Say "       Include -SingleFolder to process only one specified directory."
                Invoke-Say ""
                return
        }

        # Directories to skip completely (system, runtime, or non-repo app data)
        $SkipList = @('.git', '.vs', '.vscode', 'ABDownloadManager', 'Audacity', 'Ditto', 'FanControl', 'MusicBee', 'Rainmeter', 'StrangeScript')

        # Repositories where *.json files should be excluded during copy
        $RepoList = @('BinMenu', 'Desktop-Switcher', 'git', 'Delay-Startup')

        # Clean target input and validate drive format
        $cleanTarget = $myargs.Trim().TrimEnd('\').TrimEnd(':')
        $targetDrive = "$cleanTarget`:"
        $sourcePath = "D:\Bin"

        # Validate Source Path
        if (-not (Test-Path -Path $sourcePath)) {
                Invoke-Say "Source directory $sourcePath does not exist." -ForegroundColor Red
                return
        }

        # Validate Target Path Accessibility
        $targetRoot = "$targetDrive\"
        if (-not (Test-Path -Path $targetRoot -ErrorAction SilentlyContinue)) {
                Invoke-Say "Target drive/path '$targetRoot' is not accessible or does not exist." -ForegroundColor Red
                return
        }

        # Determine target folder list
        if ($SingleFolder) {
                $singlePath = Join-Path -Path $sourcePath -ChildPath $SingleFolder
                if (-not (Test-Path -Path $singlePath)) {
                        Invoke-Say "Specified folder $SingleFolder does not exist in$sourcePath." -ForegroundColor Red
                        return
                }
                $folders = @(Get-Item -Path $singlePath)
        }
        else {
                $folders = Get-ChildItem -Path $sourcePath -Directory -ErrorAction Stop
        }

        if ($folders.Count -eq 0) {
                Invoke-Say "No folders found to synchronize." -ForegroundColor Yellow
                return
        }

        # Clean output flags: suppress percentage ticks, empty dir headers, and headers/summaries per folder
        $baseArgs = @('/E', '/MT:8', '/R:1', '/W:1', '/NP', '/NDL', '/NJH', '/NJS')

        if ($FixCorrupt) {
                Invoke-Say "Mode: Fix Corrupt Enabled (Overwriting identical/corrupt files)"
                $baseArgs += '/IS'
        }
        else {
                $baseArgs += '/XO'
        }

        # Native Directory Exclusion Switch (/XD)
        $xdArgs = @('/XD') + $SkipList

        # Filter executable list of folders to process for progress counting
        $activeFolders = @($folders | Where-Object { $SingleFolder -or ($SkipList -notcontains $_.Name) })
        $totalCount = $activeFolders.Count
        $currentIndex = 0

        foreach ($folder in $folders) {
                # Skip top-level evaluation if single folder wasn't requested
                if (-not $SingleFolder -and ($SkipList -contains $folder.Name)) {
                        Invoke-Say "Skipping directory: $($folder.Name)" -ForegroundColor Red
                        continue
                }

                $currentIndex++
                $destinationPath = Join-Path -Path $targetRoot -ChildPath "Bin\$($folder.Name)"

                # Build arguments for this specific folder
                $currentArgs = $baseArgs + $xdArgs

                $counterTag = "[$currentIndex/$totalCount]"
                if ($RepoList -contains $folder.Name) {
                        if ($FixCorrupt) {
                                Invoke-Say "$counterTag Syncing repo $($folder.Name) (including *.json due to -FixCorrupt)..." -ForegroundColor Cyan
                        }
                        else {
                                Invoke-Say "$counterTag Syncing repo $($folder.Name) (excluding *.json)..." -ForegroundColor Cyan
                                $currentArgs += @('/XF', '*.json')
                        }
                }
                else {
                        Invoke-Say "$counterTag Syncing $($folder.Name)..." -ForegroundColor Cyan
                }

                # Determine terminal width dynamically with safety fallback
                $rawWidth = try { $Host.UI.RawUI.WindowSize.Width } catch { 80 }$maxLen = if ($rawWidth -gt 20) { $rawWidth - 10 } else { 70 }

                # Execute Robocopy and rewrite the line continuously
                & robocopy $folder.FullName $destinationPath @currentArgs | ForEach-Object {
                        $line = $_.Trim()
                        if ($line) {
                                if ($line.Length -gt $maxLen) {
                                        $line = $line.Substring(0, $maxLen - 3) + "..."
                                }
                                $paddedLine = $line.PadRight($maxLen)
                                Write-Host "`r  -> $paddedLine" -NoNewline -ForegroundColor Gray
                        }
                }

                # Clear status line when folder sync finishes
                $blankSpace = " " * $maxLen
                Write-Host "`r  -> Done!$blankSpace" -ForegroundColor Green
        }

        Invoke-Say ""
        Invoke-Say "Copy operation complete." -ForegroundColor Green
}
catch {
        Invoke-Say "FATAL SCRIPT ERROR: $($_.Exception.Message)" -ForegroundColor Red
}
