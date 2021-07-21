# load package tidyverse dengan fungsi library()
library(tidyverse)

# jika library(tidyverse) gagal, load satu per satu package di dalam the tidyverse yang relevan untuk bagian kali ini.
library(dplyr)
library(readr)
library(tibble)

# Impor data ===========
## impor data dengan read.delim() lalu ubah menjadi tibble dengan as_tibble()
rob <- read.delim(file = "ROB_sample_conc_main.tsv", encoding = "UTF-8", stringsAsFactors = TRUE)
rob <- as_tibble(rob)
rob

# menghitung isian/nilai di dalam suatu variabel/kolom ===========
## contoh: menghitung distribusi "animacy" partisipan TARGET dari struktur argumen ROB bahasa Inggris
##         informasi ini terdapat di dalam kolom ANIMACY_ENG_TARGET

### gunakan fungsi count()
count(rob, ANIMACY_ENG_TARGET)

# atau gunakan pipe ` %>% `
rob %>% 
  count(ANIMACY_ENG_TARGET)

### kita bisa urutkan nilai dengan menggunakan arrange()
#### bandingkan kedua kode berikut
rob %>% 
  count(ANIMACY_ENG_TARGET) # tanpa sorting

rob %>% 
  count(ANIMACY_ENG_TARGET) %>% 
  arrange(n) # dengan sorting (kecil ke besar)

rob %>% 
  count(ANIMACY_ENG_TARGET) %>% 
  arrange(desc(n)) # dengan sorting (besar ke kecil); tambahkan desc()


### simpan luaran count
anim_eng_target_count <- rob %>% 
  count(ANIMACY_ENG_TARGET) %>% 
  arrange(desc(n))

anim_eng_target_count
#### terdapat NAs di kolom ANIMACY_ENG_TARGET

### LATIHAN (1) =======
#### 0. Sebelum menjalankan fungsi count(), terlebih dahulu:
#### 1. dari data "rob", exclude NA dari kolom ANIMACY_ENG_TARGET (dengan gabungan fungsi filter() dan is.na()--lihat code hari pertama),
#### 2. lalu jalankan count() terhadap kolom ANIMACY_ENG_TARGET
#### 3. lalu urutkan nilai kolom "n" dari besar ke kecil,
#### 4. lalu simpan ke dalam anim_eng_target_count_complete


### JAWABAN LATIHAN (1) =======
anim_eng_target_count_complete <- rob %>%  # step 0
  filter(!is.na(ANIMACY_ENG_TARGET)) %>%   # step 1
  count(ANIMACY_ENG_TARGET) %>%            # step 2
  arrange(desc(n))                         # step 3
anim_eng_target_count_complete

# menambahkan kolom dengan mutate() ===========
## contoh: menambahkan kolom persentase dari frekuensi "animacy" partisipan TARGET.
anim_eng_target_count <- rob %>% 
  filter(!is.na(ANIMACY_ENG_TARGET)) %>% 
  count(ANIMACY_ENG_TARGET)
anim_eng_target_count
## gunakan mutate() untuk menambahkan kolom persentase:
anim_eng_target_count %>% 
  mutate(perc = n / sum(n) * 100)

## atau sekaligus dari filter(), count(), dan mutate()
rob %>% 
  filter(!is.na(ANIMACY_ENG_TARGET)) %>% 
  count(ANIMACY_ENG_TARGET) %>% 
  mutate(perc = n / sum(n) * 100)

### LATIHAN (2) =======
#### Menghitung distribusi/frekuensi variabel bentuk padanan leksikal ROB (kolom TRANSLATION_NODE)
#### 0. dari data "rob"
#### 1. lalu hitung (i.e. count()) nilai dari variabel TRANSLATION_NODE (yang berisi padanan leksikal ROB)
#### 2. lalu urutkan (i.e. arrange()) nilai kolom "n" dari besar ke kecil (i.e. desc(n))
#### 3. lalu tambahkan kolom persentase (i.e. mutate) dengan nama "perc_equiv"
#### 4. lalu simpan luaran ke objek bernama "lex_equiv_rob" (padanan leksikal dari rob)


### JAWABAN LATIHAN (2) =======
lex_equiv_rob <- rob %>%                # step 0
  count(TRANSLATION_NODE) %>%           # step 1
  arrange(desc(n)) %>%                  # step 2
  mutate(perc_equiv = n / sum(n) * 100) # step 3
lex_equiv_rob



# menghitung distribusi nilai untuk dua variabel (co-occurrence frequency) ===========
## contoh: menghitung distribusi "animacy" partisipan TARGET dari struktur argumen ROB bahasa Inggris dan "animacy" partisipan TARGET dari struktur argumen padanan ROB dalam bahasa Indonesia.
## pertanyaan sederhananya: 
### bagaimana distribusi "animacy" TARGET dalam bahasa Indonesia ketika TARGET dalam bahasa Inggris adalah (in)animate?
rob %>% 
  count(ANIMACY_ENG_TARGET, ANIMACY_IDN_TARGET)
## masih ada NAs; kita perlu filter them out

## hilangkan NAs dari kedua variabel animacy, lalu hitung frekuensi kemunculan (co-occurrence frequency) bersama observasi dari kedua variabel.
rob %>% 
  filter(!is.na(ANIMACY_ENG_TARGET)) %>% 
  filter(!is.na(ANIMACY_IDN_TARGET)) %>% 
  count(ANIMACY_ENG_TARGET, ANIMACY_IDN_TARGET)

