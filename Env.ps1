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
$FileVersion = "0.1.3"
if (!($myargs)) {
    Say "Environment Lister $FileVersion"
    Say ""
    Say "Listing ALL your environment Variables."
    Say "All sorted and formatted for your pleasure."
    Say "-=-=-===-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    Get-ChildItem Env: | Sort-Object Name | Format-Table -Wrap -AutoSize
    Say ""
    Say "These are your variables on the Variable: Drive"
    Say "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    Get-Childitem variable: | Sort-Object Name | Format-Table -Wrap -AutoSize
    Say "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    Say "Use ENV VAR for normal variables"
    Say "Use ENV `'`$VAR`' for Env. Drive variables"
    Say "OK to use Wildcards ENV *VAR* on variables"
    Say "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    return
}
#$TheArgs = "$myargs $args"
if ($myargs.substring(0, 1) -eq '$') {
    $tmp = $myargs.substring(1)
    Try { Get-ChildItem Variable:"$tmp" -ErrorAction Stop | Format-Table -Wrap -AutoSize }
    catch {
        Say -ForeGroundColor Red "Did not match Environment Drive Variable" $tmp.ToUpper()
        Say ""
    }
    return
}
else {
    $arg1 = $myargs.substring(0, 1).toupper() + $myargs.substring(1).tolower()
    $arg2 = $myargs.toupper()
    if ($arg2 -eq "PATH") {
        Say
        Say "Displaying the PATH variable for you"
        Say "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
        $Env:PATH -Split ";" | Sort-Object
        return
    }
    Say
    Say "Displaying the Environment Variable" $arg1.ToUpper() "if it exists"
    try { Get-ChildItem Env:"$arg2" -ErrorAction Stop | Format-Table -Wrap -AutoSize }
    catch {
        Say -ForeGroundColor Red "Did not match Environment Variable" $arg1.ToUpper()
        Say ""
    }
    return
}
