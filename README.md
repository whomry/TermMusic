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
