# ==============================================================================
# SCRIPT: Sync IT Admins to Group based on Job Titles
# TENANT: Examsandbox.onmicrosoft.com (11d4f510-c7f2-43ad-b9f3-c08f6dda6e12)
# ==============================================================================

# 1. Configuration
$TenantId = "11d4f510-c7f2-43ad-b9f3-c08f6dda6e12"
$TargetGroupName = "IT Department-automation"
$AdminTitles = @("IT Manager", "System Administrator", "IT Director")

# 2. Authenticate
# This will prompt you to go to microsoft.com/devicelogin and enter a code
Connect-Entra -TenantId $TenantId -UseDeviceCode

try {
    # 3. Get the Target Group
    $Group = Get-EntraGroup -Filter "DisplayName eq '$TargetGroupName'"
    
    if (-not $Group) {
        Write-Output "Group '$TargetGroupName' not found. Please check the name."
        return
    }

    Write-Output "Processing Group: $($Group.DisplayName) ($($Group.Id))"

    # 4. Process Users by Title
    foreach ($Title in $AdminTitles) {
        # Find users with exact job title
        $Users = Get-EntraUser -Filter "JobTitle eq '$Title'"
        
        if ($null -eq $Users) {
            continue
        }

        foreach ($User in $Users) {
            Write-Output "Found User: $($User.DisplayName) - Role: $Title"

            # 5. Add as OWNER (Administrative Access)
            try {
                New-EntraGroupOwner -GroupId $Group.Id -RefObjectId $User.Id -ErrorAction Stop
                Write-Output "  Successfully added as Owner."
            } catch {
                # Triggers if they are already an owner
                Write-Output "  User is already an Owner or cannot be added."
            }

            # 6. Add as MEMBER (Standard Membership)
            try {
                New-EntraGroupMember -GroupId $Group.Id -RefObjectId $User.Id -ErrorAction Stop
                Write-Output "  Successfully added as Member."
            } catch {
                # Triggers if they are already a member
                Write-Output "  User is already a Member."
            }
        }
    }

    Write-Output "Sync Complete."

} catch {
    Write-Output "An error occurred: $($_.Exception.Message)"
}
