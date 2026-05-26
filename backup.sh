#!/bin/bash

# ============================================
# SKRIP BACKUP OTOMATIS - RSUD
# Dibuat oleh: Donny
# Fungsi: Backup folder data setiap hari
# ============================================

# --- KONFIGURASI ---
FOLDER_SUMBER="/home/donny/belajar-devops/project-backup/data"
FOLDER_BACKUP="/home/donny/belajar-devops/project-backup/backup"
FOLDER_LOG="/home/donny/belajar-devops/project-backup/logs"
SIMPAN_BERAPA_HARI=60

# --- VARIABEL OTOMATIS ---
TANGGAL=$(date +"%Y-%m-%d_%H-%M-%S")
NAMA_FILE="backup_$TANGGAL.tar.gz"
FILE_LOG="$FOLDER_LOG/log_backup.txt"

# --- MULAI PROSES ---
echo "=============================" >> $FILE_LOG
echo "Backup dimulai: $TANGGAL" >> $FILE_LOG

# Buat file backup
tar -czf "$FOLDER_BACKUP/$NAMA_FILE" -C "$FOLDER_SUMBER" .

# Cek apakah backup berhasil
if [ $? -eq 0 ]; then
    echo "BERHASIL: $NAMA_FILE dibuat" >> $FILE_LOG
    echo "Ukuran: $(du -sh $FOLDER_BACKUP/$NAMA_FILE | cut -f1)" >> $FILE_LOG
else
    echo "GAGAL: Backup tidak berhasil!" >> $FILE_LOG
fi

# Hapus backup lebih dari 7 hari
find "$FOLDER_BACKUP" -name "backup_*.tar.gz" -mtime +$SIMPAN_BERAPA_HARI -delete
echo "Backup lama sudah dibersihkan" >> $FILE_LOG
echo "=============================" >> $FILE_LOG

echo "Backup selesai! Cek log di: $FILE_LOG"