## menambahkan persentase berdasarkan grup.
## untuk partisipan TARGET yang "animate" dalam bahasa Inggris, berapa persen terjemahannya bersifat "animate" dan berapa persen yang bersifat "inanimate"?
## untuk partisipan TARGET yang "inanimate" dalam bahasa Inggris, berapa persen terjemahannya bersifat "animate" dan berapa persen yang bersifat "inanimate"?
### dari pertanyaan ini, persentase yang dibuat adalah berdasarkan grup (in)animacy dalam bahasa Inggris (yaitu grouping variabelnya adalah ANIMACY_ENG_TARGET).
### kita gunakan fungsi group_by() lalu mutate() + penghitungan persentase seperti sebelumnya.
### kita bandingkan persentase TANPA group_by() dan dengan group_by() untuk variabel ANIMACY_ENG_TARGET

## simpan hasil count sebelumnya ke objek bernama "anim_target_eng_idn"
anim_target_eng_idn <- rob %>% 
  filter(!is.na(ANIMACY_ENG_TARGET)) %>% 
  filter(!is.na(ANIMACY_IDN_TARGET)) %>% 
  count(ANIMACY_ENG_TARGET, ANIMACY_IDN_TARGET)
anim_target_eng_idn

## penambahan kolom persentase tanpa group_by
anim_target_eng_idn %>% 
  mutate(perc = n / sum(n) * 100)

## penambahan kolom persentase DENGAN group_by pada variabel ANIMACY_ENG_TARGET
anim_target_eng_idn %>% 
  group_by(ANIMACY_ENG_TARGET) %>% 
  mutate(perc = n / sum(n) * 100)
## depending on the RQ, you may need different percentages.
## untuk RQ penelitian ini, persentase per group yang diperlukan.
## persentase per grup ini menunjukkan bahwa terdapat proporsi kesepadanan yang tinggi
## terkait (in)animacy partisipan TARGET dari bahasa Inggris ke BI: ketika TARGET adalah animate dalam BIng, 98% data padanannya mempertahankan TARGET sebagai animate, dst.

### LATIHAN (3) =======
#### Menghitung distribusi konstruksi sintaksis/grammatikal ROB (kolom CXN_ENG) dan konstruksi padanannya dalam BI (kolom CXN_IDN)
#### 0. dari data "rob"
#### 1. lalu exclude yang BUKAN NA dari kolom CXN_ENG
#### 2. lalu exclude juga yang BUKAN NA dari kolom CXN_IDN
#### 3. lalu hitung (i.e. count()) nilai dari variabel CXN_ENG & CXN_IDN
#### 4. lalu urutkan (i.e. arrange()) secara alfabetis dari Z-A berdasarkan kolom CXN_ENG (i.e., desc(CXN_ENG)).


### JAWABAN LATIHAN (3) =======
rob %>%                                         # step 0
  filter(!is.na(CXN_ENG), !is.na(CXN_IDN)) %>%  # step 1 & 2
  count(CXN_ENG, CXN_IDN) %>%                   # step 3
  arrange(desc(CXN_ENG))                        # step 4




### LATIHAN (4) =======
#### Persentase konstruksi berdasarkan group.
#### Konteks & pertanyaan: dari luaran latihan 3 di atas, kita tahu terdapat sejumlah tipe konstruksi sintaksis ROB dalam BIng; secara kasat mata terlihat bahwa konstruksi ketika partisipan TARGET mengisi fungsi objek langsung (TARGET-OBJ) memiliki variasi tipe konstruksi padanan yang paling tinggi (yaitu 5 tipe konstruksi di BI). Pertanyaan: bagaimana persentase tipe konstruksi di BI dari total frekuensi konstruksi BIng TARGET-OBJEK? Terkait group_by(), variabel manakah yang menjadi grouping variabel di antara CXN_ENG dan CXN_IDN untuk menjawab pertanyaan sebelum ini?

#### 0. dari data "rob"
#### 1. lalu exclude yang BUKAN NA dari kolom CXN_ENG
#### 2. lalu exclude juga yang BUKAN NA dari kolom CXN_IDN
#### 3. lalu hitung (i.e. count()) nilai dari variabel CXN_ENG & CXN_IDN
#### 4. lalu urutkan (i.e. arrange()) secara alfabetis dari Z-A berdasarkan kolom CXN_ENG (i.e., desc(CXN_ENG)).
#### 5. lalu jadikan variabel CXN_ENG sebagai grouping variabel
#### 6. lalu tambahkan kolom perc_cxn_by_eng dan hitung persentasenya
#### 7. lalu urutkan (i.e. arrange()) kolom perc_cxn_by_eng dari persentase tertinggi
#### 8. lalu filter dari kolom CXN_ENG hanya konstruksi "TARGET-OBJ"
#### 9. lalu perhatikan distribusi persentase tipe konstruksi padanan BI untuk konstruksi BIng TARGET-OBJ; seberapa tinggi kesepadanan konstruksional ROB dalam kaitannya dengan konstruksi sumber TARGET-OBJ? Apa buktinya? Variasi apa saja yang ditemukan?

### JAWABAN LATIHAN (4) =======
rob %>%                                           # step 0
  filter(!is.na(CXN_ENG), !is.na(CXN_IDN)) %>%    # step 1 & 2
  count(CXN_ENG, CXN_IDN) %>%                     # step 3
  arrange(desc(CXN_ENG)) %>%                      # step 4
  group_by(CXN_ENG) %>%                           # step 5
  mutate(perc_cxn_by_eng = n / sum(n) * 100) %>%  # step 6
  arrange(desc(perc_cxn_by_eng)) %>%              # step 7
  filter(CXN_ENG == "TARGET-OBJ")                 # step 8
