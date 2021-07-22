# load package tidyverse dengan fungsi library()
library(tidyverse)

# jika library(tidyverse) gagal, load satu per satu package di dalam the tidyverse yang relevan untuk bagian kali ini.
library(dplyr)
library(readr)
library(tibble)
library(ggplot2)

# load data
rob <- read.delim(file = "ROB_sample_conc_main.tsv", encoding = "UTF-8", stringsAsFactors = TRUE)
rob <- as_tibble(rob)

# DIAGRAM BATANG (Barplot)

# skema fungsi ggplot2 untuk visualisasi:
## 1. data frame - DATA
## 2. aestetik yang dipetakan dalam grafik/plot (aksis-y dan aksis-x, warna, ukuran, bentuk) - AES(THETIC MAPPINGS)
## 3. objek geometris yang mencerminkan data (mis. batang, titik, garis, etc.) - GEOM_FUNCTION

## ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

## contoh 
### ggplot(data = <DATA>)
ggplot(data = rob) # belum terjadi apa-apa, hanya menyiapkan kanvas.

### ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))
ggplot(data = rob) + geom_bar(mapping = aes(x = CXN_ENG))

### pemetaan aestetik bisa langsung dilakukan juga umumnya dalam ggplot()
ggplot(data = rob, mapping = aes(x = CXN_ENG)) + geom_bar()

### fungsi ggplot di atas bisa diperingkas dengan efek yang sama
ggplot(rob, aes(x = CXN_ENG)) + geom_bar()

### tampak masih ada NA dalam grafik
#### 1. coba filter out/exclude NA dari kolom CXN_ENG
#### 2. simpan hasil filter ke objek bernama rob_cxn_complete
#### 3. jalankan kembali fungsi ggplot di atas dengan data berasal dari rob_cxn_complete


### tampak masih ada NA dalam grafik
#### 1. coba filter out/exclude NA dari kolom CXN_ENG
#### 2. simpan hasil filter ke objek bernama rob_cxn_complete
rob_cxn_complete <- rob %>% filter(!is.na(CXN_ENG))

#### 3. jalankan kembali fungsi ggplot di atas dengan data berasal dari rob_cxn_complete
ggplot(rob_cxn_complete, aes(x = CXN_ENG)) + geom_bar()

### kode ggplot dapat ditata secara memanjang ke bawah
ggplot(rob_cxn_complete, aes(x = CXN_ENG)) + 
  geom_bar()

### kita bisa simpan luaran ggplot ke objek
my_first_plot <- ggplot(rob_cxn_complete, aes(x = CXN_ENG)) + 
  geom_bar()

my_first_plot

### bagaimana menyimpan luaran ggplot?
#### gunakan ggsave()
my_first_plot <- ggplot(rob_cxn_complete) + 
  geom_bar(aes(x = CXN_ENG))

ggsave(filename = "my_first_plot.png", # nama file plot yang kita inginkan
       plot = my_first_plot, # objek plot yang akan kita simpan
       width = 7, # lebar plot
       height = 6, # tinggi plot
       units = "in") # unit pengukuran lebar dan tinggi (mis. "in", "cm", atau "mm")



## bagaimana memvisualisasikan interaksi antara dua variabel kategorial? Misalnya penonjolan partisipan PENCURI (THIEF) BIng (ROLE_ENG_THIEF) dan padanannya pada bahasa Indonesia (ROLE_IDN_THIEF)?
ggplot(rob_cxn_complete, aes(x = CXN_ENG)) + 
  geom_bar(aes(fill = CXN_IDN))

## bagaimana membuat agar batangnya tidak menumpuk?
### gunakan position = "dodge"
ggplot(rob_cxn_complete, aes(x = CXN_ENG)) + 
  geom_bar(aes(fill = CXN_IDN), position = "dodge")

## tambahkan nama plot + sesuaikan label aksis-y, aksis-x, dan legenda (fill)
ggplot(rob_cxn_complete, aes(x = CXN_ENG)) + 
  geom_bar(aes(fill = CXN_IDN), position = "dodge") +
  labs(x = "Konstruksi (BIng)",
       y = "Frekuensi pengamatan",
       fill = "Konstruksi (BI)")

### coba interpretasikan grafik tersebut

### LATIHAN ###
#### Buat diagram batang dua dimensi untuk variabel terkait penonjolan partisipan PENCURI (THIEF) dari bahasa Inggris dan padanannya dalam BI. Kolom yang relevan adalah kolom ROLE_ENG_THIEF dan ROLE_IDN_THIEF.


# =========================================



### Umumnya, komputasi/analisis kuantitatif sudah dilakukan terlebih dahulu, disimpan ke dalam objek, yang kemudian menjadi input bagi ggplot2.

