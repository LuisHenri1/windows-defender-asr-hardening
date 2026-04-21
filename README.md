<div align="center">

# Windows Defender ASR Hardening

### Microsoft Defender Attack Surface Reduction • Status Validation • Safe Rollback

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)](https://github.com/PowerShell/PowerShell)
[![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D6?logo=windows)](https://www.microsoft.com/windows)
[![Microsoft Defender](https://img.shields.io/badge/Microsoft%20Defender-ASR%20Hardening-5C2D91)](https://learn.microsoft.com/microsoft-365/security/defender-endpoint/attack-surface-reduction-rules-reference)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**A practical PowerShell toolkit for hardening Windows endpoints with Microsoft Defender ASR rules, validating Defender availability, and preserving a simple rollback path.**

*Built for Windows administrators, Blue Team practitioners, and cybersecurity learners who want a clean, focused, and operationally useful ASR baseline.*

[Overview](#-overview) • [Scripts](#-included-scripts) • [Coverage](#-security-coverage) • [Quick Start](#-quick-start) • [Troubleshooting](#-troubleshooting)

</div>

---

## 🎯 Overview

Modern attacks often abuse legitimate tools, Office applications, scripts, WMI, and trusted Windows processes to execute malicious actions while avoiding traditional signature-based detection.

This repository provides a focused set of PowerShell scripts to help reduce that exposure by using **Microsoft Defender Attack Surface Reduction (ASR)** controls.

Instead of trying to be an all-in-one endpoint management framework, this project intentionally stays lean and practical:

- validate whether Microsoft Defender is available and operational
- apply a selected ASR hardening baseline
- provide a direct rollback path for the same ASR rule set
- document common issues that can prevent deployment

---

## 🔍 What ASR Brings to a Defensive Baseline

Attack Surface Reduction rules are designed to block behaviors commonly associated with malware, ransomware, post-exploitation activity, and abuse of legitimate administrative components.

| Defensive Area | What ASR Helps Reduce |
|----------------|------------------------|
| **Initial execution** | Suspicious executables from email, webmail, and scripts |
| **Office abuse** | Child process spawning, code injection, executable creation |
| **Credential access** | LSASS credential theft techniques |
| **Persistence** | WMI event subscription abuse |
| **Lateral movement** | PSExec and WMI-based remote process creation |
| **Impact** | Ransomware-like behaviors and unsafe execution paths |
| **Trusted tool abuse** | Impersonated system tools and vulnerable signed drivers |

---

## ✨ Why This Repository Is Useful

| Project Value | Description |
|---------------|-------------|
| **Focused scope** | Covers a practical ASR workflow without unnecessary complexity |
| **Operationally relevant** | Includes status validation before attempting changes |
| **Rollback-aware** | Keeps a direct script for reverting the configured rule set |
| **Portfolio-friendly** | Demonstrates Windows security hardening with native controls |
| **Readable and auditable** | Clear script purpose, clean structure, and transparent intent |

---

## 📦 Included Scripts

| Script | Purpose | When to Use |
|--------|---------|-------------|
| **`test-defender-status.ps1`** | Checks whether Microsoft Defender is available and running correctly | Run first, before changing ASR settings |
| **`enable-asr.ps1`** | Enables the ASR rules included in this project | Use when applying the hardening baseline |
| **`rollback-asr.ps1`** | Disables the ASR rules configured by this project | Use for rollback, compatibility testing, or recovery |

---

## 🛡️ Security Coverage

The current baseline focuses on high-value protections relevant to common Windows attack paths.

| Protection Category | Examples Included |
|---------------------|------------------|
| **Credential Protection** | Block credential theft from LSASS |
| **Office Hardening** | Block child processes, executable content, and process injection from Office |
| **Script Control** | Block obfuscated scripts and script-launched executables |
| **Email and Webmail Protection** | Block executable content originating from email and webmail |
| **USB Execution Control** | Block untrusted and unsigned processes from USB |
| **Persistence Prevention** | Block WMI event subscription persistence |
| **Remote Execution Abuse** | Block PSExec and WMI process creation |
| **Ransomware Defense** | Use advanced protection against ransomware |
| **Driver and Tool Abuse** | Block vulnerable signed drivers and impersonated system tools |

---

## 📋 ASR Rules Included

| Rule | Purpose |
|------|---------|
| **Block abuse of exploited vulnerable signed drivers** | Reduces abuse of trusted but vulnerable drivers |
| **Block Adobe Reader from creating child processes** | Helps prevent document-based execution chains |
| **Block all Office applications from creating child processes** | Disrupts common Office-to-shell attack paths |
| **Block credential stealing from LSASS** | Helps prevent credential dumping |
| **Block executable content from email client and webmail** | Reduces risky execution from user-delivered content |
| **Block untrusted executable files** | Restricts unsafe executable launch behavior |
| **Block execution of potentially obfuscated scripts** | Helps stop evasive script techniques |
| **Block JavaScript or VBScript from launching downloaded executable content** | Cuts off script-to-binary execution chains |
| **Block Office applications from creating executable content** | Prevents Office from generating executables |
| **Block Office applications from injecting code into other processes** | Reduces process injection activity from Office |
| **Block Office communication applications from creating child processes** | Helps prevent abuse through Office communication apps |
| **Block persistence through WMI event subscription** | Disrupts a common persistence technique |
| **Block process creations from PSExec and WMI** | Reduces remote execution abuse |
| **Block untrusted and unsigned processes from USB** | Limits unsafe execution from removable media |
| **Block Win32 API calls from Office macros** | Restricts dangerous macro behavior |
| **Use advanced protection against ransomware** | Adds behavioral protection against ransomware activity |
| **Block webshell creation for servers** | Helps mitigate server-side malicious scripting abuse |
| **Block use of copied or impersonated system tools** | Reduces abuse of fake or copied native binaries |

---

## 🚀 Quick Start

### 1. Validate Microsoft Defender status

```powershell
.\scripts\test-defender-status.ps1
```

### 2. Apply the ASR hardening baseline

```powershell
.\scripts\enable-asr.ps1
```

### 3. Roll back the configured rules if needed

```powershell
.\scripts\rollback-asr.ps1
```

---

## 🧭 Recommended Workflow

| Step | Action | Goal |
|------|--------|------|
| **1** | Run `test-defender-status.ps1` | Confirm Defender is available and active |
| **2** | Review environment compatibility | Check for legacy scripts, macros, or special workloads |
| **3** | Run `enable-asr.ps1` as Administrator | Apply the ASR baseline |
| **4** | Validate behavior after deployment | Confirm no critical workflow was disrupted |
| **5** | Use `rollback-asr.ps1` if required | Revert the applied rule set |

---

## 🧪 Expected Environment

| Requirement | Details |
|-------------|---------|
| **Operating System** | Windows 10 or Windows 11 |
| **PowerShell** | 5.1 or higher |
| **Permissions** | Administrator privileges required |
| **Security Platform** | Microsoft Defender available and enabled |

---

## ⚙️ Execution Policy

If PowerShell blocks script execution, you may need to allow local script execution for your user context:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Run PowerShell as Administrator when applying or rolling back ASR rules.

---

## 🛠️ Troubleshooting

### Error `0x800106ba`

![Error Screenshot](https://github.com/user-attachments/assets/b9ce74c7-05d5-433b-865f-6f98176d6016)

This usually indicates that **Microsoft Defender Antivirus is disabled, unavailable, or being overridden by another security product or enterprise policy**.

### Check Defender status

```powershell
Get-Service WinDefend
Get-MpComputerStatus
```

### Try starting the Defender service

```powershell
Start-Service WinDefend
```

### Review the following conditions

| Possible Cause | What to Check |
|----------------|---------------|
| **Another antivirus installed** | Third-party AV may disable or replace Defender |
| **Defender service stopped** | Confirm `WinDefend` is running |
| **Group Policy restrictions** | Local or domain policy may disable Defender settings |
| **Enterprise management override** | Intune, Configuration Manager, or other tooling may enforce different settings |
| **Permission issue** | Confirm PowerShell is running as Administrator |

---

## 🔐 Safety and Operational Notes

| Guidance | Reason |
|----------|--------|
| **Test before broad deployment** | Some environments have legacy dependencies |
| **Review Office and macro usage** | Certain business workflows may be affected |
| **Use only where authorized** | Endpoint hardening should be applied only to systems you own or manage |
| **Keep rollback available** | Rapid reversal reduces operational risk during testing |
| **Validate Defender first** | Prevents false assumptions when Defender is disabled |

---

## 🧠 Design Philosophy

This project is intentionally straightforward.

It does **not** try to be a full enterprise management suite, a reporting framework, or an all-in-one compliance product. Its value is in doing a focused job well:

- verify Defender readiness
- apply a practical ASR baseline
- offer a clear rollback path
- keep the implementation understandable

That makes it useful both as a real administrative utility and as a clean cybersecurity portfolio project.

---

## 📁 Repository Structure

```text
windows-defender-asr-hardening/
├── README.md
├── LICENSE
└── scripts/
    ├── enable-asr.ps1
    ├── rollback-asr.ps1
    └── test-defender-status.ps1
```

---

## 🎓 Use Cases

| Scenario | How This Repository Helps |
|----------|---------------------------|
| **Security lab or home lab** | Test ASR deployment and Defender behavior safely |
| **Windows administration practice** | Learn how to validate and apply Defender controls |
| **Cybersecurity portfolio** | Demonstrate defensive scripting and endpoint hardening |
| **Small-scale endpoint hardening** | Apply a focused ASR baseline without extra tooling |

---

## 🗺️ Roadmap

The repository is intentionally minimal right now. Likely future improvements include:

| Planned Improvement | Purpose |
|---------------------|---------|
| **Audit mode support** | Safer pre-deployment validation |
| **Configuration export** | Easier comparison and documentation |
| **Enhanced logging** | Better post-change visibility |
| **Improved reporting** | Clearer operational feedback |
| **More structured rule documentation** | Easier maintenance and review |

---

## 🤝 Contributing

Suggestions, corrections, and improvements are welcome.

If you want to improve rule coverage, documentation quality, validation logic, or operational safety, feel free to open an issue or submit a pull request.

---

## 📄 License

This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**[@LuisHenri1](https://github.com/LuisHenri1)**

---

<div align="center">

**Windows hardening should be effective, understandable, and reversible.**

</div>
