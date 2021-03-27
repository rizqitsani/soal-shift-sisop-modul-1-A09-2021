# soal-shift-sisop-modul-1-A09-2021

## Nomer 1
Source code : [Click here!](https://github.com/rizqitsani/soal-shift-sisop-modul-1-A09-2021/blob/main/soal1/)

**Deskripsi soal:**

Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan **daftar peringkat pesan error** terbanyak yang dibuat oleh ticky dan laporan **penggunaan user** pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

### 1.A
**Pembahasan:**
```bash
regex='(?<=ERROR )(.*)(?= )'
regex2='(?<=\().+?(?=\))' 
```
* Untuk regular expression yang kedua untuk mendapatkan pesan log yang ada di syslog.log, khususnya yang bertipe "ERROR"
* Untuk regular expression untuk mendapatkan username didalam ( )

### 1.B
**Pembahasan:**
```bash
error_message() {
	grep -oP "$regex" syslog.log | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' >> error_message.csv
}
```
Membuat fungsi bernama error_message() yang detailnya sebagai berikut
* `grep -oP "$regex" syslog.log` Untuk menampilkan semua pesan log
* `sort` Kemudian disort kemudian dihitung perline untuk mendapatkan jumlah kemunculan tiap error
* `uniq -c` Hitung perline untuk mendapatkan jumlah kemunculan tiap error
* `sort -nr` Mensorting number kemudian di reverse karena butuh yang terbanyak ditaruh diatas
* `sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/'` Menswap nomor yang awalnya berada didepan string menjadi dibelakang string dan diberi koma

Kemudian outputnya akan dimasukkan ke file error_message.csv

### 1.C
**Pembahasan:**
```bash
user_statistic() {
  grep -oP "$regex2" syslog.log | sort | uniq | while read i 
  do
        echo "$i" | tr '\n' ','
        grep "$i" syslog.log | grep "INFO" | wc -l | tr '\n' ','
        grep "$i" syslog.log | grep "ERROR" | wc -l 
  done >> user_statistic.csv
}
```
Membuat fungsi bernama user_statistic() yang detailnya sebagai berikut
* `grep -oP "$regex2" syslog.log` untuk mendapatkan username didalam ( )
* `sort` dari username yang sudah di grep kemudian disorting
* `uniq` kemudian dihilangkan username yang terdapat duplikat

Kemudian di looping untuk menampilkan username, jumlah "INFO", jumlah "ERROR"
* `echo "$i" | tr '\n' ','` Untuk menampilkan username kemudian untuk newline diganti menjadi koma
* `grep "$i" syslog.log | grep "INFO" | wc -l | tr '\n' ','` Untuk menampilkan jumlah "INFO" tiap user, dengan mengambil baris yang mengandung kata-kata "INFO" dan kemudian di hitung berapa banyak baris menggunakan `wc -l` dan newlinenya `\n` di ganti menjadi koma menggunakan command `tr '\n' ','`
* `grep "$i" syslog.log | grep "INFO" | wc -l` , Untuk menampilkan jumlah "ERROR" tiap user, dengan mengambil baris yang mengandung kata-kata "ERROR" dan kemudian di hitung berapa banyak baris menggunakan `wc -l` dan newlinenya `\n` di ganti menjadi koma menggunakan command `tr '\n' ','`

Kemudian outputnya akan dimasukkan ke file user_statistic.csv

### 1.D
**Pembahasan:**
```bash
echo "Error,Count" > error_message.csv
error_message
```
Pertama print "Error,Count" untuk menjadi header dari error_message.csv kemudian memanggil fungsi error_message()

### 1.E
**Pembahasan:**
```bash
echo "Username,INFO,ERROR" > user_statistic.csv
user_statistic
```
Pertama print "Username,INFO,ERROR" untuk menjadi header dari user_statistic.csv kemudian memanggil fungsi user_statistic()

### Problem yang dialami:
* Belum terbiasa dengan syntax bash yang sedikit berbeda dengan bahasa pemrograman yang telah diajarkan di semester-semester lalu sehingga saat melakukan programming sedikit terhambat dikarenakan harus searching terlebih dahulu
* Dari soal tersebut disuruh untuk membuat regex sedangkan kami tidak memiliki ilmu apapun mengenai regex atau yang biasa disebut dengan regular expression, oleh karena itu saat mengerjakan soal nomer 1 harus mencari-cari di google dan mengetest regex tersebut di [RegExr](https://regexr.com/) agar bisa sesuai dengan output yang diminta
* Untuk soal 1.B saya menggunakan sed untuk menswap angka yang berada di depan menjadi di belakang dengan diberi koma. Untuk sed sendiri saya juga masih minim ilmu untuk menggunakan itu dan harus juga untuk membuat dan mengetest [disini](https://sed.js.org/index.html) agar sesuai dengan output yang diminta
* Kemudian untuk soal yang 1C, hampir saja codingan yang saya buat mendekati output yang diinginkan. Kurang lebih hasil codingnya seperti ini
```bash
listerror="grep 'ERROR' syslog.log | grep -oP '(?<=\().+?(?=\))' | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1,/' | sort"
listinfo="grep 'INFO' syslog.log | grep -oP '(?<=\().+?(?=\))' | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' | sort | grep -oP '\\d+'" 
eksekusi="paste <(${listerror}) <(${listinfo}) >> user_statistic.csv"

eval "$eksekusi"
```
Namun ketika ada user yang tidak ada log INFO / ERROR, maka outputnya adalah null / kosong sedangkan yang diminta jika tidak terdapat log ditulis 0, karena tidak sesuai output saya harus bersusah payah lagi membuat codingan baru agar sesuai output

## Nomer 2
Source code : [Click here!](https://github.com/rizqitsani/soal-shift-sisop-modul-1-A09-2021/blob/main/soal2/)

**Deskripsi soal:**

Steven dan Manis mendirikan sebuah *startup* bernama “TokoShiSop”. Sedangkan kamu dan Clemong adalah karyawan pertama dari TokoShiSop. Setelah tiga tahun bekerja, Clemong diangkat menjadi manajer penjualan TokoShiSop, sedangkan kamu menjadi kepala gudang yang mengatur keluar masuknya barang.

Tiap tahunnya, TokoShiSop mengadakan Rapat Kerja yang membahas bagaimana hasil penjualan dan strategi kedepannya yang akan diterapkan. Kamu sudah sangat menyiapkan sangat matang untuk raker tahun ini. Tetapi tiba-tiba, Steven, Manis, dan Clemong meminta kamu untuk mencari beberapa kesimpulan dari data penjualan *“Laporan-TokoShiSop.tsv”*.

### 2.A
**Pembahasan:**

### 2.B
**Pembahasan:**

### 2.C
**Pembahasan:**

### 2.D
**Pembahasan:**

### Problem yang dialami:

## Nomer 3
Source code : [Click here!](https://github.com/rizqitsani/soal-shift-sisop-modul-1-A09-2021/blob/main/soal3/)

**Deskripsi soal:**

Kuuhaku adalah orang yang sangat suka mengoleksi foto-foto digital, namun Kuuhaku juga merupakan seorang yang pemalas sehingga ia tidak ingin repot-repot mencari foto, selain itu ia juga seorang pemalu, sehingga ia tidak ingin ada orang yang melihat koleksinya tersebut, sayangnya ia memiliki teman bernama Steven yang memiliki rasa kepo yang luar biasa. Kuuhaku pun memiliki ide agar Steven tidak bisa melihat koleksinya, serta untuk mempermudah hidupnya, yaitu dengan meminta bantuan kalian. Idenya adalah :

### 3.A
**Pembahasan:**

### 3.B
**Pembahasan:**
```
0 20 1-31/7,2-31/4 * * bash ~/soal3b.sh
```
Crontab yang memungkinkan untuk menjalankan file `soal3b.sh` saat jam 8 malam dari tanggal 1 (7 hari sekali) dan dari tanggal 2 (4 hari sekali)

### 3.C
**Pembahasan:**

### 3.D
**Pembahasan:**

### 3.E
**Pembahasan:**
```
0 7 * * 1-5 bash ~/soal3d.sh
0 18 * * 1-5 unzip Koleksi.zip && rm Koleksi.zip
```
Terdapat 2 crontab
* Yang pertama yaitu menjalankan file bash setiap jam 7 pagi, didalam file bash tersebut terdapat perintah untuk menzip file
* Yang kedua yaitu untuk menunzip file bernama `Koleksi.zip` dan setelah di unzip kemudian dihapus dengan perintah `rm`

### Problem yang dialami:
* Saat membuat crontab, belum terbiasa dengan membuat crontab khususnya untuk nomor 3B. Saat pertama membuat crontab nomor 3B saya menggunakan `0 20 1/7,2/4 * *` awalnya namun terdapat warning yang saya cek di website [Crontab.guru](https://crontab.guru/#0_20_1/7,2/4_*_*) dan setelah searching cukup lama dan ternyata lebih baik jika diberi interval harinya dari yang awalnya `1/7,2/4` menjadi `1-31/7,2-31/4`
