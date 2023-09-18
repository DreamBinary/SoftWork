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
            document.getElementById('display').value = eval(value);
        }
    } catch (error) {
        document.getElementById('display').value = '错误';
    }
}

function del() {
    const value = document.getElementById("display").value;
    document.getElementById("display").value = value.substring(0, value.length - 1);
}