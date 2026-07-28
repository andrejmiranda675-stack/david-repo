#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

source repo-info.conf

rm -rf public
mkdir -p public/debs

cp index.html CydiaIcon.png public/
touch public/.nojekyll

if compgen -G "debs/*.deb" > /dev/null; then
  cp debs/*.deb public/debs/
  dpkg-scanpackages -m debs /dev/null > public/Packages
else
  : > public/Packages
fi

gzip -9c public/Packages > public/Packages.gz

cd public
PACKAGES_SIZE=$(wc -c < Packages | tr -d ' ')
PACKAGES_GZ_SIZE=$(wc -c < Packages.gz | tr -d ' ')
PACKAGES_MD5=$(md5sum Packages | awk '{print $1}')
PACKAGES_GZ_MD5=$(md5sum Packages.gz | awk '{print $1}')
PACKAGES_SHA256=$(sha256sum Packages | awk '{print $1}')
PACKAGES_GZ_SHA256=$(sha256sum Packages.gz | awk '{print $1}')

cat > Release <<EOF2
Origin: ${REPO_ORIGIN}
Label: ${REPO_LABEL}
Suite: stable
Version: 1.0
Codename: ios
Architectures: iphoneos-arm
Components: main
Description: ${REPO_DESCRIPTION}
Maintainer: ${REPO_MAINTAINER}
MD5Sum:
 ${PACKAGES_MD5} ${PACKAGES_SIZE} Packages
 ${PACKAGES_GZ_MD5} ${PACKAGES_GZ_SIZE} Packages.gz
SHA256:
 ${PACKAGES_SHA256} ${PACKAGES_SIZE} Packages
 ${PACKAGES_GZ_SHA256} ${PACKAGES_GZ_SIZE} Packages.gz
EOF2
