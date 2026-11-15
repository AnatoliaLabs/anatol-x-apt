# Anatol-X APT Deposu

Anatol-X Linux dağıtımının resmi paket deposu — Anatolium web tarayıcısı ve
Anatol-X uygulamalarının güncellemeleri buradan otomatik olarak kullanıcılara ulaşır.

- **Kullanım (Anatol-X sistemlerinde):** `/etc/apt/sources.list.d/anatol-x.sources`
  üzerinden `https://anatolialabs.github.io/anatol-x-apt` adresine bağlanır.
  İmza zorunlu olarak doğrulanır (`Signed-By`).
- **Yayınlama (depo yöneticileri):**
  ```bash
  sudo apt-get install -y reprepro   # Debian/Ubuntu
  sudo dnf install -y reprepro dpkg  # Fedora
  scripts/add-package.sh /yol/paket_1.0.0_amd64.deb
  git commit -m "Paket: anatolium 0.4.1" && git push
  ```
  GitHub Pages birkaç dakika içinde yayını yapar.
- **Yapı:** `dists/` (imzalı `InRelease` + indeksler), `pool/` (paket dosyaları),
  `conf/distributions` (reprepro tanımı), `scripts/add-package.sh` (yardımcı).
- **İmza anahtarı:** `5C4945D31E22475E` — *Anatolium RPM Signing* (Anatolia Labs).
  Public key `pubkey.asc` olarak bu repoda tutulur. **Gizli anahtar asla bu repoya girmez.**
- **Maliyet:** 0 TL. (GitHub ücretsiz barındırma; yumuşak sınırlar: site 1 GB,
  yaklaşık 100 GB/ay bant genişliği. Aşımda Cloudflare R2'ye geçiş 0 TL.)
- **Sürümler:** yalnızca son 2 sürüm `pool/` içinde tutulur; eskiler silinir.

Gizli bir anahtara ihtiyacınız varsa (yayınlama): Anatolia Labs üyesiyseniz
kurucuyla görüşün. Anahtar dışa aktarımı sohbete/repoya yapıştırılmaz;
doğrudan `gpg --armor --export-secret-keys` çıktısı ilgili Actions secret'ına
veya güvenli kasaya gider.
