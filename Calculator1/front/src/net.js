const baseUrl = "http://127.0.0.1:5000/"
const URL = {
    get_deposit_rate: baseUrl + "get_deposit_rate",
    get_loan_rate: baseUrl + "get_loan_rate",
    set_deposit_rate: baseUrl + "set_deposit_rate",
    set_loan_rate: baseUrl + "set_loan_rate"
}

let xhr = new XMLHttpRequest();

function get_fun(url, params, callback) {
    let new_url = url;
    if (params) {
        new_url += "?";
        for (let key in params) {
            new_url += key + "=" + params[key] + "&";
        }
        new_url = new_url.substring(0, new_url.length - 1);
    }
    // console.log(new_url);
    xhr.open("GET", new_url, true);
    xhr.send();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                let json = JSON.parse(xhr.responseText);
                callback(json["data"]);
            }
        }
    }
}

function post_fun(url, params, callback) {

    let form = new FormData();
    // params -> map
    for (let key in params) {
        form.append(key, params[key]);
    }
    xhr.open("POST", url, true);
    xhr.send(form);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            if (xhr.status === 200) {
                let json = JSON.parse(xhr.responseText);
                callback(json["data"]);
            }
        }
    }
}

function get_deposit_rate(time, callback) {
    return get_fun(URL.get_deposit_rate, {"time": time}, callback);
}

function get_loan_rate(time, callback) {
    return get_fun(URL.get_loan_rate, {"time": time});
}

function set_deposit_rate(time, rate, callback) {
    return post_fun(URL.set_deposit_rate, {"time": time, "rate": rate}, callback);
}

function set_loan_rate(time, rate, callback) {
    return post_fun(URL.set_loan_rate, {"time": time, "rate": rate}, callback);
}

