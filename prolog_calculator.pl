% Değişkenler, atamalar ve temel aritmetik işlemlerine sahip basit bir hesap makinesi.

% Değişkenlerin ve karşılık gelen değerlerinin veritabanına kaydedilmesi
:- dynamic(variable/2).  % Değişken-değer çiftlerini saklamak için dinamik predikat kullanımı

% Aritmetik bir ifadeyi değerlendiren fonksiyon.
evaluate(Expr, Result) :-
    number(Expr),       % Eğer Expr bir sayı ise, sonucu doğrudan döndür
    Result = Expr.

evaluate(Expr, Result) :-
    atom(Expr),         % Eğer Expr bir değişken (atom) ise, veritabanında arama yap
    variable(Expr, Value),
    Result = Value.

evaluate(Expr, Result) :-
    Expr =.. [Op, Left, Right],  % Expr'i operator ve operandlara ayır
    evaluate(Left, LeftResult),  % Sol operandı değerlendir
    evaluate(Right, RightResult), % Sağ operandı değerlendir
    perform_operation(Op, LeftResult, RightResult, Result).  % İlgili aritmetik işlemi gerçekleştir

% Aritmetik işlemleri (+, -, *, /) yapar, sıfıra bölme hatasını kontrol eder.
perform_operation(+, X, Y, Result) :- Result is X + Y.
perform_operation(-, X, Y, Result) :- Result is X - Y.
perform_operation(*, X, Y, Result) :- Result is X * Y.
perform_operation(/, _, 0, _) :- write('Hata: Sıfıra bölme!'), nl, fail.  % Sıfıra bölme hatası
perform_operation(/, X, Y, Result) :- Result is X / Y.

% Bir değişkene değer atama (veritabanına kaydetme).
assign(Var, Value) :-
    assertz(variable(Var, Value)).  % Değeri değişkene atar ve veritabanına ekler

% Bir girdi ifadesini veya atamasını parse eder ve değerlendirir.
parse_and_evaluate(Input) :-
    (   sub_string(Input, 0, _, _, "=")  % Eğer girdi bir atama ise (örneğin, x = 5)
    ->  % Atama ise, böl ve işle
        split_string(Input, " = ", "", [Var, ValueStr]),
        number_string(Value, ValueStr),
        assign(Var, Value),
        format('~w değeri ~w\'ye atandı.~n', [Value, Var])  % Değeri atama mesajı
    ;   evaluate(Input, Result),
        format('Sonuç: ~w~n', [Result])  % Sonucu yazdır
    ).

% Kullanıcı ile etkileşimde bulunacak ana döngü.
calculator :-
    write('Bir ifade veya atama girin (örneğin, x = 5 veya x + 3): '),
    read_line_to_string(user_input, Input),  % Kullanıcıdan girdi al
    (   Input == "quit"   % Eğer kullanıcı "quit" yazarsa, çık
    ->  write('Hesap makinesi kapatılıyor...'), nl
    ;   parse_and_evaluate(Input),  % Girdiyi parse et ve değerlendir
        calculator).  % Daha fazla girdi almak için döngüyü devam ettir

% Hesap makinesini başlat.
:- calculator.
