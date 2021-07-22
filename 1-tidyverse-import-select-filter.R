# load package tidyverse dengan fungsi library()
library(tidyverse)

# atau load satu per satu package di dalam the tidyverse yang relevan untuk bagian kali ini.
library(dplyr)
library(readr)
library(tibble)

# Impor data ===========
## impor data dengan read.delim()
rob <- read.delim(file = "ROB_sample_conc_main.tsv", encoding = "UTF-8", stringsAsFactors = TRUE)
rob
# :( terlalu panjang menampilkan isi tabel

## ubah tabel rob dalam format `tibble` (dengan fungsi as_tibble()) untuk keterbacaan yang lebih informatif dan bersahabat
rob <- as_tibble(rob)
rob
# :) looks great!

# Menyarikan informasi ========
## menyarikan informasi dalam tabel dengan summary()
summary(rob)

# Mengakses kolom dalam tabel ========

## akses kolom dalam tabel data frame dengan tanda dolar $; kolom yang diakses akan menjadi vektor
### akses isian dari kolom LEX_ENG_TARGET (kata pengisi partisipan TARGET dari ROB)
rob$LEX_ENG_TARGET

### kita bisa simpan hasil akses kolom ke objek untuk kegunaan/operasi lebih lanjut nanti
lex_eng_target <- rob$LEX_ENG_TARGET

## akses/memilih sebagian kolom dengan select(); kolom yang diakses akan tetap menjadi data frame/tibble
### akses kolom LEX_ENG_TARGET
select(rob, LEX_ENG_TARGET)

### akses kolom TRANSLATION_NODE
select(rob, TRANSLATION_NODE)

### akses kolom TRANSLATION NODE menggunakan indeks nomor kolom (kita perlu tahu lebih awal)
select(rob, 7)

### mengesampingkan (i.e. exclude) suatu kolom dengan tanda minus sebelum nama kolom
select(rob, -INCLUSION)

### akses lebih dari satu kolom
select(rob, NODE, TRANSLATION_NODE)

### akses lebih dari satu kolom menggunakan indeks nomor kolom (kita perlu tahu lebih awal)
select(rob, 3, 7)

### mengesampingkan lebih dari satu kolom
select(rob, -INCLUSION, -CASES, -TRANSLATION_NODE)

# Pipe `%>%` ==========
## gunakan pipe %>% untuk merangkaikan lebih dari satu operasi/fungsi untuk keterbacaan kode
## shortcut untuk menghasilkan Pipe adalah CTRL+SHIFT+M (Windows) atau COMMAND+SHIFT+M (macOS)
### akses kolom NODE, TRANSLATIO_NODE
rob %>% select(TRANSLATION_NODE)
rob %>% select(7)

rob %>% select(NODE, TRANSLATION_NODE)
rob %>% select(3, 7)

### simpan hasil ke objek (tanda panah ke kiri "<-" mengindikasikan penyimpanan hasil operasi di sebelah kanan)
equiv <- rob %>% select(NODE, TRANSLATION_NODE)
equiv
summary(equiv)

### gabungkan dua operasi dengan pipe
#### alternatif 1 - melebar ke samping
rob %>% select(NODE, TRANSLATION_NODE) %>% summary()

#### alternatif 2 - memanjang ke bawah
rob %>%
  select(NODE, TRANSLATION_NODE) %>% 
  summary()

#### simpan hasil operasi ke objek
node_equiv <- rob %>%
  select(NODE, TRANSLATION_NODE) %>% 
  summary()
node_equiv

### LATIHAN (1) ==========
# 1. gunakan select() untuk mengakses/memilih dua kolom berikut dari data rob:
#    - LEX_IDN_TARGET - data terkait unsur leksikal (LEX) padanan bahasa Indonesia (IDN) yang mengisi slot partisipan TARGET dalam struktur argumen ROB
#    - TYPE_IDN_TARGET - kategorisasi tipe semantis dari unsur leksikal pengisi slot partisipan TARGET 
# 2. simpan operasi pada (1) ke objek bernama rob_target_lextype
# 3. jalankan fungsi summary terhadap objek rob_target_lextype
# 4. tipe semantis mana yang paling tinggi frekuensinya? source? victim?
# 5. kata/unsur leksikal apa yang paling sering menjadi TARGET dari padanan ROB di BI?

