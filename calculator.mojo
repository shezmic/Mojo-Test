from python import Python

fn add(a: Float64, b: Float64) -> Float64:
    return a + b

fn subtract(a: Float64, b: Float64) -> Float64:
    return a - b

fn multiply(a: Float64, b: Float64) -> Float64:
    return a * b

fn divide(a: Float64, b: Float64) -> Float64:
    if b == 0:
        print("Error: Division by zero!")
        return 0
    return a / b

fn get_number() -> Float64:
    let py = Python.import_module("builtins")
    while True:
        try:
            return py.float(input("Enter a number: "))
        except ValueError:
            print("Invalid input. Please enter a valid number.")

fn get_operation() -> String:
    while True:
        op = input("Enter operation (+, -, *, /): ")
        if op in ["+", "-", "*", "/"]:
            return op
        print("Invalid operation. Please try again.")

fn main():
    print("Welcome to the Mojo Calculator!")
    
    while True:
        num1 = get_number()
        num2 = get_number()
        op = get_operation()
        
        var result: Float64
        if op == "+":
            result = add(num1, num2)
        elif op == "-":
            result = subtract(num1, num2)
        elif op == "*":
            result = multiply(num1, num2)
        else:
            result = divide(num1, num2)
        
        print("Result:", result)
        
        if input("Do you want to perform another calculation? (y/n): ").lower() != "y":
            break
    
    print("Thank you for using the Mojo Calculator!")

main()