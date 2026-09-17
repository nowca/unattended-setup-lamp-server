<h1>Unattended Installation of a LAMP-Webserver on Debian or Ubuntu</h1>

![lamp-server](lamp-server.jpg)

This shell-script installs a basic **LAMP**-Stack (*Linux, Apache, MySQL, PHP*) on **Debian** or **Ubuntu**.
<br>
It runs an unattended installation as a noninteractive routine, so it can be used for automatic build applications like Docker.
(the related Dockerfile can be found [here](https://https://github.com/nowca/docker-debian-lamp))

See the use of the script in Docker: https://github.com/nowca/docker-debian-lamp

*The script is successfully tested on Debian 12 (Bookworm), 13 (Trixie), Ubuntu 26.04.1 (Resolute Raccoon) and Ubuntu 24.04.5 (Noble Numbat)*

After the installation the basic Apache-webserver runs with *PhpMyAdmin* on `http://<your-server>/phpmyadmin` and must be configured. The MySQL-Rootpassword ist `rootROOT123!` and must be changed.

Don't forget basic server security. (...remove apache-version from responses, deactivate file-listings, file-rights, unused server-modules, etc...)