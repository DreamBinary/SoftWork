const POWER = "POWER(", FACTORIAL = "FACTORIAL("

const OPERATORS = ["+", "-", "*", "/"]

let data = {
    operation: [], formula: [],
}

let ans = 0

let calculator_buttons = [
    {
        name: "square-root", symbol: "√", formula: "Math.sqrt(", type: "math_function"  // 0
    }, {
        name: "square", symbol: "x²", formula: POWER, type: "math_function" // 1
    }, {
        name: "open-parenthesis", symbol: "(", formula: "(", type: "number"  // 2
    }, {
        name: "close-parenthesis", symbol: ")", formula: ")", type: "number"  // 3
    }, {
        name: "clear", symbol: "C", formula: false, type: "key"  // 4
    }, {
        name: "delete", symbol: "⌫", formula: false, type: "key"  // 5
    }, {
        name: "cos", symbol: "cos", formula: "Math.cos(", type: "math_function" // 6
    }, {
        name: "sin", symbol: "sin", formula: "Math.sin(", type: "math_function"  // 7
    }, {
        name: "tan", symbol: "tan", formula: "Math.tan(", type: "math_function"  // 8
    }, {
        name: "pi", symbol: "π", formula: "Math.PI", type: "number" // 9
    }, {
        name: "7", symbol: 7, formula: 7, type: "number" // 10
    }, {
        name: "8", symbol: 8, formula: 8, type: "number" // 11
    }, {
        name: "9", symbol: 9, formula: 9, type: "number" // 12
    }, {
        name: "division", symbol: "÷", formula: "/", type: "operator" //13
    }, {
        name: "acos", symbol: "acos", formula: "Math.acos(", type: "math_function" // 14
    }, {
        name: "asin", symbol: "asin", formula: "Math.asin(", type: "math_function"  // 15
    }, {
        name: "atan", symbol: "atan", formula: "Math.atan(", type: "math_function"  // 16
    }, {
        name: "e", symbol: "e", formula: "Math.E", type: "number" // 17
    }, {
        name: "4", symbol: 4, formula: 4, type: "number" // 18
    }, {
        name: "5", symbol: 5, formula: 5, type: "number" // 19
    }, {
        name: "6", symbol: 6, formula: 6, type: "number" // 20
    }, {
        name: "multiplication", symbol: "×", formula: "*", type: "operator" // 21
    }, {
        name: "factorial", symbol: "×!", formula: FACTORIAL, type: "math_function" // 22
    }, {
        name: "power", symbol: "x<span>y</span>", formula: POWER, type: "math_function" // 23
    }, {
        name: "ln", symbol: "ln", formula: "Math.log", type: "math_function" //24
    }, {
        name: "percent", symbol: "%", formula: "/100", type: "number" // 25
    }, {
        name: "1", symbol: 1, formula: 1, type: "number" // 26
    }, {
        name: "2", symbol: 2, formula: 2, type: "number" // 27
    }, {
        name: "3", symbol: 3, formula: 3, type: "number" // 28
    }, {
        name: "subtraction", symbol: "-", formula: "-", type: "operator" // 29
    }, {
        name: "ANS", symbol: "ANS", formula: "ans", type: "number" // 30
    }, {
        name: "exp", symbol: "exp", formula: "Math.exp", type: "math_function" // 31
    }, {
        name: "log", symbol: "log", formula: "Math.log10", type: "math_function" // 32
    }, {
        name: "comma", symbol: ".", formula: ".", type: "number" // 33
    }, {
        name: "0", symbol: 0, formula: 0, type: "number" // 34
    }, {
        name: "calculate", symbol: "=", formula: "=", type: "calculate" // 35
    }, {
        name: "addition", symbol: "+", formula: "+", type: "operator" // 36
    }
];

function createCalculatorButton() {
    const input_element = document.querySelector('.input')
    calculator_buttons.forEach(button => {
        input_element.innerHTML += `<button id = ${button.name} class=${button.type}>${button.symbol}</button>`
    })

    // adding event listener
    input_element.addEventListener('click', event => {
        const target_btn = event.target
        calculator_buttons.forEach(button => {
            if (button.name === target_btn.id) {
                calculator(button)
            }
        })
    })
}

