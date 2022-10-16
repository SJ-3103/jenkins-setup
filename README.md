root user login:

```
    sudo su -
```

when error in connecting to servers:
```
    sudo nano /etc/reslov.conf
    nameserver 8.8.8.8
```


run any .sh file:

```
    chmod +x /path/to/file.sh
    ./path/to/file.sh
```

if docker didn't start in debian:

to fix fstab:
```
    touch /etc/fstab
```

that is Debian nat issue, fix it with:

```
    sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
    sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
```

start docker by:
```
    sudo service docker start
```
