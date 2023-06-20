#!/usr/bin/env bash

_die() {
  [[ -n $1 ]] && echo "$1"
  exit ${2:-1}
}

# satisfy prereqs
if ! hash brew &>/dev/null; then
  _die "requires Homebrew, visit https://brew.sh for instructions"
fi
if ! hash otfinfo &>/dev/null; then
  brew install --quiet lcdf-typetools
fi
if ! hash jq &>/dev/null; then
  brew install --quiet jq
fi

REPO='JetBrains/JetBrainsMono'
ODIR="${HOME}/Downloads"
CURLOPTS=( --location --connect-timeout 15 --max-time 60 )
LOCAL_VER=$(otfinfo -v ~/Library/Fonts/JetBrainsMono-Regular.ttf 2>/dev/null)
[[ $LOCAL_VER =~ ([0-9.-]+) ]] && CUR_VER=${BASH_REMATCH[1]}

# get release info from GitHub
JSON=$(
  curl "${CURLOPTS[@]}" --silent https://api.github.com/repos/${REPO}/releases |
  jq 'map(select(.prerelease==false and (.tag_name|contains("beta")|not)))[0]'
)
[[ -z $JSON ]] || [[ $JSON == "null" ]] && _die "error fetching data from GitHub"
LATEST_TAG=$(jq -r .tag_name <<<"$JSON")
[[ $LATEST_TAG =~ ([0-9.-]+) ]] && LATEST_VER=${BASH_REMATCH[1]}
[[ -n $LATEST_VER ]] || _die "error parsing latest release tag from GitHub"
[[ ${LATEST_VER} == "${CUR_VER}" ]] && _die "version ${CUR_VER} already installed" 0
ZIP_URL=$(jq -r '.assets | map(select(.name|match("JetBrainsMono.*\\.zip")))[0] | .browser_download_url' <<<"$JSON")
[[ -n $ZIP_URL ]] || _die "error obtaining asset URL"

# download & install
ZIP_FILENAME=${ZIP_URL##*/}
if ! curl "${CURLOPTS[@]}" --progress-bar --remote-name --output-dir "$ODIR" "${ZIP_URL}"; then
  _die "error downloading ${ZIP_FILENAME}"
fi
unzip -qo "${ODIR}/${ZIP_FILENAME}" 'fonts/ttf/*' -d "${ODIR}/jetbrains"
find "${ODIR}/jetbrains/fonts/ttf" -name "*.ttf" -exec cp {} ~/Library/Fonts \;
rm "${ODIR}/${ZIP_FILENAME}" 2>/dev/null
rm -r "${ODIR}/jetbrains" 2>/dev/null