// calculator
function calculator(button) {
    if (button.type === 'operator') {
        data.operation.push(button.symbol)
        data.formula.push(button.formula)
    } else if (button.type === 'number') {
        data.operation.push(button.symbol)
        data.formula.push(button.formula)
    } else if (button.type === 'math_function') {
        let symbol, formula;
        if (button.name === 'factorial') {
            symbol = "!"
            formula = button.formula
            data.operation.push(symbol)
            data.formula.push(formula)
        } else if (button.name === 'power') {
            symbol = "^("
            formula = button.formula
            data.operation.push(symbol)
            data.formula.push(formula)
        } else if (button.name === 'square') {
            symbol = "^("
            formula = button.formula
            data.operation.push(symbol)
            data.formula.push(formula)
            data.operation.push("2)")
            data.formula.push("2)")
        } else if (button.name === 'ln') {
            symbol = "ln("
            formula = button.formula + "("
            data.operation.push(symbol)
            data.formula.push(formula)
        } else if (button.name === 'log') {
            symbol = 'log('
            formula = button.formula + "("
            data.operation.push(symbol)
            data.formula.push(formula)
        } else if (button.name === 'exp') {
            symbol = 'exp('
            formula = button.formula + "("
            data.operation.push(symbol)
            data.formula.push(formula)
        } else {
            symbol = button.symbol + "("
            formula = button.formula
            data.operation.push(symbol)
            data.formula.push(formula)
        }
    } else if (button.type === 'key') {
        if (button.name === 'clear') {
            data.operation = []
            data.formula = []
            updateOutputResult(0)
        } else {
            data.operation.pop()
            data.formula.pop()
        }
    } else {
        let formula_str = data.formula.join('')
        let POWER_SEARCH_RESULT = search(data.formula, POWER)
        let FACTORIAL_SEARCH_RESULT = search(data.formula, FACTORIAL)
        const BASES = powerBaseGetter(data.formula, POWER_SEARCH_RESULT)
        BASES.forEach(base => {
            let toReplace = base + POWER
            let replacement = "Math.pow(" + base + ",";
            formula_str = formula_str.replace(toReplace, replacement)
        })

        const NUMBERS = factorialNumGetter(data.formula, FACTORIAL_SEARCH_RESULT)

        NUMBERS.forEach(number => {
            formula_str = formula_str.replace(number.toReplace, number.replacement)
        })

        let result
        // console.log(formula_str)
        try {
            const r = /^\+?[1-9][0-9]*$/;
            result = eval(formula_str);
            if (!r.test(result)) {
                result = parseFloat(result.toFixed(2));
            }
        } catch (error) {
            result = "Error"
            updateOutputResult(result)
            return
        }
        ans = result
        data.operation = [result]
        data.formula = [result]
        updateOutputResult(result)
        return
    }
    updateOutputOperation(data.operation.join(''))
}

function factorialNumGetter(formula, FACTORIAL_SEARCH_RESULT) {
    let numbers = []
    let factorial_sequence = 0
    FACTORIAL_SEARCH_RESULT.forEach(fact_index => {
        let number = []
        let first_fact_index = fact_index - factorial_sequence
        let prev_idx = first_fact_index - 1
        let paren_count = 0
        while (prev_idx >= 0) {
            if (formula[prev_idx] === '(') {
                paren_count -= 1
            }
            if (formula[prev_idx] === ')') {
                paren_count += 1
            }
            let is_operator = false
            OPERATORS.forEach(OPERATOR => {
                if (formula[prev_idx] === OPERATOR) {
                    is_operator = true
                }
            })
            if (is_operator && paren_count === 0) {
                break;
            }
            number.unshift(formula[prev_idx])
            prev_idx--;
        }

        let number_str = number.join('')
        const factorial = "factorial(", close_paren = ')'
        let times = factorial_sequence + 1
        let toReplace = number_str + FACTORIAL.repeat(times)
        let replacement = factorial.repeat(times) + number_str + close_paren
        numbers.push({
            toReplace: toReplace, replacement: replacement
        })

        factorial_sequence = 0
    })
    return numbers
}

function powerBaseGetter(formula, POWER_SEARCH_RESULT) {
    let powers_base = []

    POWER_SEARCH_RESULT.forEach(power_index => {
        let base = []

        let paren_count = 0

        let prev_idx = power_index - 1

        while (prev_idx >= 0) {

            if (formula[prev_idx] === '(') {
                paren_count -= 1
            }
            if (formula[prev_idx] === ')') {
                paren_count += 1
            }

            let is_operator = false

            OPERATORS.forEach(OPERATOR => {
                if (formula[prev_idx] === OPERATOR) {
                    is_operator = true
                }
            })

            let is_power = formula[prev_idx] === POWER

            if ((is_operator && paren_count === 0) || is_power) {
                break;
            }

            base.unshift(formula[prev_idx])

            prev_idx--;
        }

        powers_base.push(base.join(''))
    })

    return powers_base
}

function search(array, keyword) {
    let search_res = []

    array.forEach((element, index) => {
        if (element === keyword) {
            search_res.push(index)
        }
    })
    return search_res
}

function updateOutputOperation(operation) {
    document.querySelector('.operation .value').innerHTML = operation
}

function updateOutputResult(result) {
    document.querySelector('.result .value').innerHTML = result
}

function factorial(number) {
    let result = 1
    for (let i = 1; i <= number; i++) {
        result *= i
    }
    return result
}

createCalculatorButton()

module.exports = {
    calculator_buttons,
    createCalculatorButton,
    calculator
}