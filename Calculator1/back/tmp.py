import pymysql
import datetime
# now
print(datetime.datetime.now())
db = pymysql.connect(host="localhost",
                     port=3306,
                     user="root",
                     password="mysqlcxq",
                     db="calculator",
                     charset="utf8")
cur = db.cursor()
c_time = datetime.datetime.now()
pro = "1+1"
ans = "2"
history_sql = f"insert into history(time, pro, ans) values('{c_time}', '{pro}', '{ans}')"
print("--------------------")
print(history_sql)
print("--------------------")
cur.execute(history_sql)