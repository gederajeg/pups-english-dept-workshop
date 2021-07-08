# impor data ke R dari format plain text yang kolom-kolomnya dipisahkan oleh karakter TAB
## cara 1 - kode lebih panjang
rob <- read.table(file = "ROB_sample_conc_main.tsv", header = TRUE, sep = "\t", comment.char = "", quote = "", stringsAsFactors = TRUE)
## cara 2 - kode lebih ringkas
rob <- read.delim(file = "ROB_sample_conc_main.tsv", encoding = "UTF-8", stringsAsFactors = TRUE)

# melihat struktur data frame
str(rob)
# 'data.frame':	135 obs. of  36 variables

# menyarikan informasi dalam data frame
summary(rob)

# ==================== #

# mengakses sebagian dari isi data frame (mis. baris ataupun kolom tertentu)
## mengakses enam baris teratas
head(rob)

## mengakses 10 baris teratas
head(rob, n = 10)

## mengakses enam baris terakhir
tail(rob)

## mengakses 10 baris terakhir
tail(rob, n = 10)

## mengakses baris tertentu (mis. hanya baris no. 2, 3, 5) dan mempertahankan semua kolom
baris_target <- c(2, 3, 5)
rob[baris_target, ]

## mengakses baris yang BUKAN baris tertentu (mis. mengakses baris yang BUKAN baris no. 2, 3, 5)
rob[-baris_target, ]

## mengakses kolom tertentu (mis. hanya kolom no. 2, 3, 4, 5, 7, 8, 9) dan mengikutkan semua baris
kolom_target <- c(2, 3, 4, 5, 7, 8, 9)
# atau
kolom_target <- c(2:5, 7:9)
rob[ , kolom_target]

## mengakses kolom dan baris tertentu (mis. hanya kolom no. 2, 3, 4, 5, 7, 8, 9 dan baris no. 4, 8, 10, 15)
baris_target <- c(4, 8, 10, 15)
kolom_target <- c(2, 3, 4, 5, 7, 8, 9)
rob[baris_target, kolom_target]

## kita bisa mengakses kolom dengan nama kolom!
kolom_target <- c("LEFT", "NODE", "RIGHT", "TRANSLATION", "CXN_ENG")
baris_target <- c(4, 8, 10, 15)
rob[baris_target, kolom_target]

### == LATIHAN == ###

# ==================== #

# mengakses sebagian dari data frame berdasarkan kondisi tertentu (mis. berdasarkan nilai/isi dari kolom[-kolom] tertentu)
## kita perlu tahu isi dari data frame kita
## contoh: saring data frame di mana tipe diatesis (voice) bahasa Inggrisnya adalah aktif.
##         Di data ini, informasi diatesis bahasa Inggris ada di kolom VOICE_ENG; diatesis aktif dilabeli dengan "AV".
subset(rob, VOICE_ENG == "AV")

## simpan saringan ke object untuk bisa digunakan lebih lanjut
rob_av <- subset(rob, VOICE_ENG == "AV")

## hitung jumlah observasi/data/baris di mana diatesis dari lemma ROB adalah diatesis aktif
nrow(rob_av)

## contoh: saring data frame di mana tipe diatesis (voice) bahasa Inggrisnya adalah BUKAN aktif.
##         Untuk menyatakan BUKAN atau TIDAK SAMA DENGAN, gunakan !=
rob_not_av <- subset(rob, VOICE_ENG != "AV")

## hitung jumlah observasi/data/baris di mana diatesis dari lemma ROB adalah BUKAN diatesis aktif
nrow(rob_not_av)

## menggabungkan jumlah observasi suatu kondisi untuk diolah lebih lanjut, misalnya untuk visualisasi
## contoh, menggabungkan jumlah data untuk diatesis aktif dan NON-aktif untuk ROB
count_rob_av <- nrow(rob_av)
count_rob_av
count_rob_not_av <- nrow(rob_not_av)
count_rob_not_av
count_rob_voice <- c(AV = count_rob_av, NOT_AV = count_rob_not_av)
count_rob_voice

## buatkan diagram batang (barplot) untuk distribusi diatesis ROB di bahasa Inggris dengan data dalam count_rob_voice
barplot(count_rob_voice)

