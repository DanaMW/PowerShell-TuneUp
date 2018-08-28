﻿Function Get-HashTableEmptyValue
{
<#
.SYNOPSIS
    This function will get the empty or Null entry of a hashtable object
.DESCRIPTION
    This function will get the empty or Null entry of a hashtable object
.PARAMETER Hashtable
    Specifies the hashtable that will be showed
.EXAMPLE
    Get-HashTableEmptyValue -HashTable $SplattingVariable
.NOTES
    Francois-Xavier Cat
    @lazywinadm
    www.lazywinadmin.com
#>
    PARAM([System.Collections.Hashtable]$HashTable)

    $HashTable.GetEnumerator().name |
        ForEach-Object -Process {
            if($HashTable[$_] -eq "" -or $HashTable[$_] -eq $null)
            {
                Write-Output $_
            }
        }
}