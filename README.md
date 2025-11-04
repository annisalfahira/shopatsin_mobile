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
