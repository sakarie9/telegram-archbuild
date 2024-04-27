#!/bin/bash

PKGBUILD=pkgbuilds/telegram-desktop-sakari/PKGBUILD

source $PKGBUILD

oldver=${pkgver}
latest_tag=$(curl -s "https://api.github.com/repos/telegramdesktop/tdesktop/tags" | jq -r '.[0].name')
newver=${latest_tag/v/}

if [ "${newver}" != "${pkgver}" ]
then
    sed -i "s/pkgver=$pkgver/pkgver=${newver}/" $PKGBUILD
    if [ "${pkgrel}" != 1 ]
    then
        sed -i "s/pkgrel=$pkgrel/pkgrel=1/" $PKGBUILD
    fi

    source $PKGBUILD
    tg_tar_link=${source[0]}
    echo "Telegram Desktop tar link: ${tg_tar_link}!"
    wget "${tg_tar_link}" -O tdesktop.tar.gz
    oldsha=${sha512sums[0]}
    newsha=$(sha512sum tdesktop.tar.gz | cut -d ' ' -f 1)
    echo "New SHA512: ${newsha}"
    sed -i "s/${oldsha}/${newsha}/" $PKGBUILD

    echo "Updated from ${oldver} to ${newver}!"

    # echo 1 if updated
    echo 1 > updated
    echo ${newver} > newver
    exit 0
fi
echo "No Update!"
echo 0 >> updated
