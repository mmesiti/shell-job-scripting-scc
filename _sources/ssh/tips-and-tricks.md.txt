# SSH ergonomics

A look at tools and practices that can help using SSH efficiently.

```{objectives}
- Understand the universality/advantages of ssh keys
- Create your own ssh key and register it
- Adapt your ssh config to your needs for improved ergonomics
```
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

The procedure of creating a new key
and register it
needs to be repeated every 3 months.

## The `.ssh/config` file

If we add the following text to the `.ssh/config` file:
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


```



- ssh keys: pros and cons
- Limitations specific to HoreKa and BWUniCluster
- `ssh-keygen`
- `ssh-agent`



## Security on HPC is important!

The May 2020 security outages:
- https://www.bwhpc.de/211.php
- https://www.bleepingcomputer.com/news/security/european-supercomputers-hacked-in-mysterious-cyberattacks/
- https://www.welivesecurity.com/2020/05/18/european-supercomputers-hacked-mine-cryptocurrency/
