<#
.SYNOPSIS
        Env
        Created By: Dana Meli
        Created Date: August, 2018
        Last Modified Date: January 15, 2019
.DESCRIPTION
        This returns the value of your environment variables.
.EXAMPLE
        Env [<variable>]  (without any quotes for normal variables)
        Env [<'$variable'>] (with single quotes for variables from your "Variable:" drive)
.NOTES
        Still under development.
#>
param([string]$myargs)
$FileVersion = "Version: 0.1.1"
if ($myargs -eq "") {
    Say "Environment Lister $FileVersion"
    Say ""
    Say "Listing ALL your environment Variables."
    Say "All sorted and formatted for your pleasure."
    Get-ChildItem Env: | Sort-Object Name | Format-Table -Wrap -AutoSize
    Say ""
    Say ""
    Say "These are your variables on the Variable: Drive"
    Get-Childitem variable: | Sort-Object Name | Format-Table -Wrap -AutoSize
    return
}
#$TheArgs = "$myargs $args"
if ($myargs.substring(0, 1) -eq '$') {
    $tmp = $myargs.substring(1)
    Get-ChildItem Variable:"$tmp" | Format-Table -Wrap -AutoSize
}
else {
    $arg1 = $myargs.substring(0, 1).toupper() + $myargs.substring(1).tolower()
    $arg2 = $myargs.toupper()

    if ($arg2 -eq "PATH") {
        Say
        Say "Displaying the PATH variable for you"
        Say "================================="
        $Env:PATH -Split ";" | Sort-Object
        return
    }
    Say
    Say "Displaying the Enviroment Variable" $arg1.ToUpper() "if it exists"
    Get-ChildItem Env:"$arg2" | Format-Table -Wrap -AutoSize

    <#
    Say "Machine environment variables"
    [Environment]::GetEnvironmentVariables("Machine")
    Say "User environment variables"
    [Environment]::GetEnvironmentVariables("User")
    Say "Process environment variables"
    [Environment]::GetEnvironmentVariables("Process")
    #>
}
