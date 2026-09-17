<h1>Unattended Installation of a LAMP-Webserver on Debian or Ubuntu</h1>

![lamp-server](lamp-server.jpg)

This shell-script installs a basic **LAMP**-Stack (*Linux, Apache, MySQL, PHP*) on **Debian** or **Ubuntu**.
<br>
It runs an unattended installation as a noninteractive routine, so it can be used for automatic build applications like Docker.

Related Docker-project: [https://github.com/nowca/docker-debian-lamp](https://github.com/nowca/docker-debian-lamp) 

After the installation the basic Apache-webserver runs with *PhpMyAdmin* on `http://<your-server>/phpmyadmin` and must be configured. The MySQL-Rootpassword ist `rootROOT123!` and must be changed.

<h3>MySQL Version</h3>

```bash
MYSQL_PACKAGE=mysql-9.7-lts
```

See available MySQL-Packages here: [https://repo.mysql.com/apt/](https://repo.mysql.com/apt/) 

<h3>Known error</h3>

```console
gpg: WARNING: nothing exported
gpg: no valid OpenPGP data found.
```

If the installation breaks with a missing public key, you need to set the PUBKEY-value by yourself.

*(see NO_PUBKEY/Missing key with `apt-get update`)*

```bash
PUBKEY=<insert public-key value here> \
&& gpg ...
```

<h3>Configuration</h3>

The server still needs to be configured.

Please don't forget basic server security. *(...remove Apache-version from responses, deactivate file-listings, file-rights, unused server-modules, etc...)*
