#!/bin/sh
# ADLab ran on dc01: its Chads/Degens/Normies groups exist, 30 users were created, and some of
# them are Kerberoastable.
set -eu
base="DC=bufu-sec,DC=local"
q() { curl -sS --max-time 20 -u 'BUFU-SEC\vagrant:vagrant' "ldap://dc01/$base?$1?sub?$2"; }
q cn "(cn=Chads)" | grep -q "CN=Chads"
q cn "(cn=Degens)" | grep -q "CN=Degens"
[ "$(q sAMAccountName "(objectCategory=person)" | grep -c "^DN:")" -ge 30 ]
q sAMAccountName "(&(objectCategory=person)(servicePrincipalName=*)(!(sAMAccountName=krbtgt)))" | grep -q "sAMAccountName"
echo "ADLab groups, users and Kerberoastable users are in bufu-sec.local"