### LATIHAN (1.1) ==========
# 1. gunakan select() untuk mengakses/memilih dua kolom berikut dari data rob:
#    - N_WORD_ENG - data terkait jumlah kata dalam kalimat bahasa sumber (BIng)
#    - N_WORD_IDN - data terkait jumlah kata dalam kalimat bahasa target (BI)
# 2. simpan operasi pada (1) ke objek bernama rob_word_count
# 3. jalankan fungsi summary terhadap objek rob_word_count
# 4. bahasa mana yang rata-rata kalimatnya memiliki jumlah kata lebih banyak?

# ============================== #

# Mengakses kolom yang mengandung karakter tertentu ================
## akses kolom yang diawali dengan karakter tertentu menggunakan starts_with(), yang harus muncul di dalam select()
rob %>% select(starts_with("SYN"))

## akses kolom yang diakhiri dengan karakter tertentu menggunakan ends_with(), yang harus muncul di dalam select()
rob %>% select(ends_with("TARGET"))

## akses kolom yang sesuai dengan karakter tertentu menggunakan matches(), yang harus muncul di dalam select()
rob %>% select(matches("_ENG_"))

## gabungkan cara mengakses kolom dengan nama kolom dan sebagian karakter
## pilih kolom TRANSLATION dan kolom lainnya yang mengandung karakter "_IDN_" di namanya.
rob %>% select(TRANSLATION, matches("_IDN_"))

### LATIHAN (2) =============
# 1. gunakan kombinasi select() dan matches() untuk mengakses kolom yang mengandung "CXN" (konstruksi)
# 2. simpan ke objek bernama rob_cxn
# 3. jalankan fungsi summary() terhadap objek rob_cxn
# 4. laporkan observasi yang diamati dari luaran summary()
# 4.1 tipe konstruksi mana yang frekuensinya tinggi untuk ROB di bahasa Inggris dan padanannya di bahasa Indonesia?

# Menyaring observasi/baris ============
## Pemrosesan data yang lumrah dilakukan adalah menyaring observasi (dengan fungsi filter()) untuk suatu variabel/kolom berdasarkan kondisi tertentu. Misalnya, dari data rob, saring/filter baris/observasi di mana tipe semantis dari partisipan target bahasa Indonesia (kolom TYPE_IDN_TARGET) adalah/SAMA DENGAN (yaitu ==) "victim".
rob %>% 
  filter(TYPE_IDN_TARGET == "victim")

## Saring baris/observasi di mana tipe semantis partisipan target bahasa Indonesia BUKAN/TIDAK SAMA DENGAN (yaitu != ) "victim"
rob %>% 
  filter(TYPE_IDN_TARGET != "victim")

## Saring baris/observasi di mana kalimat bahasa sumber (BIng) (dalam kolom N_WORD_ENG) memiliki jumlah kata yang lebih besar (yaitu tanda > ) dari 15 kata. Berapa jumlah kalimat BIng yang memiliki jumlah kata melebihi 15 kata?
rob %>% 
  filter(N_WORD_ENG > 15)

## Saring baris/observasi di mana kalimat bahasa sumber (BIng) (dalam kolom N_WORD_ENG) memiliki jumlah kata yang lebih besar ATAU SAMA DENGAN (yaitu tanda >= ) dari 15 kata, DAN di mana kalimat padanannya (N_WORD_IDN) memiliki jumlah kata kurang/lebih kecil ( < ) dari 15 kata.
rob %>% 
  filter(N_WORD_ENG >= 15, N_WORD_IDN < 15)

### SHORT PRACTICE
## Saring baris/observasi di mana kalimat bahasa sumber (BIng) (dalam kolom N_WORD_ENG) memiliki jumlah kata yang lebih kecil dari 15 kata. Berapa jumlah kalimat BIng yang memiliki jumlah kata kurang 15 kata?


