# impor data ke R dari format plain text yang kolom-kolomnya dipisahkan oleh karakter TAB
## cara 2 - kode lebih ringkas
rob <- read.delim(file = "ROB_sample_conc_main.tsv", encoding = "UTF-8", stringsAsFactors = TRUE)

# barplot distribusi tipe semantis pengisi peran TARGET (kolom TYPE_ENG_TARGET dalam data frame rob)
## 1. gunakan table() untuk menyarikan/menghitung tipe semantis TARGET untuk ROB (dalam kolom TYPE_ENG_TARGET):
eng_target_type <- table(rob$TYPE_ENG_TARGET)
eng_target_type
# TARGET yang dikategorikan sebagai source adalah lokasi sumber, sedangkan victim adalah target korban/manusia.

## 2. gunakan fungsi barplot() dengan input eng_target_type
barplot(eng_target_type)

## 3. penambahan judul dalam plot menggunakan argumen main
barplot(eng_target_type, main = "Distribution of types of TARGET role of ROB")

## 4. penambahan label aksis vertikal (aksis y) dengan argumen ylab, dan aksis horizontal (aksis x) dengan argumen xlab
barplot(eng_target_type, main = "Distribution of types of TARGET role of ROB", ylab = "Token frequency", xlab = "Types of TARGET")

## 5. merubah warna batang dalam barplot dengan argumen col
## list daftar nama warna di R dapat dilihat di http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
### semua batang berwarna sama: brown1
barplot(eng_target_type, main = "Distribution of types of TARGET role of ROB", ylab = "Token frequency", xlab = "Types of TARGET", col = "brown1") 
### masing-masing batang berwarna berbeda (masukkan nama warna sesuai dengan jumlah batang):
barplot(eng_target_type, main = "Distribution of types of TARGET role of ROB", ylab = "Token frequency", xlab = "Types of TARGET", col = c("brown1", "azure"))

