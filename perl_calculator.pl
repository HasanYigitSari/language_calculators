#!/usr/bin/perl
use strict;
use warnings;

# x ve y girdi olarak alınır
print "x icin deger girin: ";
my $x = <STDIN>;
chomp($x);  # Yeni satır karakteri silinir

print "y icin deger girin: ";
my $y = <STDIN>;
chomp($y);  # Yeni satır karakteri silinir

# Buradaki kod x ve y'nin sayı olduğunu doğrular. -? herhangi bir negatif veya pozitif değer, \d+(\.\d+) herhangi bir sayı demek
unless ($x =~ /^-?\d+(\.\d+)?$/ && $y =~ /^-?\d+(\.\d+)?$/) {
    print "Hata: x and y bu degerleri alamaz.\n";
    exit;
}

# x ve y'yi basar
print "x degeri: $x\n";
print "y degeri: $y\n";

# İşlem girdi olarak alınır
print "Islem giriniz (mesela, 2 + x or x * y): ";
my $input = <STDIN>;
chomp($input);  # Yeni satır karakteri silinir

# Girdi işlem hesaplanmaya buradan başlanır
my ($num1, $operator, $num2) = split(/\s+/, $input);  # Boşluklar ile ayrım yapılır

# Sayılar değişken mi değil mi diye bakılır. Eğer x veya y harfi girilmişse o değişkenlerdeki değerler numlara atanır
if ($num1 eq 'x') {
    $num1 = $x;  
} elsif ($num1 eq 'y') {
    $num1 = $y;  
}

if ($num2 eq 'x') {
    $num2 = $x;  
} elsif ($num2 eq 'y') {
    $num2 = $y;  
}

# Ondalık sayılar integere çevrilir
$num1 = 0 + $num1;  
$num2 = 0 + $num2;  

# Gelen işleme göre işlemler yapılır
my $result;
if ($operator eq '+') {
    $result = $num1 + $num2;
} elsif ($operator eq '-') {
    $result = $num1 - $num2;
} elsif ($operator eq '*') {
    $result = $num1 * $num2;
} elsif ($operator eq '/') {
    if ($num2 == 0) {
        print "Hata: Sifira bolunmez.\n";
        exit;  # Bölüm sıfır ise çıkış yapılır
    }
    $result = $num1 / $num2;
} else {
    print "Hata: Desteklenmeyen islem '$operator'.\n";
    exit;
}

# Print the result
print "Sonuc: $result\n";
