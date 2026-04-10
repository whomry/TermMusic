#!/bin/bash

# ==========================================
# TermuMusic - Bash Edition
# Pemutar Musik Sederhana untuk Terminal Linux
# ==========================================

# --- Konfigurasi ---
# Tentukan folder default (Bisa diubah, misalnya "$HOME/Music")
MUSIC_DIR="${1:-$HOME/Music}"

# Pastikan mpg123 terinstall
if ! command -v mpg123 &> /dev/null; then
    echo -e "\e[31mError: 'mpg123' belum terinstall.\e[0m"
    echo "Silakan install terlebih dahulu:"
    echo "  Debian/Ubuntu: sudo apt install mpg123"
    echo "  Arch Linux:    sudo pacman -S mpg123"
    echo "  Fedora:        sudo dnf install mpg123"
    exit 1
fi

# Cek apakah direktori valid
if [ ! -d "$MUSIC_DIR" ]; then
    # Jika ~/Music tidak ada, fallback ke $HOME
    MUSIC_DIR="$HOME"
fi

# Array untuk menyimpan path file musik
declare -a PLAYLIST

echo -e "\e[1;36m🎵 Selamat datang di TermuMusic (Bash Edition) 🎵\e[0m"
echo -e "Memindai file musik (.mp3) di: \e[1;33m$MUSIC_DIR\e[0m ..."

# Memindai file menggunakan 'find'
# -not -path '*/\.*' digunakan untuk mengabaikan folder tersembunyi (seperti .cache, .config)
# Ini penting agar pencarian lebih cepat dan menghindari error permission
while IFS= read -r file; do
    PLAYLIST+=("$file")
done < <(find "$MUSIC_DIR" -type f -iname "*.mp3" -not -path '*/\.*' 2>/dev/null)

TOTAL_SONGS=${#PLAYLIST[@]}

if [ "$TOTAL_SONGS" -eq 0 ]; then
    echo -e "\e[31mTidak ada file .mp3 yang ditemukan di $MUSIC_DIR.\e[0m"
    exit 0
fi

echo -e "\e[1;32m✔ Ditemukan $TOTAL_SONGS lagu!\e[0m"
echo ""

# --- Menu Interaktif Utama ---
# Mengatur prompt untuk command 'select'
PS3=$'\n\e[1;33mPilih nomor lagu untuk diputar (atau ketik q untuk keluar): \e[0m'

# Agar daftar file yang panjang tidak terlihat berantakan, kita hanya tampilkan nama file, bukan full path
# Membuat array baru khusus untuk tampilan menu
declare -a DISPLAY_NAMES
for path in "${PLAYLIST[@]}"; do
    DISPLAY_NAMES+=("$(basename "$path")")
done

# Menampilkan menu pilihan menggunakan select
select song_name in "${DISPLAY_NAMES[@]}"; do
    # Jika user mengetik 'q', program berhenti
    if [[ "$REPLY" == "q" || "$REPLY" == "Q" ]]; then
        echo -e "\e[1;32mKeluar dari TermuMusic. Sampai jumpa!\e[0m"
        break
    fi

    # Validasi apakah nomor yang dimasukkan valid
    if [ -n "$song_name" ]; then
        # Index array Bash dimulai dari 0, sedangkan nomor menu select dimulai dari 1
        INDEX=$((REPLY-1))
        FILE_TO_PLAY="${PLAYLIST[$INDEX]}"
        
        echo -e "\n\e[1;36m▶ Sedang memutar:\e[0m \e[1;37m$song_name\e[0m"
        echo -e "\e[90m(Tekan 's' untuk skip, 'space' untuk pause/resume, 'q' untuk berhenti memutar lagu ini)\e[0m\n"
        
        # Menjalankan mpg123
        # -C (control keys aktif: s=skip, space=pause, q=quit lagu)
        # -q (quiet, tidak menampilkan teks info mpg123 yang panjang)
        mpg123 -C -q "$FILE_TO_PLAY"
        
        # Setelah lagu selesai/dihentikan, tampilkan kembali prompt
        echo -e "\n\e[32m✔ Lagu selesai.\e[0m Silakan pilih lagu lain."
        
        # Tampilkan ulang daftar menu agar user ingat nomornya
        # (Komen bagian bawah ini jika Anda tidak ingin daftar lagu dicetak berulang kali)
        # RECOMPUTE MENU:
        # for i in "${!DISPLAY_NAMES[@]}"; do
        #    printf "%3d) %s\n" $((i+1)) "${DISPLAY_NAMES[$i]}"
        # done
    else
        echo -e "\e[31mPilihan tidak valid. Silakan masukkan nomor yang ada.\e[0m"
    fi
done
