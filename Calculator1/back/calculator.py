from flask import Flask, request
import pymysql
from flask_cors import CORS
import json
import datetime

app = Flask(__name__)
CORS(app) # 解决跨域问题
db = pymysql.connect(host="localhost", port=3306, user="root", password="mysqlcxq", db="calculator", charset="utf8")
cur = db.cursor()


@app.route("/")
def test():
    return "hello world"


@app.route("/get_deposit_rate")
def get_deposit_rate():
    time = request.args.get("time")
    deposit_sql = f"select rate from deposit where time <= {time} order by time desc"
    cur.execute(deposit_sql)
    deposit_rate = cur.fetchone()
    if deposit_rate is None:
        deposit_rate = 0
    else:
        deposit_rate = deposit_rate[0]
    data = json.dumps({"data": deposit_rate})
    return data


@app.route("/get_loans_rate")
def get_loans_rate():
    time = request.args.get("time")
    loans_sql = f"select rate from loans where time <= {time} order by time desc"
    cur.execute(loans_sql)
    loans_rate = cur.fetchone()
    if loans_rate is None:
        loans_rate = 0
    else:
        loans_rate = loans_rate[0]
    data = json.dumps({"data": loans_rate})
    return data


@app.route("/set_deposit_rate", methods=["POST"])
def set_deposit_rate():
    time = request.form.get("time")
    rate = request.form.get("rate")
    deposit_sql = f"update deposit set rate={rate} where time={time}"
    result = cur.execute(deposit_sql)
    db.commit()
    data = json.dumps({"data": result})
    return data


@app.route("/set_loans_rate", methods=["POST"])
def set_loans_rate():
    time = request.form.get("time")
    rate = request.form.get("rate")
    loans_sql = f"update loans set rate={rate} where time={time}"
    result = cur.execute(loans_sql)
    db.commit()
    data = json.dumps({"data": result})
    return data


@app.route("/get_history")
def get_history():
    history_sql = "select pro, ans from history order by time desc limit 10"
    cur.execute(history_sql)
    history = cur.fetchall()
    data = json.dumps({"data": history})
    return data


@app.route("/save_history", methods=["POST"])
def save_history():
    time = datetime.datetime.now()
    pro = request.form.get("pro")
    ans = request.form.get("ans")
    history_sql = f"insert into history(time, pro, ans) values('{time}', '{pro}', '{ans}')"
    result = cur.execute(history_sql)
    db.commit()
    data = json.dumps({"data": result})
    return data


if __name__ == "__main__":
    app.run()
