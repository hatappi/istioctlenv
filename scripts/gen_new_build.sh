#!/bin/bash
set -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)
ROOT_DIR=${SCRIPT_DIR}/..

if [ $# -ne 1 ]; then
  echo "Please specify tag name. e.g. ./scripts/gen_new_build.sh 1.14.3"
  exit 1
fi

TAG=$1
echo "tag: ${TAG}"

output=""

browser_download_url() {
  curl \
    -Ls --fail \
    -H "Accept: application/vnd.github+json"  \
    "https://api.github.com/repos/istio/istio/releases/tags/${TAG}" \
  | jq -r ".assets[] | select(.name == \"$1\") | .browser_download_url"
}

asset_sha256() {
  curl -Ls --fail $1.sha256 | awk '{print $1}'
}

cat <<EOF
##############################
        Darwin 64bit
##############################
EOF
filename="istioctl-${TAG}-osx.tar.gz"
asset_url=$(browser_download_url ${filename})
sha256=$(asset_sha256 $asset_url)

echo "${asset_url}#${sha256}"
output+="install_darwin_64bit \"istioctl Darwin 64bit ${TAG}\" \"${asset_url}#${sha256}\"\n\n"

cat <<EOF
##############################
        Darwin ARM 64bit
##############################
EOF
filename="istioctl-${TAG}-osx-arm64.tar.gz"
asset_url=$(browser_download_url ${filename})
sha256=$(asset_sha256 $asset_url)

echo "${asset_url}#${sha256}"
output+="install_darwin_arm \"istioctl Darwin arm ${TAG}\" \"${asset_url}#${sha256}\"\n\n"

cat <<EOF
##############################
        Linux 64bit
##############################
EOF
filename="istioctl-${TAG}-linux-amd64.tar.gz"
asset_url=$(browser_download_url ${filename})
sha256=$(asset_sha256 $asset_url)

echo "${asset_url}#${sha256}"
output+="install_linux_64bit \"istioctl Linux 64bit ${TAG}\" \"${asset_url}#${sha256}\"\n\n"

cat <<EOF
##############################
        Linux ARM 64bit
##############################
EOF
filename="istioctl-${TAG}-linux-arm64.tar.gz"
asset_url=$(browser_download_url ${filename})
sha256=$(asset_sha256 $asset_url)

echo "${asset_url}#${sha256}"
output+="install_linux_arm_64bit \"istioctl Linux arm 64bit ${TAG}\" \"${asset_url}#${sha256}\""

cat <<EOF
##############################
     Generate build file
##############################
EOF
output_path="${ROOT_DIR}/plugins/istioctl-build/share/istioctl-build/${TAG}"
echo $output_path
echo $output > $output_path
