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

## Jawaban Pertanyaan Tugas 9

1. **Mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memakai Map<String, dynamic>?**  
   Model Dart dibutuhkan supaya struktur data dari backend (Django) punya “kontrak” yang jelas di sisi Flutter. Dengan membuat class seperti `ShopAtSinItem`, setiap field punya tipe yang tegas (`int price`, `String name`, `bool isFeatured`, dll) dan bisa diatur mana yang wajib (`required`) dan mana yang opsional (`String? brand`). Hal ini membantu:
   - **Validasi tipe:** kesalahan tipe (misalnya backend kirim string padahal kita expect int) akan ketahuan saat parsing di `fromJson`, bukan nyelip di tengah UI.
   - **Null-safety:** kita bisa bedakan field yang boleh null dan yang tidak, sehingga akses data lebih aman dan ramah null-safety.
   - **Maintainability:** kalau struktur JSON berubah, cukup update satu class model, bukan puluhan pemanggilan `json["..."]` di banyak file.

   Kalau langsung pakai `Map<String, dynamic>` di mana-mana, semua jadi `dynamic`:  
   - typo key (`"prcie"`), perubahan nama field, atau null value baru ketahuan saat runtime, seringnya berupa crash yang susah dilacak.  
   - kode jadi berantakan karena akses key tersebar di banyak layar.  
   Implikasinya: validasi tipe lemah, null-safety tidak maksimal, dan maintenance jangka panjang jauh lebih susah.

2. **Apa fungsi package http dan CookieRequest dalam tugas ini? Apa perbedaan perannya?**  
   - **`http`** adalah package HTTP general-purpose. Ia menyediakan `get`, `post`, dan kawan-kawan, tapi:
     - tidak menyimpan cookie/session,
     - tidak tahu apa-apa tentang Django,
     - semua header, body, dan parsing JSON harus di-handle manual.
   - **`CookieRequest`** (dari `pbp_django_auth`) dirancang khusus untuk integrasi dengan Django. Di tugas ini, `CookieRequest` dipakai untuk:
     - login ke endpoint `/flutter/login/`,
     - register ke `/flutter/register/`,
     - logout ke `/flutter/logout/`,
     - fetch data ke `/flutter/items/`.

     `CookieRequest` otomatis:
     - menyimpan dan mengirim session cookie Django di tiap request berikutnya,
     - menyimpan state `loggedIn`,
     - menyediakan helper `login`, `logout`, `get`, `postJson()`.

   Jadi perannya beda: **`http` = klien HTTP mentah**, sementara **`CookieRequest` = klien HTTP yang sudah paham session/cookie Django dan dipakai sebagai main bridge Flutter ↔ Django di tugas ini.**

3. **Mengapa instance CookieRequest perlu dibagikan ke semua komponen di aplikasi Flutter?**  
   `CookieRequest` menyimpan **state session** (cookie login, status `loggedIn`, dsb). Kalau tiap widget atau halaman membuat instance `CookieRequest` baru sendiri-sendiri, maka:
   - cookie hasil login di halaman Login tidak ikut terbawa ke halaman lain,
   - Django akan menganggap request dari halaman lain sebagai anonymous user (belum login),
   - fitur yang butuh user terautentikasi seperti filter `?filter=my` di `/flutter/items/` tidak akan jalan.

   Dengan menjadikan `CookieRequest` sebagai **satu instance global** yang dibungkus di root aplikasi menggunakan `Provider`, semua widget bisa mengakses instance yang sama lewat `context.watch<CookieRequest>()`. Ini membuat:
   - login cukup dilakukan sekali,  
   - request ke Django di semua screen memakai session yang sama,  
   - logout di drawer langsung mengosongkan session untuk seluruh aplikasi.  

   Intinya, `CookieRequest` itu “wakil” session Django di sisi Flutter, jadi wajar kalau harus dibagikan ke semua komponen.

