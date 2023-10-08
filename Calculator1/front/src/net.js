const URL = {
    baseUrl: "http://127.0.0.1:5000/",
    get_deposit_rate: this.baseUrl + "get_deposit_rate",
    get_loan_rate: this.baseUrl + "get_loan_rate",
    set_deposit_rate: this.baseUrl + "set_deposit_rate",
    set_loan_rate: this.baseUrl + "set_loan_rate"
}


function get_fun(url, params) {
    let xhr = new XMLHttpRequest();
    let new_url = url;
    if (params) {
        new_url += "?";
        for (let key in params) {
            new_url += key + "=" + params[key] + "&";
        }
        new_url = new_url.substring(0, new_url.length - 1);
    }
    xhr.open("GET", new_url, true);
    console.log(new_url);
    xhr.send();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                return xhr.responseText;
            }
        }
    }
}

function post_fun(url, params) {
    xhr.open("POST", url, true);
    let form = new FormData();
    // params -> map
    for (let key in params) {
        form.append(key, params[key]);
    }
    xhr.send(form);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                return xhr.responseText;
            }
        }
    }
}

function get_deposit_rate(time) {
    // return get_fun(URL.get_deposit_rate, {"time": time});
    let xhr = new XMLHttpRequest();
    let new_url = "http://localhost:5000/get_loans_rate?time=3";
    xhr.open("GET", new_url, true);
    console.log(new_url);
    xhr.send();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                return xhr.responseText;
            }
        }
    }
}

function get_loan_rate(time) {
    return get_fun(URL.get_loan_rate, {"time": time});
}

function set_deposit_rate(time, rate) {
    return post_fun(URL.set_deposit_rate, {"time": time, "rate": rate});
}

function set_loan_rate(time, rate) {
    return post_fun(URL.set_loan_rate, {"time": time, "rate": rate});
}

