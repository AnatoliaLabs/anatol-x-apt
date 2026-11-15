#!/bin/sh
# Anatol-X APT deposuna yeni paket(ler) ekler ve git'e hazırlar.
# Kullanım (repo kökünde): scripts/add-package.sh paket_1.0.0_amd64.deb [...]
set -e
if [ $# -lt 1 ]; then echo "Kullanim: scripts/add-package.sh paket.deb [paket.deb ...]" >&2; exit 1; fi
[ -f conf/distributions ] || { echo "Bu script repo kokunde calistirilmali." >&2; exit 1; }
command -v reprepro >/dev/null || { echo "reprepro kurulu degil. Debian: sudo apt-get install -y reprepro | Fedora: sudo dnf install -y reprepro" >&2; exit 1; }
command -v dpkg-deb >/dev/null || { echo "dpkg-deb kurulu degil. Fedora: sudo dnf install -y dpkg" >&2; exit 1; }
for d in "$@"; do
    dpkg-deb --info "$d" >/dev/null 2>&1 || { echo "Gecersiz .deb: $d" >&2; exit 1; }
    pkg=$(dpkg-deb -f "$d" Package); ver=$(dpkg-deb -f "$d" Version)
    echo "+ reprepro includedeb stable $d  ($pkg $ver)"
    reprepro -b . includedeb stable "$d"
done
git add conf dists pool db 2>/dev/null || git add conf dists pool
echo
echo "Paket(ler) depoya eklendi. Sonra:"
echo '  git commit -m "Paket guncellemesi"'
echo '  git push'
echo "GitHub Pages birkac dakika icinde https://anatolialabs.github.io/anatol-x-apt uzerinden yayinlar."
