$MyArgs = ($args)
$FileVersion = "0.0.6"
if (($MyArgs)) {
    $MyArgs = $MyArgs.Replace(".\", "");
    $drive = (Split-Path -parent $MyArgs)
    $file = (Split-Path -leaf $MyArgs)
}
if (!($drive)) {
    if (($file)) { bash -c "nano $File" }
    else { bash -c "nano" }
}
if (($drive)) {
    $drive = $drive.tolower()
    $drive = $drive.replace(":\", "/")
    $drive = ("/mnt/" + $drive + "/" + $file)
    $file = $drive
    bash -c "nano $File"
}