## Menyaring untuk lebih dari satu kondisi gunakan %n% c(...)
## Saring tipe klausa ROB bahasa Inggris berjenis klausa imperative dan interrogative
rob %>% 
  filter(CLAUSE_TYPE_ENG %in% c("imperative", "interrogative"))

## Cara menegasi kondisi yang lebih dari satu
## Saring tipe klausa ROB bahasa Inggris yang BUKAN klausa imperative dan interrogative
rob %>% 
  filter(!CLAUSE_TYPE_ENG %in% c("imperative", "interrogative"))

## Menyaring observasi di suatu kolom yang BUKAN `NA`
### lihat contoh apa yang dimaksud dengan NA
rob %>% 
  select(starts_with("SYN"))

### menyaring observasi yang BUKAN (!) `NA` (is.na()) pada kolom SYN_ENG_TARGET (fungsi sintaksis partisipan TARGET)
rob %>% 
  filter(!is.na(SYN_ENG_TARGET))

### menyaring observasi yang ADALAH `NA` (is.na()) pada kolom SYN_ENG_TARGET (fungsi sintaksis partisipan TARGET)
rob %>% 
  filter(is.na(SYN_ENG_TARGET))

### gabungkan operasi dengan fungsi lain seperti select() dan summary()
rob %>% 
  filter(!is.na(SYN_ENG_TARGET)) %>% 
  select(matches("SYN")) %>% 
  summary()

### bandingkan luaran summary() dari kode berikut yang tidak mengandung filter()
rob %>% 
  select(matches("SYN")) %>% 
  summary()

### LATIHAN (3) ================
## gabungkan operasi berikut (filter() dan select()) menggunakan pipe ( %>% )
# 1. Dari data rob, gunakan filter() untuk menyaring observasi dalam kolom ANIMACY_ENG_THIEF adalah "animate".
# 2. lanjutkan dengan pipe untuk memilih kolom TRANSLATION dan semua kolom yang mengandung karakter "_ENG_THIEF" di namanya.
# 3. simpan luarannya dalam objek bernama rob_thief_animate
# 4. jalankan fungsi summary() dengan input rob_thief_animate
# 5. perhatikan luaran summary() utamanya pada kolom/variabel berikut:
#    - SYN_ENG_THIEF (fungsi sintaksis partisipan Agen/Thief dalam kalimat)
#    - LEX_ENG_THIEF (unsur leksikal pengisi slot partisipan Agen/Thief dalam struktur argumen ROB)
# 6. dari luaran untuk variabel tersebut, laporkan pengamatan kualitatif terhadap variabel tersebut (mis. tipe leksikal pengisi partisipan THIEF, etc.; tipe mana yang paling dominan/tinggi frekuensi kemunculan/pemakaiannya dalam data)

### LATIHAN (4) ================
## pertanyaan penelitian: 
## 1. Apa saja tipe padanan bahasa Indonesia dari "you" ketika "you" muncul sebagai partisipan Agen/THIEF untuk ROB?
## 2. Tipe padanan mana yang paling sering muncul
## brainstorm tahapan yang perlu dilakukan

### LATIHAN (5) ================
## pertanyaan penelitian: 
## 1. Apa saja tipe padanan bahasa Indonesia dari "I" ketika "I" muncul sebagai partisipan Agen/THIEF untuk ROB?
## 2. Tipe padanan mana yang paling sering muncul
## brainstorm tahapan yang perlu dilakukan

### LATIHAN (6) ================
## pertanyaan penelitian: 
## 1. Apa saja tipe padanan bahasa Indonesia dari "we" ketika "we" muncul sebagai partisipan Agen/THIEF untuk ROB?
## 2. Tipe padanan mana yang paling sering muncul
## brainstorm tahapan yang perlu dilakukan








