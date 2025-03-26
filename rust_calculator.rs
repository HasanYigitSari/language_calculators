use std::collections::HashMap;
use std::io;

fn main() {
    let mut variables = HashMap::new(); // This will store variables and their values.

    loop {
        println!("Enter an expression (e.g., x = 5 + 2 or 'exit' to quit):");
        
        let mut input = String::new();
        io::stdin().read_line(&mut input).expect("Failed to read line");
        
        let input = input.trim(); // Remove any extra spaces or newlines.
        
        if input == "exit" {
            break; // Exit the loop if the user types "exit".
        }
        
        // Split input into two parts: before and after the '=' sign
        let parts: Vec<&str> = input.split("=").collect();
        
        if parts.len() == 2 {
            let var_name = parts[0].trim(); // Get the variable name.
            let expression = parts[1].trim(); // Get the arithmetic expression.
            
            // Evaluate the expression.
            let result = evaluate_expression(expression, &variables);
            
            match result {
                Some(value) => {
                    variables.insert(var_name.to_string(), value);
                    println!("{} = {}", var_name, value);
                }
                None => println!("Invalid expression!"),
            }
        } else {
            println!("Invalid input. Please enter a valid assignment or expression.");
        }
    }
}

// This function evaluates a simple arithmetic expression like "5 + 2" or "x + 3".
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
                        println!("Error: Division by zero!");
                        None
                    }
                }
                _ => {
                    println!("Unknown operator: {}", operator);
                    None
                }
            },
            _ => None,
        }
    } else {
        None
    }
}

// This function parses a value from the expression.
// If the value is a number, it converts it to an integer.
// If the value is a variable (like 'x'), it looks it up in the variables map.
fn parse_value(value: &str, variables: &HashMap<String, i32>) -> Option<i32> {
    if let Ok(num) = value.parse::<i32>() {
        Some(num)
    } else if let Some(&var_value) = variables.get(value) {
        Some(var_value)
    } else {
        println!("Error: Invalid value or unknown variable '{}'", value);
        None
    }
}
