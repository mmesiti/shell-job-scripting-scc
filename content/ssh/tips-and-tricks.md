# SSH ergonomics

A look at tools and practices that can help using SSH efficiently.

```{objectives}
- Adapt your ssh config to your needs for improved ergonomics
- Understand the universality/advantages of ssh keys
- Create your own ssh key and register it
```

## The `.ssh/config` file

If we add the following text to the `.ssh/config` file
(on the *client* machine):
```
Host uc3
    Hostname uc3.scc.kit.edu
    user <your-service-username>
```
we are allowed to connect 
BwUniCluster3.0 with the much simpler command
```
ssh uc3
```
Longer names are also fine, 
tab completion works!


## SSH keys
SSH key(pair)s are a mechanism for a remote machine
to identify you.

It is a common authentication method when:
- Connecting to HPC clusters
- Authenticating to GitHub/GitLab


### Generating a ssh keypair and registering it

A new key can be generated with the command
```
ssh-keygen -t ed25519
```
and following carefully the instructions 
that command tells you.

```{warning}
1. Do not accidentally overwrite existing keys that can be in use.
1. Do not use a passphrase-less ssh key
```

This will create a *private* key and a *public* key.
The *private* key should never leave your machine,
the public key can be distributed to e.g.
remote (HPC) machines,
GitHub,
GitLab servers and the like,
if they allow ssh as an access/authentication method.

```{note} Limitations on HoreKa and BWUniCluster3
- The procedure of creating a new key
and register it
needs to be repeated every 3 months.
- Old keys cannot be reused
- ssh access is possible only for an hour after 2FA access
- ssh keys must be registered through FeLS/BWIdm 
  and cannot be just added to `~/.ssh/authorized_keys`.

For more information, see 
[https://www.nhr.kit.edu/userdocs/horeka/sshkeys/](https://www.nhr.kit.edu/userdocs/horeka/sshkeys/)
```

## `ssh-agent`

The passphrase for a key can be "remembered"
(for a limited amount of time)
by a program named `ssh-agent`,
so that you do not need to type the passphrase all the times.

1. The command `ssh-add` can be used to "unlock" a (private) key
   for the duration of your session,
   so that it can be used without typing the passphrase any more.

2. Even more conveniently, by adding 
   ```
   AddKeysToAgent yes
   ```
   to `.ssh/config` on the client machine,
   you will make ssh ask you for the passphrase the first time you use the key,
   and then the key will be unlocked for passphrase-less use.

## Security on HPC is important!

SSH keys **must** be passphrase-protected, 
but this cannot be enforced server-side.

The May 2020 security outages:
- [https://www.bwhpc.de/211.php](https://www.bwhpc.de/211.php)
- [https://www.bleepingcomputer.com/news/security/european-supercomputers-hacked-in-mysterious-cyberattacks/](https://www.bleepingcomputer.com/news/security/european-supercomputers-hacked-in-mysterious-cyberattacks/)
- [https://www.welivesecurity.com/2020/05/18/european-supercomputers-hacked-mine-cryptocurrency/](https://www.welivesecurity.com/2020/05/18/european-supercomputers-hacked-mine-cryptocurrency/)