### JAWABAN LATIHAN (1) ==========
# 1. gunakan select() untuk mengakses/memilih dua kolom berikut dari data rob:
#    - LEX_IDN_TARGET - data terkait unsur leksikal (LEX) padanan bahasa Indonesia (IDN) yang mengisi slot partisipan TARGET dalam struktur argumen ROB
#    - TYPE_IDN_TARGET - kategorisasi tipe semantis dari unsur leksikal pengisi slot partisipan TARGET 
# 2. simpan operasi pada (1) ke objek bernama rob_target_lextype
rob_target_lextype <- rob %>% 
  select(LEX_IDN_TARGET, TYPE_IDN_TARGET)
# 3. jalankan fungsi summary terhadap objek rob_target_lextype
summary(rob_target_lextype)
# 4. tipe semantis mana yang paling tinggi frekuensinya? source? victim?
# 5. kata/unsur leksikal apa yang paling sering menjadi TARGET dari padanan ROB di BI?

### JAWABAN LATIHAN (1.1) ==========
# 1. gunakan select() untuk mengakses/memilih dua kolom berikut dari data rob:
#    - N_WORD_ENG - data terkait jumlah kata dalam kalimat bahasa sumber (BIng)
#    - N_WORD_IDN - data terkait jumlah kata dalam kalimat bahasa target (BI)
# 2. simpan operasi pada (1) ke objek bernama rob_word_count
rob_word_count <- rob %>% 
  select(N_WORD_ENG, N_WORD_IDN)
# 3. jalankan fungsi summary terhadap objek rob_word_count
summary(rob_word_count)
# 4. bahasa mana yang rata-rata kalimatnya memiliki jumlah kata lebih banyak?


### JAWABAN LATIHAN (2) =============
# 1. dari data rob, gunakan kombinasi select() dan matches() untuk mengakses kolom yang mengandung "CXN" (konstruksi)
# 2. simpan ke objek bernama rob_cxn
rob_cxn <- rob %>% 
  select(matches("CXN"))
# 3. jalankan fungsi summary() terhadap objek rob_cxn
summary(rob_cxn)
# 4. laporkan observasi yang diamati dari luaran summary()
# 4.1 tipe konstruksi mana yang frekuensinya tinggi untuk ROB di bahasa Inggris dan padanannya di bahasa Indonesia?

### JAWABAN LATIHAN (3) ================
## gabungkan operasi berikut (filter() dan select()) menggunakan pipe ( %>% )
# 1. Dari data rob, gunakan filter() untuk menyaring observasi dalam kolom ANIMACY_ENG_THIEF adalah "animate".
# 2. lanjutkan dengan pipe untuk memilih kolom TRANSLATION dan semua kolom yang mengandung karakter "_ENG_THIEF" di namanya.
# 3. simpan luarannya dalam objek bernama rob_thief_animate
rob_thief_animate <- rob %>% 
  filter(ANIMACY_ENG_THIEF == "animate") %>% 
  select(TRANSLATION, matches("_ENG_THIEF"))
# 4. jalankan fungsi summary() dengan input rob_thief_animate
summary(rob_thief_animate)
# 5. perhatikan luaran summary() utamanya pada kolom/variabel berikut:
#    - SYN_ENG_THIEF (fungsi sintaksis partisipan Agen/Thief dalam kalimat)
#    - LEX_ENG_THIEF (unsur leksikal pengisi slot partisipan Agen/Thief dalam struktur argumen ROB)
# 6. dari luaran untuk variabel tersebut, laporkan pengamatan kualitatif terhadap variabel tersebut (mis. tipe leksikal pengisi partisipan THIEF, etc.; tipe mana yang paling dominan/tinggi frekuensi kemunculan/pemakaiannya dalam data)

### JAWABAN LATIHAN (4) ================
## pertanyaan penelitian: 
## 1. Apa saja tipe padanan bahasa Indonesia dari "you" ketika "you" muncul sebagai partisipan Agen/THIEF untuk ROB?
## 2. Tipe padanan mana yang paling sering muncul
## brainstorm tahapan yang perlu dilakukan
rob %>% 
  filter(LEX_ENG_THIEF == "you") %>% 
  select(LEX_IDN_THIEF) %>% 
  summary()








