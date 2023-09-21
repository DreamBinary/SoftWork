function clr() {
    document.getElementById('display').value = ""
}

function insert(val) {
    document.getElementById('display').value += val
}


function calculate() {
    try {
        let value = document.getElementById('display').value;
        value = value.replaceAll("×", "*");
        if (value !== "") {
            const r = /^\+?[1-9][0-9]*$/;
            let result = eval(value);
            if (!r.test(result)) {
                result = parseFloat(result.toFixed(2));
            }
            document.getElementById('display').value = result;
        }
    } catch (error) {
        document.getElementById('display').value = '错误';
    }
}

function del() {
    const value = document.getElementById("display").value;
    document.getElementById("display").value = value.substring(0, value.length - 1);
}

function onKeyDown() {
    if (event.keyCode === 13) {
        calculate();
    }


}