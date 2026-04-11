# 🎵 TermMusic (CLI Audio Player)

Sebuah pemutar musik berbasis terminal (CLI) yang simpel dan sangat ringan. *Script* ini dibangun menggunakan Bash dan memanfaatkan `mpg123` sebagai mesin pemutarnya. Sangat cocok buat kamu yang ingin mendengarkan koleksi lagu lokal (MP3) tanpa harus membuka aplikasi GUI yang berat.

## ✨ Fitur
- **Sangat Ringan**: Berjalan 100% di terminal, hemat resource CPU & RAM.
- **Mudah Digunakan**: Tinggal jalankan *script*, musik langsung mengalun.
- **Custom Directory**: Mendukung pemutaran musik dari folder spesifik (cocok kalau musikmu tersimpan di folder atau partisi lain).

## 📦 Requirements (Kebutuhan Sistem)
Karena *script* ini adalah *wrapper* untuk `mpg123`, pastikan komputer/server kamu sudah terinstal *package* tersebut.

**Cara install di Ubuntu / Debian / Armbian:**
```bash
sudo apt update
sudo apt install mpg123
```

## Cara Pakai:
**Clone repositori ini dan masuk ke foldernya, lalu berikan izin eksekusi pada script:**
```bash
chmod +x termumusic.sh
```
**Mode Default (Folder Saat Ini)**
```bash
./termumusic.sh
```

**Spesific Folder**
```bash
./termumusic.sh /path/folder/music
```
**Catatan:** Ganti `/path/folder/music` dengan lokasi folder musik kamu yang sebenarnya.
Contoh: `./termmusic.sh ~/Music/Anime_OST/`