4. **Konfigurasi konektivitas Flutter–Django dan dampaknya jika salah**  
   Agar Flutter bisa berkomunikasi dengan Django tanpa drama, beberapa konfigurasi penting adalah:

   - **`ALLOWED_HOSTS` (termasuk `10.0.2.2`)**  
     Django hanya menerima request dari host yang terdaftar.  
     - Saat pakai browser/lokal: biasanya lewat `127.0.0.1` atau `localhost`.  
     - Saat pakai Android emulator: koneksi ke laptop dilakukan via `10.0.2.2`.  
     Karena itu, `ALLOWED_HOSTS` perlu memuat `["127.0.0.1", "localhost", "10.0.2.2", ...]`. Kalau tidak, Django akan mengembalikan **400 Bad Request (Invalid HTTP_HOST header)**.

   - **CORS dan pengaturan SameSite/cookie (terutama untuk Flutter web)**  
     Flutter web bisa jalan di origin berbeda dari Django. Browser akan:
     - mengecek aturan CORS,
     - membatasi pengiriman cookie silang origin (SameSite).  
     Karena itu perlu mengaktifkan CORS dan mengizinkan origin Flutter, serta mengatur cookie/session agar boleh dibawa dalam request. Jika salah konfigurasi, gejalanya:
     - request diblokir (CORS error di console),
     - cookie session tidak terkirim sehingga Django selalu menganggap user belum login.

   - **Izin akses internet di Android**  
     Di `AndroidManifest.xml` perlu:
     ```xml
     <uses-permission android:name="android.permission.INTERNET" />
     ```
     Tanpa ini, aplikasi Android tidak boleh melakukan request HTTP sama sekali, meskipun kodenya benar.

   Jika konfigurasi tersebut tidak dilakukan dengan benar, Flutter dan Django tidak akan bisa berkomunikasi dengan stabil: request gagal, login tidak pernah tercatat, atau data tidak bisa di-fetch.

5. **Mekanisme pengiriman data dari input hingga tampil di Flutter**  
   Gambaran alurnya (untuk daftar item):

   1. **User berinteraksi di Flutter**  
      Misalnya menekan tombol “All Products” atau “My Products” di `MyHomePage`. Flutter lalu membuka `ProductListPage`.

   2. **Flutter mengirim request ke Django**  
      Di `ProductListPage`, fungsi `_fetchItems` dipanggil:
      ```dart
      final url = _showOnlyMine
          ? "$baseUrl/flutter/items/?filter=my"
          : "$baseUrl/flutter/items/";
      final response = await request.get(url);
      ```
      `CookieRequest` menyertakan session cookie saat user sudah login.

   3. **Django memproses dan mengubah objek ke JSON**  
      View `flutter_items_json`:
      - membaca `request.user` dari session,
      - kalau `filter=my`, hanya mengambil item dengan `user = request.user`,
      - tiap `ShopAtSinItem` diubah ke dict flat via `_serialize_item`,
      - dikembalikan sebagai list JSON ke Flutter.

   4. **Flutter mem-parse JSON ke model Dart**  
      Flutter mengonversi tiap elemen JSON menjadi `ShopAtSinItem`:
      ```dart
      final items = (response as List)
          .map((json) => ShopAtSinItem.fromJson(json))
          .toList();
      ```

   5. **Flutter merender UI berdasarkan model**  
      `ListView.builder` menampilkan card untuk setiap `ShopAtSinItem`, dengan:
      - `name`, `price`, `description`,
      - `thumbnail` sebagai gambar,
      - `category` dan label “Featured” jika `isFeatured == true`.  

   Jadi alurnya: **input → request HTTP → Django serialize → JSON → parse ke model Dart → ditampilkan di widget list/detail**.

6. **Mekanisme autentikasi dari login, register, hingga logout**  

   - **Register**  
     - User mengisi form register di Flutter (username + password).  
     - Flutter mengirim data ke `/flutter/register/` menggunakan `request.postJson`.  
     - Django memvalidasi dengan `RegistrationForm`; jika valid, user baru dibuat.  
     - Django mengembalikan JSON status. Flutter menampilkan pesan dan mengarahkan user ke halaman login.

   - **Login**  
     - User mengisi username dan password di `LoginPage`.  
     - Flutter memanggil:
       ```dart
       request.login("$baseUrl/flutter/login/", {
         "username": username,
         "password": password,
       });
       ```
     - Django memanggil `authenticate` dan `login`, lalu membuat session dan mengirim session ID via cookie.  
     - `CookieRequest` menyimpan cookie ini dan menandai `loggedIn = true`.  
     - Flutter mengecek hasil login dan mengarahkan user ke `MyHomePage` (menu utama) dengan `Navigator.pushReplacementNamed`.

   - **Logout**  
     - User menekan tombol Logout di drawer (`AppDrawer`).  
     - Flutter memanggil:
       ```dart
       await request.logout("$baseUrl/flutter/logout/");
       ```
     - Django menjalankan `logout(request)`, menghapus session di server.  
     - `CookieRequest` menghapus cookie session lokal.  
     - Flutter menghapus semua route yang ada dan kembali ke halaman login menggunakan `Navigator.pushNamedAndRemoveUntil`.

   Dengan alur ini, seluruh proses autentikasi dari pembuatan akun, login, hingga logout dikerjakan Django, sementara Flutter bertugas sebagai UI dan klien yang menyimpan session cookie lewat `CookieRequest`.

