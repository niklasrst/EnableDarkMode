<#
    .SYNOPSIS 
    Windows 10 enable DarkMode

    .DESCRIPTION
    Install:   PowerShell.exe -ExecutionPolicy Bypass -Command .\W10_EnableDarkMode.ps1 -install
    Uninstall:   PowerShell.exe -ExecutionPolicy Bypass -Command .\W10_EnableDarkMode.ps1 -uninstall

    .ENVIRONMENT
    PowerShell 5.0

    .AUTHOR
    Niklas Rast
#>

[CmdletBinding()]
param(
	[Parameter(Mandatory = $true, ParameterSetName = 'install')]
	[switch]$install,
	[Parameter(Mandatory = $true, ParameterSetName = 'uninstall')]
	[switch]$uninstall
)

$ErrorActionPreference = 'Stop'


if ($install)
{
	try
	{          
        New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Force
    }
	catch
	{
		$PSCmdlet.WriteError($_)
	}
}

if ($uninstall)
{
	try
	{
        Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Force
	}
	catch
	{
		$PSCmdlet.WriteError($_)
	}
}
