# Element-Update
## Prerequisites
This script requires you to have *element-web* and *nginx* installed on an Ubuntu/Debian server. It also assumes you have your nginx website config files in `/etc/nginx/conf.d/` and your *element-web* installation in `/var/www/element/`.
## How it works
Element-Updater will check the contents of `var/www/element/version` once per day and if needed fetch the latest release of *Element-Web*. It will also disable, reload your nginx config file and produce a logfile located at `/var/log/element-update.log`

## Install
Put *element-update.sh* to `/usr/local/bin` or a directory of your choice and move the systemd files to `/etc/systemd/system/`. Enable both files using
```sh
sudo systemctl enable element-update.service
sudo systemctl start element-update.service
sudo systemctl enable element-update.timer
sudo systemctl start element-update.timer
```
Check *element-update.sh* for the lines containing `element.domain.tld` and replace it with the appropriate path to the nginx config of your Element-Web instance's subdomain.
