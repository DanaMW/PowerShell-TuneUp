$MyArgs = ($args)
$FileVersion = "Version: 0.0.4"
$drive = (Split-Path -parent $MyArgs)
$file = (Split-Path -leaf $MyArgs)
if (!($drive)) { bash -c "nano $File" }
else {
    $drive = $drive.tolower()
    $drive = $drive.replace(":\", "/")
    $drive = ("/mnt/" + $drive + "/" + $file)
    $file = $drive
    bash -c "nano $File"
}
