# Function to remove the HTTP listener for WinRM
Function Disable-WinRMHTTP {
    Write-Output "Disabling HTTP-based WinRM on port 5985..."

    # Find and remove the HTTP listener
    $httpListener = Get-ChildItem WSMan:\localhost\Listener | Where-Object { $_.Keys -match "Transport=HTTP" }
    if ($httpListener) {
        Remove-Item -Path $httpListener.PSPath -Recurse -ErrorAction SilentlyContinue
        Write-Output "HTTP-based WinRM listener on port 5985 removed successfully."
    } else {
        Write-Output "No HTTP-based WinRM listener found."
    }
}

# Function to block port 5985 in the Windows Firewall
Function Block-Port5985 {
    Write-Output "Blocking port 5985 in the Windows Firewall..."

    # Add a firewall rule to block inbound traffic on port 5985
    New-NetFirewallRule -DisplayName "Block Port 5985" -Direction Inbound -Protocol TCP -LocalPort 5985 `
        -Action Block -ErrorAction SilentlyContinue

    Write-Output "Port 5985 blocked successfully."
}

Write-Output "Starting the process to disable HTTP-based WinRM on port 5985..."
Disable-WinRMHTTP
Block-Port5985
Write-Output "HTTP-based WinRM on port 5985 has been successfully disabled."
