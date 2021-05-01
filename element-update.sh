#!/bin/sh
localversion=$(cat /var/www/element/version)
latestversion=$(curl -s https://api.github.com/repos/vector-im/element-web/releases/latest \
                   | grep "tag_name" \
                   | cut -d : -f 2,3 \
                   | tr -d '"v,[:space:]' \
                 )

if [ "$localversion" = "$latestversion" ]; then
        echo "$(date +%c) No new updates." >> /var/log/element_update.log
    else
            curl -s https://api.github.com/repos/vector-im/element-web/releases/latest \
                | grep "browser_download_url.*tar.gz" \
                | sed '/.asc/d' \
                | cut -d '"' -f 4 \
                | wget -qi -
            mv /etc/nginx/conf.d/element.domain.tld.conf /etc/nginx/conf.d/element.domain.tld.conf_disabled
            service nginx reload
            mv /var/www/element /var/www/element_old
            tar -xf element-v$latestversion.tar.gz
            mv element-v$latestversion /var/www/element
            cp /var/www/element_old/config.json /var/www/element/config.json
            chown -R www-data:www-data /var/www/element
            mv /etc/nginx/conf.d/element.domain.tld.conf_disabled /etc/nginx/conf.d/element.domain.tld.conf
            service nginx reload
            rm element-v$latestversion.tar.gz
            rm -r /var/www/element_old
            echo "$(date +%c) Update to version $latestversion" >> /var/log/element_update.log
fi


