# Sekilas tentang jenis data di R


# Vektor (DATA SATU DIMENSI) =========
## 1. vektor numerik, yaitu jenis data satu dimensi yang mengandung rangkaian data angka.
## Apa kira-kira contoh vektor/variabel numerik yang berisi data angka?
### - usia
### - panjang (suatu objek)
### - suhu
### - durasi (mis. dalam hitungan menit)
### ...
usia <- c(24, 32, 17)
usia
str(usia) # mengecek struktur data, yaitu vektor/variabel "num(erik)" satu dimensi

## Vektor numerik dalam R terdiri dari dua jenis, `double` (bilangan yang berisi nilai desimal, mis. 2.0, 2.1, 4.36, 87.32, etc.) dan `integer` (bilangan bulat, yaitu tanpa nilai desimal, mis. 2, 3, 5, 100).
bil_desimal <- c(2, 4, 5) # secara otomatis diangap bilangan desimal: 2.0, 4.0, and 5.0
bil_bulat <- c(2L, 4L, 5L) # menambahkan L setelah angka secara eksplisit kita menginginkan bilangan bulat (tanpa presisi koma/desimal setelahnya)
typeof(bil_desimal) # fungsi typeof() mengecek tipe/jenis suatu data -> untuk data bil_desimal, jenisnya adalah numerik double
typeof(bil_bulat) # fungsi typeof() mengecek tipe/jenis suatu data ->  untuk data bil_bulat, jenisnya adalah numerik integer
typeof(usia) # fungsi typeof() mengecek tipe/jenis suatu data -> double



## 2. vektor karakter, yaitu jenis data satu dimensi yang mengandung huruf/karakter.
## Apa kira-kira contoh vektor/variabel yang dapat bersifat karakter/mengandung huruf?
### - nama
### - kelas kata
### - kata
### ...
kelas_kata <- c("verba", "nomina", "ajektiva", "preposisi", "adverbia")
kelas_kata
typeof(kelas_kata) # character
str(kelas_kata)



## 3. vektor logikal, yaitu jenis data satu dimensi yang mengandung TRUE dan FALSE
data_logikal <- c(TRUE, FALSE, FALSE, TRUE)
data_logikal
typeof(data_logikal) # logikal
str(data_logikal)



## 4. faktor, yaitu jenis data yang *under the hood* "tersimpan sebagai integer unik, yaitu bilangan bulat unik", DAN "memiliki label dalam bentuk karakter". Data yang berjenis faktor terdiri atas komponen/data yang disebut dengan *levels*; R secara otomatis mengurutkan data/komponen dari faktor ini secara alfabetis.
sex <- c("male", "female", "female", "male", "female") # vektor karakter
typeof(sex)
str(sex)

sex_factor <- factor(c("male", "female", "female", "male", "female")) # membuat faktor, yaitu integer yang memiliki label karakter
### R akan memberikan nilai/integer "1" untuk "female" dan "2" untuk "male" karena secara alfabetis, "f" muncul lebih awal daripada "m", meskipun pada saat membuat faktor di atas, "male" ditulis lebih awal dibandingkan "female". Kita bisa buktikan/mengecek ini dengan menjalankan kode berikut:
levels(sex_factor) # female adalah level pertama, male adalah level kedua
str(sex_factor)
typeof(sex_factor) # R menyatakan bahwa faktor sex_factor adalah integer meskipun berlabel karakter!

# kita bisa ubah urutan kategori dalam faktor sex_factor dengan menambahkan argument `levels` dalam fungsi factor()
# misalnya, ubah urutan dari male (1) ke female (2)
sex_factor_reverse <- factor(sex_factor, levels = c("male", "female"))

# bandingkan urutan level kedua faktor berikut; isinya tetap sama tapi pengurutan levelnya berubah --- ini akan ada implikasi dalam hal visualisasi nantinya terkait kategori/level mana yang ingin ditampilkan lebih awal (mis. dalam diagram batang).
sex_factor
sex_factor_reverse

### IMPLIKASI Faktor
### - Faktor berperan penting dalam analisis statistik dan visualisasi.
# menyarikan informasi dalam data dengan fungsi summary()

# karena jenis data berupa faktor yang merupakan integer/bil. bulat, summary() akan langsung melakukan count/penghitungan jumlah level/komponen dari faktor jenis kelamin
summary(sex_factor) 
summary(sex_factor_reverse)
# kita bisa langsung gabungkan dengan fungsi visualisasi barplot()
barplot(summary(sex_factor)) 
# atau simpan terlebih dahulu luaran summary() lalu masukkan ke fungsi barplot()
sex_factor_count <- summary(sex_factor)
barplot(sex_factor_count)

# summary() tidak menghasilkan efek yang sama ketika data berupa karakter
summary(sex)
barplot(summary(sex)) # ERROR, kecuali lakukan tabulasi terlebih dahulu dengan table()
table(sex)
barplot(table(sex)) # berfungsi


# Menyimpan vektor ke dalam file plain teks
cat(kelas_kata, file = "kelas_kata.txt", sep = "\n")
cat(usia, file = "usia.txt", sep = "\n")

# Mengimpor vektor ke R
scan(file = "usia.txt", sep = "\n")
scan(file = "kelas_kata.txt", what = "char", sep = "\n")

usia <- scan(file = "usia.txt", sep = "\n")
kelas_kata <- scan(file = "kelas_kata.txt", what = "char", sep = "\n")

# coba impor file plain text berisi vektor karakter dengan nama file "syntactic_function.txt" dan simpan ke dalam objek bernama syn_func.


# Data frame (DATA DUA DIMENSI) =========
# Data frame/tabel, yaitu struktur data dua dimensi (ada BARIS dan KOLOM). Masing-masing kolom bisa berjenis data berbeda, mis. numerik, faktor, karakter, logikal. Data frame bisa dibuat di R dari sekumpulan vektor dengan jumlah komponen yang sama.

## vektor berikut akan menjadi isian kolom dari data frame/tabel
usia <- c(23, 24, 32, 40, 53) # numerik-double
sex <- factor(c("male", "female", "female", "male", "female")) # faktor
lokasi <- c("Denpasar", "Karangasem", "Denpasar", "Klungkung", "Jembrana") # karakter
apakah_tamat_pt <- c(TRUE, TRUE, TRUE, FALSE, FALSE) # logikal
pendidikan_terakhir <- c("S1", "S1", "S2", "SMA", "SMK") # karakter

# gunakan fungsi data.frame() untuk membuat data frame
partisipan <- data.frame(sex, usia, lokasi, apakah_tamat_pt, pendidikan_terakhir) # data kolom dapat diurutkan sesuai keinginan

# lihat tampilan data frame
partisipan

str(partisipan)
typeof(partisipan) # data frame merupakan sejenis "list" di R, list yang menyimpan vektor dalam bentuk tabel dua dimensi.
