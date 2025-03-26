#!/usr/bin/perl
use strict;
use warnings;

# Değişkenleri ve değerlerini saklamak için bir hash
my %variables;

# İfadeleri değerlendirmek için fonksiyon
sub evaluate_expression {
    my ($expr) = @_;
    
    # Değişkenleri, gerçek değerleriyle değiştirme
    $expr =~ s/\b([a-zA-Z_][a-zA-Z0-9_]*)\b/$variables{$1} || $1/ge;

    # İşlemi değerlendirme 
    my $result = eval $expr;
    if ($@) {
        print "Islemi degerlendirirken hata olustu: $@\n";
    }
    return $result;
}

# Bir değişkene değer atama
sub assign_variable {
    my ($var, $value) = @_;
    $variables{$var} = $value;
}

# Ana döngü, girdiyi almak ve hesaplamaları yapmak için
while (1) {
    print "Bir islem girin (örneğin, 2 + x veya x = 5).: ";
    my $input = <STDIN>;
    chomp($input);

    # Girdi bir atama içeriyorsa (x = 5), değişkene değer atayın
    if ($input =~ /^([a-zA-Z_][a-zA-Z0-9_]*)\s*=\s*(.*)$/) {
        my $var = $1;
        my $value = $2;
        # Değeri değişkene atama
        assign_variable($var, evaluate_expression($value));
        print "$var = $variables{$var}\n";
    }
    # Girdi basit bir aritmetik ifade ise, değerlendirin
    elsif ($input =~ /^(.+)$/) {
        my $result = evaluate_expression($input);
        print "Sonuc: $result\n";
    }
    print "\n";
}

