### /etc/pam.d/sudo

Use TouchID to _sudo_ instead of password.

```diff
# sudo: auth account password session
+ auth       sufficient     pam_tid.so
auth       sufficient     pam_smartcard.so
auth       required       pam_opendirectory.so
account    required       pam_permit.so
password   required       pam_deny.so
session    required       pam_permit.so
```

Source: https://davidwalsh.name/touch-sudo