### contoh masih sama dengan yang di atas, namun kita menghitung terlebih dahulu (dengan count()) distribusi konstruksi ROB dalam bahasa Inggris.
rob_cxn_count <- rob %>% 
  filter(!is.na(CXN_ENG)) %>% 
  count(CXN_ENG)
rob_cxn_count

### gunakan rob_cxn_count sebagai input ggplot
#### karena kita sudah memiliki count, geom_bar() tidak bisa digunakan, namun geom_col()
#### kita petakan kolom "n" yang berisi nilai pengukuran/frekuensi ke dalam aksis-y/vertikal
#### kita petakan kolom "CXN_ENG" yang berisi nama/jenis konstruksi ke dalam aksis-x/horizontal
ggplot(rob_cxn_count) +
  geom_col(aes(x = CXN_ENG, y = n))

### bagaimana mengurutkan batang dari nilai terbesar ke terkecil? Secara default, ggplot mengurutkan aksis-x/horizontal secara alfabetis.
ggplot(rob_cxn_count) +
  geom_col(aes(x = reorder(CXN_ENG, -n), y = n))
#### bandingkan kembali dengan plot sebelumnya
ggplot(rob_cxn_count) +
  geom_col(aes(x = CXN_ENG, y = n))

### ubar isian (fill) warna batang (di luar kurung aes)
ggplot(rob_cxn_count) +
  geom_col(aes(x = CXN_ENG, y = n), fill = "cadetblue")

### tambahkan nama plot + sesuaikan label aksis-y dan aksis-x
ggplot(rob_cxn_count) +
  geom_col(aes(x = CXN_ENG, y = n), fill = "cadetblue") +
  labs(title = "Distribusi konstruksi ROB", 
       y = "Frekuensi pengamatan",
       x = "Tipe konstruksi")


### kuantifikasi awal juga bisa dilakukan untuk dua variabel layaknya CXN_ENG dan CXN_IDN yang kemudian menjadi input ggplot2
rob_cxn_eng_idn <- rob_cxn_complete %>% 
  count(CXN_ENG, CXN_IDN)

ggplot(rob_cxn_eng_idn, aes(x = CXN_ENG, y = n, fill = CXN_IDN)) +
  geom_col(position = "dodge")


# DIAGRAM PENCAR (SCATTER PLOT) - untuk variabel kuantitatif
ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_point(alpha = 1/10)


## melihat korelasi/hubungan antara dua variabel kuantitatif
## Bagaimana korelasi jumlah kata kalimat bahasa sumber ROB dengan padanannya dalam BI?
ggplot(rob, aes(x = N_WORD_ENG, y = N_WORD_IDN)) + 
  geom_point()
ggplot(rob, aes(x = N_WORD_ENG, y = N_WORD_IDN)) + 
  geom_point(alpha = 0.5) + 
  geom_jitter() # meminimalisir titik2 yang overlapping
## tampaknya berkorelasi positif: semakin banyak jumlah kata kalimat bahasa sumber, semakin banyak pula jumlah kata padanan bahasa target
## kita perlu uji statistik lanjutan! Uji korelasi
cor.test(rob$N_WORD_ENG, rob$N_WORD_IDN, method = "kendall")



# DIAGRAM PERSEGI (BOXPLOT) - untuk variabel kuantitatif

## Kita mencoba memvisualisasikan distribusi kuantitatif jumlah kata dalam kalimat BIng dan BI.
## Struktur data untuk kolom N_WORD_ENG dan N_WORD_IDN mesti diubah memanjang ke bawah
n_word_rob <- select(rob, N_WORD_ENG, N_WORD_IDN)
n_word_rob
colnames(n_word_rob) <- c("ENG", "IDN")
n_word_rob
n_word_rob_long <- pivot_longer(data = n_word_rob,
                                cols = c("ENG", "IDN"),
                                names_to = "language",
                                values_to = "n_words")

## buat boxplot
ggplot(n_word_rob_long, 
       aes(x = language, y = n_words)) +
  geom_boxplot(notch = TRUE)

## tambahkan label informatif
ggplot(n_word_rob_long, 
       aes(x = language, y = n_words)) +
  geom_boxplot(notch = TRUE) +
  labs(x = "Bahasa",
       y = "Jumlah kata",
       title = "Distribusi jumlah kata kalimat ROB dalam BIng & BI")





## tambahkan tiap-tiap poin data dari tabel n_word_rob_long untuk melihat jumlah observasi dan distribusinya.
ggplot(n_word_rob_long, 
       aes(x = language, y = n_words)) +
  geom_boxplot(notch = TRUE) +
  geom_jitter(alpha = 0.5,
              colour = "tomato")

