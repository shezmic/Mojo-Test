from python import Python
import math
from PySide6.QtWidgets import QApplication, QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QLineEdit
from PySide6.QtCore import Qt

struct CalculatorMemory:
    var value: Float64

    fn __init__(inout self):
        self.value = 0.0

    fn store(inout self, val: Float64):
        self.value = val

    fn recall(self) -> Float64:
        return self.value

    fn clear(inout self):
        self.value = 0.0

struct Calculator:
    var memory: CalculatorMemory

    fn __init__(inout self):
        self.memory = CalculatorMemory()

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

    fn power(a: Float64, b: Float64) -> Float64:
        return math.pow(a, b)

    fn square_root(a: Float64) -> Float64:
        if a < 0:
            print("Error: Cannot calculate square root of negative number!")
            return 0
        return math.sqrt(a)

@value
struct CalculatorGUI(QWidget):
    var calc: Calculator
    var display: QLineEdit

    fn __init__(inout self):
        super().__init__()
        self.calc = Calculator()
        self.initUI()

    fn initUI(inout self):
        self.setWindowTitle('Mojo Calculator')
        self.setGeometry(100, 100, 300, 400)

        layout = QVBoxLayout()

        self.display = QLineEdit()
        self.display.setAlignment(Qt.AlignRight)
        self.display.setReadOnly(True)
        layout.addWidget(self.display)

        buttons = [
            ['7', '8', '9', '/'],
            ['4', '5', '6', '*'],
            ['1', '2', '3', '-'],
            ['0', '.', '=', '+'],
            ['M+', 'MR', 'MC', 'C'],
            ['^', '√', '', '']
        ]

        for row in buttons:
            h_layout = QHBoxLayout()
            for button_text in row:
                button = QPushButton(button_text)
                button.clicked.connect(lambda _, t=button_text: self.on_click(t))
                h_layout.addWidget(button)
            layout.addLayout(h_layout)

        self.setLayout(layout)

    fn on_click(self, button_text: String):
        current = self.display.text()
        if button_text == '=':
            try:
                result = eval(current)
                self.display.setText(str(result))
            except:
                self.display.setText("Error")
        elif button_text == 'C':
            self.display.clear()
        elif button_text == 'M+':
            self.calc.memory.store(Float64(current))
        elif button_text == 'MR':
            self.display.setText(str(self.calc.memory.recall()))
        elif button_text == 'MC':
            self.calc.memory.clear()
        elif button_text == '^':
            self.display.setText(current + '**')
        elif button_text == '√':
            self.display.setText(f"math.sqrt({current})")
        else:
            self.display.setText(current + button_text)

fn main():
    app = QApplication([])
    calculator = CalculatorGUI()
    calculator.show()
    app.exec_()

main()