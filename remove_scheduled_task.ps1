<#
.SYNOPSIS
Deletes a specific scheduled task by name from the Windows Task Scheduler.

.DESCRIPTION
Checks if a scheduled task with the given name exists. If it does, deletes it silently.

.EXECUTION
Run as Administrator.
#>

# Task name to delete
$taskName = "TaskName" # Replace with your task name   

try {
    schtasks.exe /Query /TN "$taskName" | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Deleting scheduled task: $taskName"
        schtasks.exe /Delete /TN "$taskName" /F | Out-Null
        Write-Host "Scheduled task '$taskName' deleted successfully."
    } else {
        Write-Host "Scheduled task '$taskName' does not exist or could not be found."
    }
}
catch {
    Write-Host "Error querying or deleting the scheduled task: $_"
}