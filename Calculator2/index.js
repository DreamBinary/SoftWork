const POWER = "POWER(", FACTORIAL = "FACTORIAL("

const OPERATORS = ["+", "-", "*", "/"]

let data = {
    operation: [], formula: [],
}

let ans = 0

let calculator_buttons = [
    {
        name: "square-root", symbol: "√", formula: "Math.sqrt(", type: "math_function"
    }, {
        name: "square", symbol: "x²", formula: POWER, type: "math_function"
    }, {
        name: "open-parenthesis", symbol: "(", formula: "(", type: "number"
    }, {
        name: "close-parenthesis", symbol: ")", formula: ")", type: "number"
    }, {
        name: "clear", symbol: "C", formula: false, type: "key"
    }, {
        name: "delete", symbol: "⌫", formula: false, type: "key"
    }, {
        name: "cos", symbol: "cos", formula: "trigo(Math.cos,", type: "trigo_function"
    }, {
        name: "sin", symbol: "sin", formula: "trigo(Math.sin,", type: "trigo_function"
    }, {
        name: "tan", symbol: "tan", formula: "trigo(Math.tan,", type: "trigo_function"
    }, {
        name: "pi", symbol: "π", formula: "Math.PI", type: "number"
    }, {
        name: "7", symbol: 7, formula: 7, type: "number"
    }, {
        name: "8", symbol: 8, formula: 8, type: "number"
    }, {
        name: "9", symbol: 9, formula: 9, type: "number"
    }, {
        name: "division", symbol: "÷", formula: "/", type: "operator"
    }, {
        name: "acos", symbol: "acos", formula: "inv_trigo(Math.acos,", type: "trigo_function"
    }, {
        name: "asin", symbol: "asin", formula: "inv_trigo(Math.asin,", type: "trigo_function"
    }, {
        name: "atan", symbol: "atan", formula: "inv_trigo(Math.atan,", type: "trigo_function"
    }, {
        name: "e", symbol: "e", formula: "Math.E", type: "number"
    }, {
        name: "4", symbol: 4, formula: 4, type: "number"
    }, {
        name: "5", symbol: 5, formula: 5, type: "number"
    }, {
        name: "6", symbol: 6, formula: 6, type: "number"
    }, {
        name: "multiplication", symbol: "×", formula: "*", type: "operator"
    }, {
        name: "factorial", symbol: "×!", formula: FACTORIAL, type: "math_function"
    }, {
        name: "power", symbol: "x<span>y</span>", formula: POWER, type: "math_function"
    }, {
        name: "ln", symbol: "ln", formula: "Math.log", type: "math_function"
    }, {
        name: "percent", symbol: "%", formula: "/100", type: "number"
    }, {
        name: "1", symbol: 1, formula: 1, type: "number"
    }, {
        name: "2", symbol: 2, formula: 2, type: "number"
    }, {
        name: "3", symbol: 3, formula: 3, type: "number"
    }, {
        name: "subtraction", symbol: "–", formula: "-", type: "operator"
    }, {
        name: "ANS", symbol: "ANS", formula: "ans", type: "number"
    }, {
        name: "exp", symbol: "exp", formula: "Math.exp", type: "math_function"
    }, {
        name: "log", symbol: "log", formula: "Math.log10", type: "math_function"
    }, {
        name: "comma", symbol: ".", formula: ".", type: "number"
    }, {
        name: "0", symbol: 0, formula: 0, type: "number"
    }, {
        name: "calculate", symbol: "=", formula: "=", type: "calculate"
    }, {
        name: "addition", symbol: "+", formula: "+", type: "operator"
    }
];


const input_element = document.querySelector('.input')

const output_operation_element = document.querySelector('.operation .value')

const output_result_element = document.querySelector('.result .value')

function createCalculatorButton() {
    calculator_buttons.forEach(button => {
        input_element.innerHTML += `<button id = ${button.name} class=${button.type}>${button.symbol}</button>`
    })
}

createCalculatorButton()

// adding event listener
input_element.addEventListener('click', event => {
    const target_btn = event.target
    calculator_buttons.forEach(button => {
        if (button.name === target_btn.id) {
            calculator(button)
        }
    })
})


// calculator
function calculator(button) {
    if (button.type === 'operator') {
        data.operation.push(button.symbol)
        data.formula.push(button.formula)
    } else if (button.type === 'number') {
        data.operation.push(button.symbol)
        data.formula.push(button.formula)
    } else if (button.type === 'trigo_function') {
        data.operation.push(button.symbol + '(')
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
        } else if (button.name === 'delete') {
            data.operation.pop()
            data.formula.pop()
        }
    } else if (button.type === 'calculate') {
        formula_str = data.formula.join('')

        let POWER_SEARCH_RESULT = search(data.formula, POWER)

        let FACTORIAL_SEARCH_RESULT = search(data.formula, FACTORIAL)

        const BASES = powerBaseGetter(data.formula, POWER_SEARCH_RESULT)

        // console.log(BASES)


        BASES.forEach(base => {
            let toreplace = base + POWER
            let replacement = "Math.pow(" + base + ",";
            formula_str = formula_str.replace(toreplace, replacement)
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
            if (error instanceof SyntaxError) {
                result = "SyntaxError"
                updateOutputResult(result)
                return
            }
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

        let next_index = fact_index + 1;

        if (next_index === FACTORIAL) {
            factorial_sequence += 1
            return
        }

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
    output_operation_element.innerHTML = operation
}

function updateOutputResult(result) {
    output_result_element.innerHTML = result
}

function factorial(number) {
    if (number % 1 !== 0) {
        return gamma(number + 1)
    }

    if (number === 0 || number === 1) {
        return 1
    }

    let result = 1

    for (let i = 1; i <= number; i++) {
        result *= i
    }
    if (result === Infinity) {
        return Infinity
    }

    return result
}


function gamma(n) {
    const g = 7;
    const p = [0.99999999999980993, 676.5203681218851, -1259.1392167224028, 771.32342877765313, -176.61502916214059, 12.507343278686905, -0.13857109526572012, 9.9843695780195716e-6, 1.5056327351493116e-7];
    if (n < 0.5) {
        return Math.PI / Math.sin(n * Math.PI) / gamma(1 - n);
    } else {
        n--;
        let x = p[0];
        for (let i = 1; i < g + 2; i++) {
            x += p[i] / (n + i);
        }
        const t = n + g + 0.5;
        return Math.sqrt(2 * Math.PI) * Math.pow(t, (n + 0.5)) * Math.exp(-t) * x;
    }
}