## berikan label dan judul dalam barplot; ubah warna barplot (https://www.datanovia.com/en/blog/awesome-list-of-657-r-color-names/)
barplot(count_rob_voice, main = "Active and non-active voice of ROB", xlab = "voice", ylab = "token frequency", col = "pink")

# mengakses sebagian dari data frame berdasarkan lebih dari satu kondisi
## contoh: saring data frame di mana tipe diatesis (voice) bahasa Inggrisnya adalah aktif DAN diatesis bahasa Indonesia BUKAN aktif
##         di dalam data, diatesis bahasa Indonesia ada dalam kolom VOICE_IDN
##         kita bisa gunakan & untuk menggabungkan dua kondisi di dalam fungsi subset()
subset(rob, VOICE_ENG == "AV" & VOICE_IDN != "AV")
## hasil: terdapat empat kemunculan/baris di mana ROB dalam bentuk aktif diterjemahkan tidak ke dalam bentuk aktif di bahasa Indonesia

### == LATIHAN == ###
### Tahapan
#### 1. saring dan simpan data di mana diatesis ROB bahasa Inggris adalah diatesis aktif DAN diatesis terjemahan ROB di BI adalah diatesis aktif; simpan hasil saringan ke objek bernama idn_av_df
#### 2. hitung menggunakan nrow() jumlah observasi/data/baris yang sesuai dengan kondisi pada tahap 1.
#### 3. simpan luaran dari nrow() pada tahap dua ke objek bernama eng_av_idn_av
#### 4. saring dan simpan data di mana diatesis ROB bahasa Inggris adalah diatesis aktif DAN diatesis terjemahan ROB di BI adalah BUKAN diatesis aktif; simpan hasil saringan ke objek bernama idn_not_av_df
#### 5. hitung menggunakan nrow() jumlah observasi/data/baris yang sesuai dengan kondisi pada tahap 4.
#### 6. simpan luaran dari nrow() pada tahap dua ke objek bernama eng_av_idn_not_av
#### 7. gabungkan data (menggunakan fungsi c()) eng_av_idn_av dan eng_av_idn_not_av dan simpan ke objek dengan nama count_voice_translation (lihat kode di baris 81)
#### 8. buatkan barplot dengan input data dari count_voice_translation

### JAWABAN ###
### Tahapan
#### 1. saring dan simpan data di mana diatesis ROB bahasa Inggris adalah diatesis aktif DAN diatesis terjemahan ROB di BI adalah diatesis aktif; simpan hasil saringan ke objek bernama idn_av_df
idn_av_df <- subset(rob, VOICE_ENG == "AV" & VOICE_IDN == "AV")

#### 2. hitung menggunakan nrow() jumlah observasi/data/baris yang sesuai dengan kondisi pada tahap 1.
#### 3. simpan luaran dari nrow() pada tahap dua ke objek bernama eng_av_idn_av
eng_av_idn_av <- nrow(idn_av_df)

#### 4. saring dan simpan data di mana diatesis ROB bahasa Inggris adalah diatesis aktif DAN diatesis terjemahan ROB di BI adalah BUKAN diatesis aktif; simpan hasil saringan ke objek bernama idn_not_av_df
idn_not_av_df <- subset(rob, VOICE_ENG == "AV" & VOICE_IDN != "AV")

#### 5. hitung menggunakan nrow() jumlah observasi/data/baris yang sesuai dengan kondisi pada tahap 4.
#### 6. simpan luaran dari nrow() pada tahap dua ke objek bernama eng_av_idn_not_av
eng_av_idn_not_av <- nrow(idn_not_av_df)

#### 7. gabungkan data (menggunakan fungsi c()) eng_av_idn_av dan eng_av_idn_not_av dan simpan ke objek dengan nama count_voice_translation (lihat kode di baris 81)
count_voice_translation <- c(AV = eng_av_idn_av, NOT_AV = eng_av_idn_not_av)

#### 8. buatkan barplot dengan input data dari count_voice_translation
barplot(count_voice_translation)
barplot(count_voice_translation, main = "Voice types of the Indonesian translation of AV ROB", xlab = "voice", ylab = "token frequency", col = "goldenrod1")
###### Conclusion: the use of the English lemma ROB in active voice is predominantly maintained in its Indonesian translations, rather than switched into different voice in the translation.
# ==================== #