7. **Cara mengimplementasikan checklist secara step-by-step**  

   Cara saya mengerjakan checklist:

   1. **Merapiin backend Django dulu**  
      - Pastikan model `ShopAtSinItem` sudah sesuai kebutuhan tugas (name, price, description, thumbnail, category, is_featured, user, stock, brand, rating, date_added).  
      - Membuat helper `_serialize_item(item, user)` yang mengubah objek ke JSON flat yang enak dikonsumsi Flutter.

   2. **Bikin endpoint khusus Flutter di Django**  
      - Menambahkan view `flutter_items_json` untuk mengembalikan list item, dengan dukungan filter `?filter=my`.  
      - Menambahkan view `flutter_login`, `flutter_register`, dan `flutter_logout` yang mengembalikan JSON, bukan HTML.  
      - Mendaftarkan semuanya di `urls.py` dengan prefix `/flutter/...`.

   3. **Siapkan konektivitas & baseUrl**  
      - Menambahkan `127.0.0.1` (dan jika perlu `10.0.2.2`) ke `ALLOWED_HOSTS`.  
      - Menentukan `baseUrl` di Flutter agar mengarah ke server Django yang benar.  
      - Memastikan izin internet di Android sudah aktif (kalau pakai emulator Android).

   4. **Membuat model Dart `ShopAtSinItem`**  
      - Mencocokkan field model Dart dengan JSON hasil `_serialize_item` (id, name, price, description, thumbnail, category, is_featured, stock, brand, rating, date_added, is_owner, detail_url).  
      - Mengimplementasikan `fromJson` dan `toJson` sehingga parsing dan serialisasi data konsisten.

   5. **Membangun halaman login & register di Flutter**  
      - `LoginPage` yang memanggil `request.login` ke `/flutter/login/`, dan jika berhasil, mengarahkan user ke `MyHomePage`.  
      - `RegisterPage` yang memanggil `request.postJson` ke `/flutter/register/` dan menunjukkan feedback ke user.

   6. **Mendesain menu utama + drawer**  
      - `MyHomePage` dengan tiga tombol utama: All Products, My Products, dan Add Product.  
      - Membuat drawer (`AppDrawer`) yang berisi menu Home, Add Product, dan Logout, lalu memasangnya di halaman-halaman utama.

   7. **Membuat halaman list dan detail item**  
      - `ProductListPage` untuk mengambil data dari `/flutter/items/` dan menampilkan kartu item berisi name, price, description, thumbnail, category, dan status featured.  
      - Menambahkan toggle/filter “My items” yang mengubah URL menjadi `/flutter/items/?filter=my` untuk menampilkan item yang terasosiasi dengan user login.  
      - `ProductDetailPage` untuk menampilkan seluruh atribut item dan menyediakan tombol untuk kembali ke daftar item.

   8. **Testing dan perbaikan**  
      - Menguji alur: register → login → lihat All Products → lihat detail item → tes filter My Products → logout.  
      - Kalau ada error (misalnya parsing JSON, host tidak diizinkan, atau login gagal), memperbaiki sisi Django atau Flutter sampai semua langkah checklist berjalan normal.

   Dengan urutan ini, setiap poin checklist (deployment, autentikasi, model Dart, halaman list & detail, tombol kembali, dan filter item milik user) benar-benar diimplementasikan satu per satu, bukan hanya mengikuti tutorial mentah-mentah.
