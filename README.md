# Microsoft Entra ID: RBAC Implementation Lab

> A comprehensive guide to implementing Role-Based Access Control (RBAC) in a HomeLab environment using Microsoft Entra ID and PowerShell automation.

---

## 🎬 Quick Start

**[Watch the Full Lab Walkthrough on Loom](https://www.loom.com/share/002dd24017554920b5af8cf59a77d9fd)** - Complete step-by-step video demonstration

---

## 📋 Table of Contents

- [Project Overview](#project-overview)
- [Objectives](#objectives)
- [Tools & Technologies](#tools--technologies)
- [Workflow](#workflow)
  - [Phase 1: Environment Preparation & Connection](#phase-1-environment-preparation--connection)
  - [Phase 2: Automated Group Creation](#phase-2-automated-group-creation)
  - [Phase 3: RBAC Implementation & Membership](#phase-3-rbac-implementation--membership)
  - [Phase 4: UI Validation & PIM Verification](#phase-4-ui-validation--pim-verification)
- [Security Considerations](#security-considerations)
- [Key Takeaways](#key-takeaways)

---

## Project Overview

This project demonstrates a **complete RBAC implementation workflow** within a HomeLab environment using Microsoft Entra ID. It illustrates how organizations can:

- **Simulate modern enterprise environments** with automated user and group management
- **Implement Role-Based Access Control** through delegation and privileged access management
- **Enforce least-privilege principles** by restricting administrative rights to specific roles
- **Automate security controls** through PowerShell scripting and best practices

The lab uses **PowerShell scripts, screenshots, and step-by-step documentation** to guide administrators through implementing enterprise-grade security controls at scale.

---

## Objectives

This lab covers key objectives for RBAC implementation:

1. ✅ Establish secure tenant connection to Microsoft Entra ID
2. ✅ Automate group creation with consistent naming conventions
3. ✅ Implement RBAC by assigning users to administrative groups
4. ✅ Delegate group ownership to enforce scalable administration
5. ✅ Validate RBAC configurations through UI and PowerShell verification

---

## Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Microsoft Entra ID** | Cloud-based identity and access management service |
| **Azure Portal** | Web-based interface for Azure and Entra ID management |
| **PowerShell / Azure AD Module** | Automation and scripting for group/user management |
| **Connect-AzureAD** | PowerShell cmdlet for tenant authentication |
| **Get-AzureADGroup** | Directory validation and group verification |

---

## Workflow

### Phase 1: Environment Preparation & Connection

Before running any administrative scripts, it's essential to authenticate to the correct Azure tenant to prevent misconfigurations and ensure security.

#### Step 1: Establishing Tenant Connection

**Objective**: Securely connect to the HomeLab tenant using PowerShell authentication.

**Process**: Azure AD PowerShell Authentication

1. Open PowerShell with administrator privileges
2. Execute the connection command:
   ```powershell
   Connect-AzureAD
   ```
3. When prompted, authenticate with your Microsoft Entra ID credentials
4. Verify successful connection by checking the output

**Screenshot**: Configuration connection
![Configuration connection](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/Configuration%20connection.png?raw=true)

**Expected Result**: ✅ Successfully authenticated to the Azure AD tenant.

---

### Phase 2: Automated Group Creation

Automation is leveraged to enforce consistent naming conventions and security parameters when establishing the administrative hierarchy.

#### Step 2: Pre-Configuration Scripting

**Objective**: Define variables and set up the environment for group creation.

**Process**: Variables and Environment Setup

1. Define the parent IT group ID that will contain the new Junior Admins group
2. Set configuration parameters such as group display name: "Junior Admins"
3. Establish any required security baselines

**Screenshot**: Setup For AD group pre
![Setup For AD group pre](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/Setup%20For%20AD%20group%20pre.png?raw=true)

**Expected Result**: ✅ All variables are defined and the environment is ready for automated group creation.

---

#### Step 3: Executing the Group Creation Script

**Objective**: Create the "Junior Admins" security group and verify its creation.

**Process**: Resource Provisioning

1. Execute the group creation PowerShell script:
   ```powershell
   $groupName = "Junior Admins"
   $groupDescription = "Administrative group for junior-level admins"
   
   New-AzureADGroup -DisplayName $groupName `
                    -MailNickname $groupName `
                    -MailEnabled $false `
                    -SecurityEnabled $true `
                    -Description $groupDescription
   ```

2. Review the terminal output for DisplayName, ObjectId, and MailEnabled status

**Screenshot**: Display of AzureADGroup for junior admin has been created
![Display of AzureADGroup for junior admin has been created](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/Display%20of%20AzureADGroup%20for%20junior%20admin%20has%20been%20created.png?raw=true)

**Expected Result**: ✅ Junior Admins group successfully created.

---

#### Step 4: Verification of Directory Object

**Objective**: Verify the new group's presence in the tenant and retrieve its unique GUID.

**Process**: Directory Validation

1. Run the verification command:
   ```powershell
   Get-AzureADGroup -SearchString "Junior Admins"
   ```

2. Verify the output includes ObjectId, DisplayName, and SecurityEnabled status
3. Store the ObjectId for use in the next phase

**Screenshot**: GetAzureADgroup
![GetAzureADgroup](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/GetAzureADgroup.png?raw=true)

**Expected Result**: ✅ Group successfully verified in the directory.

---

### Phase 3: RBAC Implementation & Membership

This phase focuses on defining who gets access and how those privileges are delegated.

#### Step 5: Adding Users to the Junior Admin Tier

**Objective**: Add IT department users to the Junior Admins group.

**Process**: Identity Assignment

1. Identify users to be added to the Junior Admins group
2. Execute the user addition script:
   ```powershell
   $group = Get-AzureADGroup -SearchString "Junior Admins"
   $user = Get-AzureADUser -Filter "UserPrincipalName eq 'rosa.diaz@Examsandbox.onmicrosoft.com'"
   
   Add-AzADGroupMember -MemberUserPrincipalName $user.UserPrincipalName `
                       -TargetGroupDisplayName "Junior Admins"
   ```

**Screenshot**: Adding user to junior admins
![Adding user to junior admins](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/Adding%20user%20to%20junior%20admins.png?raw=true)

**Expected Result**: ✅ Selected users successfully added to the Junior Admins group.

---

#### Step 6: Assigning Group Ownership and Admin Rights

**Objective**: Assign group ownership and administrative roles to empower Junior Admin leadership.

**Process**: Administrative Delegation

1. Identify the user who will serve as the group owner
2. Assign ownership using PowerShell:
   ```powershell
   $group = Get-AzureADGroup -SearchString "Junior Admins"
   $user = Get-AzureADUser -Filter "UserPrincipalName eq 'rosa.diaz@Examsandbox.onmicrosoft.com'"
   
   Add-AzureADGroupOwner -ObjectId $group.ObjectId -RefObjectId $user.ObjectId
   ```

3. Verify ownership assignment

**Screenshot**: group owner and admin script
![group owner and admin script](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/group%20owner%20and%20admin%20script.png?raw=true)

**Expected Result**: ✅ Group ownership delegated to the Junior Admin Lead.

---

### Phase 4: UI Validation & PIM Verification

Post-script validations in the Azure Portal ensure that automation aligns with expected configuration.

#### Step 7: Verifying Administrative Roles (UI)

**Objective**: Confirm that RBAC assignments are visible and active in the Azure Portal.

**Process**: Role Assignment Verification

1. Navigate to Microsoft Entra ID → Groups → All groups
2. Search for and select the "Junior Admins" group
3. Review group properties and assigned roles
4. Verify no excessive privileges are granted

**Screenshots**: 
- Group admin UI side
![group admin UI side](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/group%20%20admin%20UI%20side.png?raw=true)

- Group admin script
![group admin script](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/group%20%20admin%20script.png?raw=true)

**Expected Result**: ✅ All RBAC assignments visible and correctly aligned.

---

#### Step 8: Final Membership Review

**Objective**: Audit and verify all user additions and owner assignments are accurate.

**Process**: Membership Audit

1. Navigate to Microsoft Entra ID → Groups → All groups
2. Select the "Junior Admins" group
3. Review the Members and Owners tabs
4. Cross-reference with PowerShell verification

**Screenshot**: group member UI side
![group member UI side](https://raw.githubusercontent.com/buchanan97/ENTRA-ID-RBAC-LAb/main/group%20%20memeber%20UI%20side.png?raw=true)

**Expected Result**: ✅ RBAC implementation complete and verified.

---

## Security Considerations

### Separation of Duties
- Junior Admins are empowered to manage user accounts and group memberships within their scope
- Junior Admins are restricted from tenant-wide configurations and privileged operations
- Administrative rights are scoped to specific user and group management tasks

### Principle of Least Privilege
- Users receive only the minimum permissions necessary to perform their job functions
- Regular audits ensure privilege creep is prevented
- Clear audit trails document all administrative actions

### Automation Benefits
- **Consistency**: Scripting ensures repeatable, error-free deployment every time
- **Auditability**: PowerShell execution logs provide audit trails for compliance
- **Scalability**: Automation easily extends to multiple users and groups

---

## Key Takeaways

| Concept | Benefit |
|---------|---------|
| **Tenant Authentication** | Ensures all actions target the correct directory |
| **Automated Group Creation** | Enforces naming conventions and consistent security |
| **User Membership Assignment** | Segments administrative duties by role |
| **Ownership Delegation** | Enables scalable administration |
| **UI Validation** | Confirms automation aligns with policies |
| **RBAC Implementation** | Implements least-privilege access |
| **Scripting Automation** | Enables repeatable, auditable operations |

---

## Summary

This HomeLab RBAC Onboarding runbook provides a foundational template for scaling and securing administrative teams in any Azure-based environment. By following these structured phases, you can ensure that administrative roles are precisely assigned, security controls are consistently enforced, and audit trails document all changes for compliance.

---

**Last Updated**: February 2026

**Repository**: [buchanan97/ENTRA-ID-RBAC-LAb](https://github.com/buchanan97/ENTRA-ID-RBAC-LAb)

**Video Tutorial**: [Loom Lab Walkthrough](https://www.loom.com/share/002dd24017554920b5af8cf59a77d9fd)