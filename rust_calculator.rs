use std::collections::HashMap;
use std::io;

fn main() {
    let mut variables = HashMap::new(); // Degiskenleri ve degerleri tutar.

    loop {
        println!("Girdi: (mesela, 'x = 5 + 2' veya sonra 'y = x + 1' ya da cikmak icin 'cik')");
        
        let mut input = String::new();
        io::stdin().read_line(&mut input).expect("Yazilan okunamadi");
        
        let input = input.trim(); // Bosluklari siler
        
        if input == "cik" {
            break; // "cik" yazilir ise donguden cikar
        }
        
        // Girdi ikiye ayirilir: '=' den once ve sonrasi
        let parts: Vec<&str> = input.split("=").collect();
        
        if parts.len() == 2 {
            let var_name = parts[0].trim(); // oncesi degisken adini alir.
            let expression = parts[1].trim(); // sonrasi aritmetik islemi alir.
            
            // islem yapilir bu fonksiyon ile
            let result = evaluate_expression(expression, &variables);
            
            match result {
                Some(value) => {
                    variables.insert(var_name.to_string(), value);
                    println!("{} = {}", var_name, value);
                }
                None => println!("Kabul edilmeyen islem"),
            }
        } else {
            println!("Kabul edilmeyen girdi. Lütfen gecerli girdi girin.");
        }
    }
}

// "5 + 2" veya "x + 3" gibi basit islemleri yapan fonksiyon
fn evaluate_expression(expr: &str, variables: &HashMap<String, i32>) -> Option<i32> {
    let tokens: Vec<&str> = expr.split_whitespace().collect();
    
    if tokens.len() == 3 {
        let first = tokens[0];
        let operator = tokens[1];
        let second = tokens[2];
        
        let first_value = parse_value(first, variables);
        let second_value = parse_value(second, variables);
        
        match (first_value, second_value) {
            (Some(f), Some(s)) => match operator {
                "+" => Some(f + s),
                "-" => Some(f - s),
                "*" => Some(f * s),
                "/" => {
                    if s != 0 {
                        Some(f / s)
                    } else {
                        println!("Hata sifira bolunmez");
                        None
                    }
                }
                _ => {
                    println!("Bilinmeyen islem: {}", operator);
                    None
                }
            },
            _ => None,
        }
    } else if tokens.len() == 1 {
        println!("Yanlis islem turu, x = y + z seklinde girin");
        None
    }
}

// Bu fonksiyon islemden bir deger okur
// Eger sayi ise integere cevirir
// Eger degisken ise map'te bakar
fn parse_value(value: &str, variables: &HashMap<String, i32>) -> Option<i32> {
    if let Ok(num) = value.parse::<i32>() {
        Some(num)
    } else if let Some(&var_value) = variables.get(value) {
        Some(var_value)
    } else {
        println!("Gecersiz deger veya bilinmeyen girdi '{}'", value);
        None
    }
}
