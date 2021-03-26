# soal-shift-sisop-modul-1-A09-2021

## Nomer 1
Source code : [Click here!](https://github.com/rizqitsani/soal-shift-sisop-modul-1-A09-2021/blob/main/soal1/soal1.sh)

**Deskripsi soal:**

Ryujin baru saja diterima sebagai IT support di perusahaan Bukapedia. Dia diberikan tugas untuk membuat laporan harian untuk aplikasi internal perusahaan, ticky. Terdapat 2 laporan yang harus dia buat, yaitu laporan **daftar peringkat pesan error** terbanyak yang dibuat oleh ticky dan laporan **penggunaan user** pada aplikasi ticky. Untuk membuat laporan tersebut, Ryujin harus melakukan beberapa hal berikut:

### 1.A
**Deskripsi:**

Mengumpulkan informasi dari log aplikasi yang terdapat pada file syslog.log. Informasi yang diperlukan antara lain: jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya. Karena Ryujin merasa kesulitan jika harus memeriksa satu per satu baris secara manual, dia menggunakan regex untuk mempermudah pekerjaannya. Bantulah Ryujin membuat regex tersebut.

**Pembahasan:**
```bash
regex='(ERROR |INFO)(.*)'
regex2='(?<=ERROR )(.*)(?= )'
regex3='(?<=\().+?(?=\))' 
```
* Untuk regular expression yang pertama untuk mendapatkan jenis log (ERROR/INFO), pesan log, dan username pada setiap baris lognya
* Untuk regular expression yang kedua untuk mendapatkan pesan log yang ada di syslog.log
* Untuk regular expression untuk mendapatkan username didalam ( )

### 1.B
**Deskripsi:**
Kemudian, Ryujin harus menampilkan semua pesan error yang muncul beserta jumlah kemunculannya.

**Pembahasan:**
```bash
error_message() {
	grep -oP "$regex2" syslog.log | sort | uniq -c | sort -nr | sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/' >> error_message.csv
}
```
Membuat fungsi bernama error_message() yang detailnya sebagai berikut
* *grep -oP "$regex2" syslog.log*, untuk menampilkan semua pesan log
* *sort | uniq -c*, disort kemudian dihitung perline untuk mendapatkan jumlah kemunculan tiap error
* *sort -nr*, Mensorting number kemudian di reverse karena butuh yang terbanyak ditaruh diatas
* *sed 's/^  *\([0-9]*\) *\(.*\)/\2,\1/'*, untuk menswap nomor yang awalnya berada didepan string menjadi dibelakang string dan diberi koma
Kemudian outputnya akan dimasukkan ke file error_message.csv

### 1.C
**Deskripsi:**
Ryujin juga harus dapat menampilkan jumlah kemunculan log ERROR dan INFO untuk setiap user-nya.

**Pembahasan:**
```bash
user_statistic() {
  grep -oP "$regex3" syslog.log | sort | uniq | while read i 
  do
        echo "$i" | tr '\n' ','
        grep "$i" syslog.log | grep "INFO" | wc -l | tr '\n' ','
        grep "$i" syslog.log | grep "ERROR" | wc -l 
  done >> user_statistic.csv
}
```
Membuat fungsi bernama user_statistic() yang detailnya sebagai berikut
* *grep -oP "$regex3" syslog.log*, untuk mendapatkan username didalam ( )
* *sort | uniq*, disort kemudian dihilangkan username yang terdapat duplikate

Kemudian di looping untuk menampilkan username, jumlah "INFO", jumlah "ERROR"
* Untuk *echo "$i" | tr '\n' ','* , Untuk menampilkan username kemudian untuk newline diganti menjadi koma
* *grep "$i" syslog.log | grep "INFO" | wc -l | tr '\n' ','* , Untuk menampilkan jumlah "INFO" tiap user
* *grep "$i" syslog.log | grep "INFO" | wc -l* , Untuk menampilkan jumlah "ERROR" tiap user

Kemudian outputnya akan dimasukkan ke file user_statistic.csv

### 1.D
**Deskripsi:**
Semua informasi yang didapatkan pada poin b dituliskan ke dalam file error_message.csv dengan header Error,Count yang kemudian diikuti oleh daftar pesan error dan jumlah kemunculannya diurutkan berdasarkan jumlah kemunculan pesan error dari yang terbanyak.

**Pembahasan:**
```bash
echo "Error, Count" > error_message.csv
error_message
```
Pertama print "Error, Count" untuk menjadi header dari error_message.csv kemudian memanggil fungsi error_message

### 1.E
**Deskripsi:**
Semua informasi yang didapatkan pada poin c dituliskan ke dalam file user_statistic.csv dengan header Username,INFO,ERROR diurutkan berdasarkan username secara ascending.

**Pembahasan:**
```bash
echo "Username,INFO,ERROR" > user_statistic.csv
user_statistic
```
Pertama print "Username,INFO,ERROR" untuk menjadi header dari user_statistic.csv kemudian memanggil fungsi user_statistic

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

## Nomer 3
