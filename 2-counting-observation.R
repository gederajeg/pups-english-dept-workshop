# impor data ke R dari format plain text yang kolom-kolomnya dipisahkan oleh karakter TAB
## cara 2 - kode lebih ringkas
rob <- read.delim(file = "ROB_sample_conc_main.tsv", encoding = "UTF-8", stringsAsFactors = TRUE)

## melihat struktur data frame
str(rob)

## 'mem-print' rangkuman isi data dengan summary()
summary(rob)

# menghitung isian/nilai di dalam suatu variabel/kolom
## contoh: menghitung distribusi "animacy" partisipan TARGET dari struktur argumen ROB bahasa Inggris
##         informasi ini terdapat di dalam kolom ANIMACY_ENG_TARGET

## gunakan tanda dollar $ untuk mengakses nilai/isian dari suatu variabel/kolom
rob$ANIMACY_ENG_TARGET

## simpan isian kolom ANIMACY_ENG_TARGET ke suatu objek, misalnya dengan nama `anim_eng_target`
anim_eng_target <- rob$ANIMACY_ENG_TARGET
anim_eng_target # lihat isi dari objek ini

## sarikan distribusi di dalam suatu (atau lebih) kolom/variabel dengan fungsi table()
### sarikan distribusi isian kolom ANIMACY_ENG_TARGET yang telah disimpan ke dalam objek `anim_eng_target`
table(anim_eng_target)

## berikan nama untuk tabulasi tersebut
table(animacy_eng_target = anim_eng_target)
animacy_eng_target <- table(animacy_eng_target = anim_eng_target)
animacy_eng_target 

## hasilkan nilai proporsi dengan prop.table() (rentangan antara 0 hingga 1)
prop.table(table(animacy_eng_target = anim_eng_target))
prop.table(animacy_eng_target)

## atau ubah nilai proporsi menjadi persentase dengan mengalikannya dengan 100
prop.table(animacy_eng_target) * 100

## simpan hasil persentase ke objek bernama `perc_anim_eng_target`
perc_anim_eng_target <- prop.table(animacy_eng_target) * 100
perc_anum_eng_target # lihat isi dari objek ini

### == LATIHAN == ###
### Tahapan
#### 1. gunakan fungsi table() untuk menyarikan distribusi variabel TRANSLATION_NODE yang mengandung padanan leksikal pemakaian ROB, dan simpan hasil/luaran dari fungsi table() ke dalam objek bernama translation_node_count (lihat baris kode 18-29)
#### 2. buat nilai proporsi menggunakan prop.table() dari distribusi padanan leksikal yang telah tersimpan dalam objek translation_node_count, lalu simpan hasilnya ke dalam objek bernama translation_node_prop (lihat baris kode 31-33)
#### 3. ubah nilai dalam objek translation_node_prop menjadi persentase dengan mengalikannya dengan 100 (lihat baris kode 35), dan simpan luarannya ke objek bernama translation_node_perc
#### 4. urutkan nilai persentase dalam translation_node_perc dari besar ke kecil menggunakan fungsi sort(translation_node_perc, decreasing = TRUE), dan simpan luaran fungsi sort() tadi ke objek bernama translation_node_perc_sorted
#### 5. gunakan fungsi barplot() untuk membuat diagram batang persentase padanan leksikal dalam objek translation_node_perc_sorted




# tabulasi antara nilai/isian dari dua variabel/kolom
## ini dikenal dengan istilah tabulasi silang (crosstabulation)
## crosstabulation berguna untuk melihat distribusi suatu variabel dalam konteks variabel yang lain.
## contoh 1: bagaimana distribusi animacy peran TARGET dalam bahasa Inggris (variabel 1) terkait terjemahannya di bahasa Indonesia (variabel 2)?
## contoh 2: bagaimana distribusi tipe konstruksi verba ROB dalam bahasa Inggris (variabel 1) dan terjemahannya dalam bahasa Indonesia (variabel 2)?

## contoh 1: bagaimana distribusi animacy peran TARGET dalam bahasa Inggris (variabel 1) terkait terjemahannya di bahasa Indonesia (variabel 2)?
## variabel dalam data: ANIMACY_ENG_TARGET (variabel 1) dan ANIMACY_IDN_TARGET (variabel 2)
anim_eng_idn <- table(ENG_animacy_TARGET = rob$ANIMACY_ENG_TARGET, IDN_animacy_TARGET = rob$ANIMACY_IDN_TARGET)
anim_eng_idn

## menghitung nilai proporsi dari animacy peran TARGET di bahasa Inggris dan animacy terjemahannya di bahasa Indonesia
prop.table(anim_eng_idn, margin = 2) # margin = 2 (total proporsi kolom sama dengan 1)

## ubah nilai proporsi jadi persentase untuk animacy peran TARGET di bahasa Inggris dan animacy terjemahannya di bahasa Indonesia
prop.table(anim_eng_idn, margin = 2) * 100

### == LATIHAN == ###
## contoh 2: bagaimana distribusi tipe konstruksi verba ROB dalam bahasa Inggris (variabel 1) (kolom CXN_ENG) dan terjemahannya dalam bahasa Indonesia (variabel 2) (kolom CXN_IDN)?
### tahapan
#### 1. gunakan fungsi subset() dengan input data rob untuk menyaring kolom CXN_ENG yang BUKAN konstruksi "NOMINAL", dan simpan hasil saringan ke objek bernama rob_verbal
rob_verbal <- subset(rob, CXN_ENG != "NOMINAL")

#### 1.1. selanjutnya gunakan fungsi droplevels() dengan input rob_verbal dan simpan hasilnya kembali ke rob_verbal. Fungsi droplevels adalah untuk menghilangkan nilai dari suatu variabel yang tidak digunakan.
rob_verbal <- droplevels(rob_verbal)

#### 2. gunakan fungsi table() untuk membuat tabulasi silang konstruksi padanan verba ROB dalam bahasa Indonesia dan konstruksi verba ROB bahasa Inggris. Lihat kembali baris kode 53 sebagai contoh, lalu simpan hasilnya ke objek bernama rob_cxn_count
rob_cxn_count <- table(rob_verbal$CXN_IDN, rob_verbal$CXN_ENG)

#### 3. buatkan tabel proporsi untuk rob_cxn_count menggunakan prop.table() dengan argumen margin = 2, dan simpan luarannya ke objek bernama rob_cxn_prop
rob_cxn_prop <- prop.table(rob_cxn_count, margin = 2)

#### 4. ubah rob_cxn_prop menjadi nilai persentase dengan mengalikannya dengan 100, dan simpan luarannya ke dalam objek bernama rob_cxn_perc
rob_cxn_perc <- rob_cxn_prop * 100
