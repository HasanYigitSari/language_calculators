# language_calculators Hasan Yiğit Sarı 231101050

Rust:

İlk başta Hashmap'te değişkenler ve değerleri tutulur
Sonra döngüye girilir ve "x = y + z" türünden girdi alınır. Eğer "cik" gelirse program kapanır
Girdi "=" den öncesi değişken ve sonrası işlem olacak şekilde ayrılır
Evaluate expression fonksiyonu işlemi çözer ve sonucu döndürüp değişkene atar;
Bu fonksiyonda işlem üç parçaya ayrılır, ilk sayı, işlem operatörü ve ikinci sayı
Eğer bunlar değişkense değerleri alınır
Sonra elimizdeki iki sayı değerine işlem neyse o uygulanır. Eğer bölen sıfırsa hata verilir
Parse value fonksiyonuna sayı gelirse <i32> türüne dönüştürülür, değişken ise değeri hashmapten alınır, ikisi de değilse hata verir

rustc rust_calculator.rs
./rust_calculator

x = 5 + 2 (girdi)
x = 7 (çıktı)

Perl:

Değişkenler hash'te saklanır
Evaluate expression fonksiyonu değişkenlerin yerine değerlerini koyar
Bu değerler ve normal sayılar eval fonksiyonunda işleme sokulur
Assign variable fonksiyonu bir değişkene değer atar ve hash'te saklar
Döngü atama veya işlem girdisi alır
Eğer değişken ataması ise atanır ve gösterilir
Eğer işlem ise sonuç bulunur ve gösterilir

perl perl_calculator.pl

x = 5 (girdi)
x = 5 (çıktı)
x + 3 (girdi 2)
Sonuc: 8 (çıktı 2)

ADA: 

Variable diye bir değişken tipi oluşturulur, içinde adının ve değerinin bilgisi vardır
Sonra 10 değişkenle sınırlı variable'lardan oluşan bir array oluşturulur. İstenirse bu sayı artıtıp azaltılabilir kod değiştirilerek
Find variable fonksiyonu Name adını içindeki ad değerleriyle tek tek kıyaslayarak arar. Bulamazsa sıfır, bulursa indexi döndürür
Assign variable fonksiyonu bulduğu ilk boş yere girilen ad ve değeri atar. Eğer ad zaten varsa değeri günceller
Evaluate fonksiyonu işlemi sağ sayı, işlem operatörü ve sol sayı diye ayırır
Sayılar değişken mi diye bakar, değişken iseler değerlerini alır
Bu değerler ve sayılar ile işlemi gerçekleştirir. Bölen sıfır ise hata basılır
Ana döngüde girdi alınır
Atama ise assign variable'a girer
İşlem ise evaluate'e
Sonuç basılır

gnatmake ada_calculator.adb
./ada_calculator

x = 5
Sonuc: 5
2 + 3
Sonuc: 5

Scheme:

Variables hash'i değişkenleri saklar
Evaluate expression işlemin türüne göre farklı işlemleri yapar.
Sayı ise sayı, değişken ise değişkenin değeri döndürülür
İşlem yapılıp sonucu döndürülür. Bölen sıfır ise hata basılır
Assign variable fonksiyonu değişkene değer atar ve variables'a kaydeder
Parse and evaluate fonksiyonu girdiye bakar
Eğer atama ise girdi boşluklarla bölünür ve assign variable fonksiyonu çağırılır
Eğer işlem ise evaluate expression çağırılır
Ana döngü girdiyi alır. Eğer "cik" gelirse program sonlanır
Girdi değerlendirilir ve döngü başa sarar

racket scheme_calculator.scm

x = 5
x = 5
x + 3
Sonuc: 8

Prolog:

variable/2 adlı veritabanı değişkenleri saklar
variable(var,value) şeklinde veri kaydedilir. var ad, value değerdir
evaluate fonksiyonu işlemi değerlendirir
eğer sayı ise sayı, değişken ise değişkenin değeri döner
işlem ise perform operation fonksiyonu uygulanır
bu fonksiyon işlemin sonucunu döner, bölen sıfır ise hata basar
assign fonksiyonu bir değişken adına bir değeri atar ve veritabanına kaydeder
parse and evaluate girdi atama ise assign ile atamayı yapar, işlem ise evaluate ile işlemi


swipl
?- prolog_calculator

x = 5
5 değeri x'ye atandı.
x + 3
Sonuc: 8









