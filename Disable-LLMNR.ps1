[CmdletBinding()]
param ()

function Set-RegKey {
    param (
        $Path,
        $Name,
        $Value,
        [ValidateSet("DWord", "QWord", "String", "ExpandedString", "Binary", "MultiString", "Unknown")]
        $PropertyType = "DWord"
    )
    try {
        if (-not (Test-Path -Path $Path -ErrorAction SilentlyContinue)) {
            New-Item -Path $Path -Force | Out-Null
        }
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $PropertyType -Force | Out-Null
        Write-Host "LLMNR has been disabled successfully."
    }
    catch {
        Write-Error "Failed to disable LLMNR. Error: $_"
    }
}

Set-RegKey -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" -Name EnableMultiCast -Value 0 -PropertyType DWord
