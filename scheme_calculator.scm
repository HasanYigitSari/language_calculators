;; Değişkenlerin için hash tablosu
(define variables (make-hash))

;; Bir işlemi değerlendiren fonksiyon
(define (evaluate-expression expr)
  (cond
    ;; Durum 1: İşlem sayı ise döndür
    ((number? expr) expr)
    
    ;; Durum 2: İşlem bir değişkense, değişkenin değerini variables hash tablosundan geri döndür
    ((hash-has-key? variables expr) (hash-ref variables expr))
    
    ;; Durum 3: Eğer ifade bir toplama işlemi ise, örneğin (+ x 3)
    ((and (pair? expr) (= (length expr) 3) (eq? (car expr) '+))
     (+ (evaluate-expression (cadr expr)) (evaluate-expression (caddr expr))))
    
    ;; Durum 4: Eğer ifade bir çıkarma işlemi ise, örneğin (- x 3)
    ((and (pair? expr) (= (length expr) 3) (eq? (car expr) '-))
     (- (evaluate-expression (cadr expr)) (evaluate-expression (caddr expr))))
    
    ;; Durum 5: Eğer ifade bir çarpma işlemi ise, örneğin (* x 3)
    ((and (pair? expr) (= (length expr) 3) (eq? (car expr) '*))
     (* (evaluate-expression (cadr expr)) (evaluate-expression (caddr expr))))
    
    ;; Durum 6: Eğer ifade bir bölme işlemi ise, örneğin (/ x 3), sıfıra bölme hatası kontrolü yapılır
    ((and (pair? expr) (= (length expr) 3) (eq? (car expr) '/))
     (let ((denom (evaluate-expression (caddr expr))))  ;; Paydayı al
       (if (= denom 0)  ;; Payda sıfır mı?
           (begin 
             (display "Hata: Sifira bolunmez.")  ;; Sıfıra bölme hatası mesajı yazdır
             (newline)
             'error)  ;; Bölme hatası durumunda 'error' döndür
           (/ (evaluate-expression (cadr expr)) denom))))))

;; Bir değişkene değer atamak için fonksiyon
(define (assign-variable var value)
  (hash-set! variables var value))  ;; Değeri variables hash tablosuna kaydet

;; Girdi parse edilip değerlendirilirken, atamaları ve işlemleri işleyen fonksiyon
(define (parse-and-evaluate input)
  (if (string-contains input "=")  ;; Girdinin bir atama olup olmadığını kontrol et (mesela "x = 5")
      (let* ((parts (string-split input " "))  ;; Girdi boşluklarla bölünür
             (var (car parts))  ;; İlk kısım değişken adıdır
             (value (string-join (cdr parts) " ")))  ;; Geri kalan kısım, değerdir
        (assign-variable var (evaluate-expression (read (open-input-string value))))  ;; Değeri ata
        (display (string-append var " = " (number->string (hash-ref variables var))))  ;; Sonucu göster
        (newline))
      ;; Eğer atama değilse, normal bir aritmetik işlem olarak değerlendir
      (evaluate-expression (read (open-input-string input)))))

;; Hesap makinesinin ana döngüsü
(define (calculator)
  (display "Bir islem veya atama girin (mesela, 'x = 5' veya 'x + 3'): Cikmak icin "cik"")
  (let ((input (read-line)))  ;; Girdi alınır
    (if (not (equal? input "cik"))  ;; "cik" yazılmazsa, hesap makinesini çalıştırmaya devam et
        (begin
          (display "Sonuc: ")
          (display (parse-and-evaluate input))  ;; Girdiyi parse et ve değerlendir
          (newline)
          (calculator))  ;; Daha fazla girdi almak için hesap makinesi fonksiyonunu tekrar çağır
        (display "Cıkılıyor...")))  ;; Kullanıcı "quit" yazarsa, hesap makinesini kapat

(calculator)  ;; Hesap makinesini başlat
