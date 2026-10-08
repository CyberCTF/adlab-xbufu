# ADLab (xbufu)

[ADLab](https://github.com/xbufu/ADLab) by xbufu: a PowerShell module that automates an Active
Directory lab for practising internal penetration testing (its attack vectors credit Joe
Helle's PowerShell for Pentesters course). This repository runs it with
[Isoloom](https://www.isoloom.com): [`isoloom.yml`](isoloom.yml) describes the machine, and
[`provision/main.yml`](provision/main.yml) builds it from a controller: it promotes a new forest,
`bufu-sec.local` (the domain upstream's README uses), imports upstream's module unchanged and
runs, with their defaults, `Invoke-ADLabFill` and the attack vectors that apply to a single
domain controller: `Set-Kerberoasting`, `Set-BadACLs`, `Set-PSRemoting`.

| Machine | Name | Services |
| --- | --- | --- |
| dc01 | domain controller of bufu-sec.local (Windows Server 2019) | DNS 53, Kerberos 88, RPC 135, LDAP 389, SMB 445, WinRM 5985 |

What it plants: 30 random users in the Chads, Degens and Normies groups and OUs (weak passwords
from a short list), 5% of users Kerberoastable, GenericAll from some
Normies onto some Degens, from Degens onto Chads, and from Chads onto Domain Admins.

`Set-ASREPRoasting` is not used: upstream's version never sets the flag (its `else` keyword is
missing, so the list of users stays empty, and its `-Users` branch reads an undefined `$User`).

The module's other parts need more machines or a different network (DHCP, a second DC, SQL
Server, delegation and local admin vectors on member computers) and are not used here.

## Run it

```bash
isoloom run vagrant
isoloom test vagrant
```

About 4 GB of memory (3 GB for the domain controller, 1 GB for the controller) and 20 minutes.
The Windows Server 2019 box is an evaluation build downloaded by Vagrant.

Upstream version and commit: [UPSTREAM.md](UPSTREAM.md).

## Licence

MIT, as ADLab ([LICENSE](LICENSE)). This lab is deliberately vulnerable: keep it isolated.
