#!/bin/bash

PKGBUILD=pkgbuilds/telegram-desktop-sakari/PKGBUILD

source $PKGBUILD

latest_tag=$(curl -s "https://api.github.com/repos/telegramdesktop/tdesktop/tags" | jq -r '.[0].name')

if [ "${latest_tag/v/}" != "${pkgver}" ]
then
    sed -i "s/pkgver=$pkgver/pkgver=${latest_tag/v/}/" $PKGBUILD
    if [ "${pkgrel}" != 1 ]
    then
        sed -i "s/pkgrel=$pkgrel/pkgrel=1/" $PKGBUILD
    fi

    source $PKGBUILD
    tg_tar_link=$source[1]
    wget $tg_tar_link -o tdesktop.tar.gz
    oldsha=$sha512sums[1]
    newsha=$(sha512sum tdesktop.tar.gz)
    sed -i "s/${oldsha}/${newsha}/" $PKGBUILD

    # echo 1 if updated
    echo 1
    exit 0
fi
echo 0
