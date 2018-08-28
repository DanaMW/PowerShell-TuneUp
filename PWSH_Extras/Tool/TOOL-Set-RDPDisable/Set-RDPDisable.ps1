﻿function Set-RDPDisable
{
<#
	.SYNOPSIS
		The function Set-RDPDisable disable RDP remotely using the registry
	
	.DESCRIPTION
		The function Set-RDPDisable disable RDP remotely using the registry
	
	.PARAMETER ComputerName
		Specifies the ComputerName
	
	.EXAMPLE
		PS C:\> Set-RDPDisable
	
	.EXAMPLE
		PS C:\> Set-RDPDisable -ComputerName "DC01"
	
	.EXAMPLE
		PS C:\> Set-RDPDisable -ComputerName "DC01","DC02","DC03"
	
	.NOTES
		Francois-Xavier Cat
		www.lazywinadmin.com
		@lazywinadm
#>
	[CmdletBinding()]
	PARAM (
		[String[]]$ComputerName = $env:COMPUTERNAME
	)
	PROCESS
	{
		FOREACH ($Computer in $ComputerName)
		{
			TRY
			{
				IF (Test-Connection -ComputerName $Computer -Count 1 -Quiet)
				{
					$regKey = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $Computer)
					$regKey = $regKey.OpenSubKey("SYSTEM\\CurrentControlSet\\Control\\Terminal Server", $True)
					$regkey.SetValue("fDenyTSConnections", 1)
					$regKey.flush()
					$regKey.Close()
				} #IF Test-Connection
			} #Try
			CATCH
			{
				$Error[0].Exception.Message
			} #Catch
		} #FOREACH
	} #Process
}