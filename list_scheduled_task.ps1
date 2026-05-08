<#
.SYNOPSIS
Lists only scheduled tasks created by users or third-party applications.

.DESCRIPTION
This script lists all scheduled tasks except those under the \Microsoft\ path (default system tasks).
It displays the task name, task path, and associated actions. TaskPath is cleaned to avoid spacing/display issues.

.EXECUTION
Run from PowerShell without administrator privileges.
Example:
    PS C:\> .\List-CustomScheduledTasks.ps1
#>

# Load all non-Microsoft tasks
$tasks = Get-ScheduledTask | Where-Object { $_.TaskPath -notlike '\Microsoft\*' }

# Check if any tasks were found
if ($tasks.Count -eq 0) {
    Write-Host "[*] No user or third-party scheduled tasks found." -ForegroundColor Yellow
    exit 0
}

Write-Host "[+] Custom (non-Microsoft) scheduled tasks found:`n" -ForegroundColor Green

foreach ($task in $tasks) {
    # Clean task name and path to avoid formatting issues
    $taskName = $task.TaskName.Trim()
    $taskPath = ($task.TaskPath -replace '^\s+', '').Trim()

    Write-Host ("Task Name : {0}" -f $taskName)
    Write-Host ("Task Path : {0}" -f $taskPath)

    # Print each action (can be multiple)
    foreach ($action in $task.Actions) {
        $actionText = "$($action.Execute) $($action.Arguments)".Trim()
        Write-Host ("Action    : {0}" -f $actionText)
    }

    Write-Host "---------------------------------------------"
}