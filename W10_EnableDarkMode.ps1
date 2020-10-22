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

$ErrorActionPreference="SilentlyContinue"
$logFile = ('{0}\{1}.log' -f $env:Temp, [System.IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name))


if ($install)
{
    Start-Transcript -path $logFile
        try
        {         
            New-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0 -Force
            
            $null = New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" -Name "W10_EnableDarkMode" –Force
            $null = New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\W10_EnableDarkMode" -Name "Version" -PropertyType "String" -Value "1.0" -Force
            $null = New-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\W10_EnableDarkMode" -Name "Revision" -PropertyType "String" -Value "001" -Force
        } 
        catch
        {
            $PSCmdlet.WriteError($_)
        }
    Stop-Transcript
}

if ($uninstall)
{
    Start-Transcript -path $logFile
        try
        {
            Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Force
            
            Remove-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\W10_EnableDarkMode" -Force -Recurse
        }
        catch
        {
            $PSCmdlet.WriteError($_)
        }
    Stop-Transcript
}
