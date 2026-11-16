# Tugas Rutin 3 - Kalkulator IP Semester

## Identitas
- Nama: M. Faris Al Rafiq
- NIM: 4241250001
- Kelas: PSIK 24 C
- Mata kuliah: Pemrograman Mobile (3KOM40215)

## Tangkapan Layar
![Sesi program](sesi.png)

## Penjelasan
Higher-order function saya pakai di beberapa tempat. Di `hitungIp`, `fold`
menjumlahkan total SKS dan total poin (SKS x bobot) untuk menghitung IP. Di
`cetakKhs`, `where` menyaring mata kuliah berbobot di bawah 2 dan `map`
mengambil namanya, sedangkan `sort` dengan fungsi pembanding mengurutkan KHS
dari nilai tertinggi. Fungsi pembanding itu berupa fungsi anonim yang dikirim
sebagai argumen.

Untuk error handling, fungsi `validasiSks` dan `validasiNilai` melempar
`FormatException` bila SKS bukan angka 1-6 atau nilai bukan A-E. Exception
tersebut ditangkap di `main` dengan `try/on FormatException`, sehingga data
yang salah hanya diabaikan dan program tetap berjalan. Dengan begitu fungsi
validasi cukup fokus memeriksa, sedangkan pesan ke pengguna ditangani di satu
tempat.

## Penggunaan AI
Saya memakai Claude untuk membantu menyusun kerangka kode dan README. Saya
menjalankan, menguji, dan memahami kodenya sendiri.