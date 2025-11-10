# shopatsin

## tugas 7:

1. **Widget tree dan relasi parent-child**  
   Widget tree adalah struktur hierarki yang dibentuk oleh seluruh widget dalam aplikasi Flutter. Setiap node di tree merupakan sebuah widget, dan widget dapat memiliki widget lain sebagai child. Parent mengatur tata letak serta perilaku child; misalnya sebuah `Column` sebagai parent akan menata child secara vertikal. Relasi ini rekursif, sehingga perubahan di parent dapat memengaruhi bagaimana child dirender atau diatur.

2. **Widget yang digunakan beserta fungsi singkatnya**  
   - `MaterialApp`: Pembungkus utama yang menyiapkan konfigurasi material design, tema, dan navigasi.  
   - `ThemeData` dan `ColorScheme`: Menentukan palet warna aplikasi dan preferensi gaya material 3.  
   - `MyHomePage`: Widget halaman utama yang menampilkan menu produk.  
   - `Scaffold`: Struktur dasar halaman dengan area app bar dan body.  
   - `AppBar`: Bilah atas dengan judul toko.  
   - `Padding`: Memberi jarak di sekitar konten body.  
   - `Column`: Mengatur tombol menu secara vertikal.  
   - `SizedBox`: Menyediakan spasi vertikal antar tombol.  
   - `_MenuButton` (`SizedBox` + `ElevatedButton.icon`): Komponen tombol full-width dengan ikon dan teks.  
   - `SnackBar` dan `ScaffoldMessenger`: Menampilkan pesan ketika tombol ditekan.  
   - Ikon (`Icons.sports_soccer`, `Icons.shopping_bag`, `Icons.add_circle`): Representasi visual pada tombol.

3. **Fungsi `MaterialApp` dan alasannya jadi root**  
   `MaterialApp` menyiapkan kerangka kerja material design: routing, tema, localization, dan default text direction. Widget ini sering dipakai sebagai root karena menyediakan konfigurasi global yang dibutuhkan hampir seluruh layar dan komponen material di aplikasi.

4. **Perbedaan `StatelessWidget` vs `StatefulWidget`**  
   `StatelessWidget` tidak menyimpan state internal yang berubah; cocok untuk UI statis atau hanya bergantung pada input constructor. `StatefulWidget` memiliki objek `State` untuk menyimpan data yang dapat berubah sepanjang siklus hidup widget. Pilih `StatelessWidget` ketika tampilan hanya bergantung pada data immutable, dan gunakan `StatefulWidget` saat UI bergantung pada state yang bisa berubah (mis. counter, form input dinamis).

5. **Peran `BuildContext` dan penggunaannya**  
   `BuildContext` adalah referensi ke lokasi widget dalam widget tree. Konteks ini diperlukan untuk mengakses tema, media query, navigator, atau elemen ancestor lainnya. Di dalam metode `build`, konteks diberikan sebagai parameter sehingga widget dapat membaca data dari tree (misalnya `Theme.of(context)` atau `ScaffoldMessenger.of(context)`).

6. **Hot reload vs hot restart**  
   Hot reload menyuntikkan perubahan kode ke dalam VM dan memicu rebuild widget tree tanpa menghapus state `StatefulWidget`, sehingga iterasi UI cepat. Hot restart memuat ulang aplikasi dari awal, menginisialisasi ulang state dan menjalankan kembali `main()`. Hot restart digunakan saat perubahan memengaruhi state global atau inisialisasi yang tidak diperbarui lewat hot reload saja.

## tugas 8:

1. **Navigator.push() vs Navigator.pushReplacement()**  
   `Navigator.push()` menambahkan halaman baru ke atas stack, sehingga pengguna masih bisa kembali ke halaman sebelumnya dengan tombol back. Di aplikasi Football Shop, interaksi seperti membuka halaman "Add Product" dari beranda menggunakan `Navigator.pushNamed()` agar setelah selesai mengisi form, pengguna bisa kembali ke halaman utama secara manual. `Navigator.pushReplacement()` menggantikan halaman aktif tanpa menyimpannya di stack. Ini cocok untuk alur di mana halaman lama tidak perlu dikunjungi lagi, misalnya setelah autentikasi atau ketika ingin mengganti seluruh stack dengan halaman beranda pasca checkout. Jadi, untuk navigasi reguler antar menu gunakan `push`, sedangkan untuk transisi final yang tidak membutuhkan tombol back gunakan `pushReplacement`.

2. **Memanfaatkan Scaffold, AppBar, dan Drawer**  
   `Scaffold` menjadi fondasi tiap layar sehingga struktur dasar seperti area app bar, body, dan drawer konsisten. `AppBar` menyajikan judul toko dan pewarnaan tema yang seragam, sementara `Drawer` berisi opsi "Home" dan "Add Product" sehingga pengguna memiliki akses navigasi yang sama di halaman mana pun. Dengan hierarki ini, saya cukup mendefinisikan `AppDrawer` sekali dan memasangnya pada `Scaffold` di kedua halaman (`MyHomePage` dan `AddProductPage`), sehingga pengalaman pengguna tetap konsisten tanpa mengulang kode navigasi.

3. **Kelebihan Padding, SingleChildScrollView, dan List/Grid View**  
   `Padding` memastikan setiap elemen form memiliki ruang bernapas sehingga mudah dibaca dan disentuh. `SingleChildScrollView` memungkinkan seluruh form dapat digulir ketika tinggi konten melebihi layar, penting untuk beberapa field seperti nama, harga, kategori, thumbnail, deskripsi, dan highlight agar tidak terpotong pada perangkat kecil. Untuk daftar menu utama saya menggunakan `GridView.count` agar tombol responsif terhadap lebar layar, sedangkan form memanfaatkan `Column` di dalam scroll view sehingga validasi dan urutan field lebih terkontrol. Kombinasi ini membuat antarmuka tetap rapi sekaligus adaptif terhadap ukuran layar.

4. **Penyesuaian warna tema**  
   Pada `MaterialApp`, saya membangun `ThemeData` dari `ColorScheme.fromSeed` dengan `seedColor` hijau tua (`Colors.green.shade700`). Pendekatan ini menghasilkan palet warna turunan yang otomatis konsisten di AppBar, tombol, ikon, dan komponen form tanpa harus menetapkan warna satu per satu. Dengan begitu, aplikasi Football Shop memiliki warna utama yang mengingatkan pada lapangan bola/brand toko dan memastikan seluruh widget Material mengikuti identitas visual yang sama.
