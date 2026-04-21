# Windows Defender ASR Hardening

> PowerShell toolkit for strengthening Windows endpoints through Microsoft Defender Attack Surface Reduction (ASR) rules.

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![Windows](https://img.shields.io/badge/Platform-Windows-0078D6?logo=windows)
![Security](https://img.shields.io/badge/Focus-Endpoint%20Security-success)
![Status](https://img.shields.io/badge/Status-Active-brightgreen)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

---

# Executive Summary

Modern threats often rely on built-in tools, scripting engines, macros, and legitimate processes to bypass traditional antivirus detection.

This project uses native Microsoft Defender ASR controls to reduce exposure to common attack paths, helping block malicious behaviors before execution.

It is designed as a practical defensive project focused on:

- Endpoint hardening  
- Defensive automation  
- Windows security operations  
- Blue Team fundamentals  
- PowerShell-based administration  

---

# What Is ASR?

Attack Surface Reduction (ASR) is a Microsoft Defender feature that blocks behaviors commonly used by malware, ransomware, and post-exploitation frameworks.

Instead of relying only on file signatures, ASR focuses on **techniques and behaviors**, such as:

- Office spawning suspicious child processes  
- Scripts launching executables  
- Credential dumping attempts  
- Abuse of administrative tools  
- Persistence through WMI  
- Ransomware-like activity  

---

# Project Goals

- Apply a secure ASR baseline using PowerShell  
- Validate Microsoft Defender readiness before deployment  
- Provide rollback capability for testing and compatibility scenarios  
- Demonstrate practical Windows security engineering  
- Serve as a portfolio project for cybersecurity and IT roles  

---

# Included Scripts

## `test-defender-status.ps1`

Validates whether Microsoft Defender is available and operational.

Checks:

- Defender service state  
- Antivirus status  
- Real-time protection  
- Engine availability  
- Core security readiness  

### Recommended First Step

```powershell
.\test-defender-status.ps1
```

---

## `enable-asr.ps1`

Enables the ASR rules included in this project.

Use when you want to enforce the configured protections.

```powershell
.\enable-asr.ps1
```

---

## `rollback-asr.ps1`

Disables the ASR rules configured by this project.

Use for rollback, troubleshooting, or compatibility testing.

```powershell
.\rollback-asr.ps1
```

---

# Security Coverage

The current baseline includes protections against:

## Credential Access

- Credential theft from LSASS

## Malicious Office Behavior

- Office child process creation
- Office process injection
- Macro abuse
- Office-generated executable content

## Script Abuse

- Obfuscated scripts
- JavaScript / VBScript launching executables

## Initial Access & Execution

- Executables from email/webmail
- Untrusted USB processes
- Vulnerable signed drivers

## Persistence & Lateral Movement

- WMI persistence techniques
- PSExec / WMI remote process creation
- Copied or impersonated system tools

## Impact

- Advanced ransomware protection

---

# Requirements

- Windows 10 / Windows 11
- Microsoft Defender available and enabled
- PowerShell 5.1+
- Administrator privileges

---

# Quick Start

## 1. Validate Defender

```powershell
.\test-defender-status.ps1
```

## 2. Apply Protection Baseline

```powershell
.\enable-asr.ps1
```

## 3. Roll Back If Needed

```powershell
.\rollback-asr.ps1
```

---

# PowerShell Execution Policy

If script execution is blocked:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Run PowerShell as Administrator.

---

# Troubleshooting

## Error `0x800106ba`

Usually indicates that Microsoft Defender Antivirus is disabled, unavailable, or replaced by another security solution.

![Error Screenshot](https://github.com/user-attachments/assets/fea62c3d-c947-41a7-921d-eb0f9cadebbd)

## Verify Status

```powershell
Get-Service WinDefend
Get-MpComputerStatus
```

## Try Starting Defender

```powershell
Start-Service WinDefend
```

## Also Check

- Another antivirus installed
- Group Policy disabling Defender
- Enterprise management tools overriding local settings
- Security baseline conflicts

---

# Operational Guidance

Before broad deployment:

- Test in non-production environments
- Validate business application compatibility
- Review macro and script dependencies
- Assess impact on legacy workflows
- Keep rollback available

---

# Why This Project Matters

This repository demonstrates practical defensive security using built-in Windows controls rather than third-party tools.

It highlights skills relevant to:

- SOC / Blue Team roles
- Endpoint administration
- Windows hardening
- Security automation
- PowerShell scripting
- Defensive operations

---

# Roadmap

Planned improvements:

- Interactive menu version
- Audit mode deployment
- HTML reports
- CSV exports
- Restore point creation
- Enhanced logging
- Policy conflict detection
- Enterprise profile templates

---

# Repository Structure

```text
.
├── enable-asr.ps1
├── rollback-asr.ps1
├── test-defender-status.ps1
└── README.md
```

---

# License

MIT License

---

# Author

[@LuisHenri1](https://github.com/LuisHenri1)
