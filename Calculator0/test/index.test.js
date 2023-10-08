const {JSDOM} = require('jsdom');

const jsDomIntance = new JSDOM(`
<!DOCTYPE html>
<body>
<canvas id="canvas"></canvas>
<div class="calculator">
    <div class="output">
        <div class="operation">
            <div class="value"></div>
        </div>
        <div class="result">
            <div class="value">0</div>
        </div>
    </div>

    <div class="input">
    </div>
</div>
</body>
</html>
`)

const window = jsDomIntance.window; // window 对象
const document = window.document; // document 对象
global.document = document;

const {
    calculator_buttons,
    createCalculatorButton,
    calculator
} = require("../src/index")

test("CreateButton", () => {
    createCalculatorButton()
})

test("7 + 8 = 15", () => {
    calculator(calculator_buttons[4]) // clear
    calculator(calculator_buttons[10])  // 7
    calculator(calculator_buttons[36]) // +
    calculator(calculator_buttons[11])  // 8
    expect(document.querySelector('.operation .value').innerHTML).toBe("7+8")
    calculator(calculator_buttons[35]) // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("15")
})

test("7.2 + 8.3 = 15.5", () => {
    calculator(calculator_buttons[4]) // clear
    calculator(calculator_buttons[10])  // 7
    calculator(calculator_buttons[33])  // .
    calculator(calculator_buttons[27])  // 2
    calculator(calculator_buttons[36]) // add
    calculator(calculator_buttons[11])  // 8
    calculator(calculator_buttons[33])  // .
    calculator(calculator_buttons[28])  // 3
    expect(document.querySelector('.operation .value').innerHTML).toBe("7.2+8.3")
    calculator(calculator_buttons[35]) // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("15.5")
})

test("9 - 4 = 5", () => {
    calculator(calculator_buttons[4]);
    calculator(calculator_buttons[12]);
    calculator(calculator_buttons[29]);
    calculator(calculator_buttons[18]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("9-4");
    calculator(calculator_buttons[35]);
    expect(document.querySelector('.result .value').innerHTML).toBe("5");
});


test("2 + 7 × 8 = 58", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[27]); // 3
    calculator(calculator_buttons[36]); // add
    calculator(calculator_buttons[10]); // 4
    calculator(calculator_buttons[21]); // multiply
    calculator(calculator_buttons[11]); // 2
    expect(document.querySelector('.operation .value').innerHTML).toBe("2+7×8");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("58");
});

test("√(16) = 4", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[0]); // square root
    calculator(calculator_buttons[26]); // 1
    calculator(calculator_buttons[20]); // 6
    calculator(calculator_buttons[3]); // close parenthesis
    expect(document.querySelector('.operation .value').innerHTML).toBe("√(16)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("4");
});

test("1 / 0 = 'Infinity'", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[26]); // 1
    calculator(calculator_buttons[13]); // divide
    calculator(calculator_buttons[34]); // 0
    expect(document.querySelector('.operation .value').innerHTML).toBe("1÷0");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("Infinity");
});

test("+5! = 120", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[36]);
    calculator(calculator_buttons[19]); // 5
    calculator(calculator_buttons[22]); // factorial
    expect(document.querySelector('.operation .value').innerHTML).toBe("+5!");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("120");
});


test("(4 + 1)! = 120", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[2]);
    calculator(calculator_buttons[18]); // 4
    calculator(calculator_buttons[36]); // +
    calculator(calculator_buttons[26]); // 1
    calculator(calculator_buttons[3]);
    calculator(calculator_buttons[22]); // factorial
    expect(document.querySelector('.operation .value').innerHTML).toBe("(4+1)!");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("120");
});

test("sin(π) = 0", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[7]); // sin
    calculator(calculator_buttons[9]); // π
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("sin(π)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("0");
});

test("log(10) = 1", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[32]); // log (base 10)
    calculator(calculator_buttons[26]);
    calculator(calculator_buttons[34]);
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("log(10)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("1");// Approximately 2.3026
});

test("2^(3) = 8", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[27]); // 2
    calculator(calculator_buttons[23]); // power
    calculator(calculator_buttons[28]); // 3
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("2^(3)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("8");
});

test("+2^(3) = 8", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[36]); // 2
    calculator(calculator_buttons[27]); // 2
    calculator(calculator_buttons[23]); // power
    calculator(calculator_buttons[28]); // 3
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("+2^(3)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("8");
});

test("(2 + 2)^(3) = 64", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[2]);
    calculator(calculator_buttons[27]); // 2
    calculator(calculator_buttons[36]);
    calculator(calculator_buttons[27]); // 2
    calculator(calculator_buttons[3]);
    calculator(calculator_buttons[23]); // power
    calculator(calculator_buttons[28]); // 3
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("(2+2)^(3)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("64");
});

test("4^(2) = 16", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[18]); // 4
    calculator(calculator_buttons[1]); // square
    expect(document.querySelector('.operation .value').innerHTML).toBe("4^(2)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("16");
});

test("ln(e) = 1", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[24]); // ln
    calculator(calculator_buttons[17]); // e
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("ln(e)");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("1");
});

test("exp(2) ≈ 7.39", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[31]); // exp
    calculator(calculator_buttons[27]); // 2
    calculator(calculator_buttons[3]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("exp(2)");
    calculator(calculator_buttons[35]); // equal
    const result = parseFloat(document.querySelector('.result .value').innerHTML);
    expect(result).toBeCloseTo(7.39, 2); // Approximately 7.3891
});

// delete
test("delete", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[27]);
    calculator(calculator_buttons[27]);
    calculator(calculator_buttons[5]);
    expect(document.querySelector('.operation .value').innerHTML).toBe("2");
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("2");
})

// click
test("click", () => {
    const button = document.getElementById('2');
    const mockClick = jest.fn();
    button.addEventListener('click', mockClick);
    button.click();
    expect(mockClick).toHaveBeenCalled();
})

// error
test("error", () => {
    calculator(calculator_buttons[4]); // clear
    calculator(calculator_buttons[0]);
    calculator(calculator_buttons[35]); // equal
    expect(document.querySelector('.result .value').innerHTML).toBe("Error");
})

