# encoding: utf-8
from flask import Flask,render_template,request,redirect,make_response,session
import pymysql
import hashlib
import math
from configs import server_host,server_port,secret_key
from configs import mysqlhost,dbuser,dbpassword,dbname,mysqlport

app = Flask(__name__,)
app.secret_key=secret_key

def connect():
    """
    连接数据库
    数据库参数储存在configs.py文件中,包括mysqlhost,dbuser,dbpassword,dbname,mysqlport
    """
    db = pymysql.connect(host=mysqlhost, port=mysqlport, user=dbuser, passwd=dbpassword, db=dbname, charset='utf8', cursorclass=pymysql.cursors.DictCursor)
    return db

def pages(counts,pageNum):
    """
    返回分页数据
    :param ounts: 总条数,int
    :param pageNum: 每页条数,int
    :return: [{},{}...]
    """
    if request.url.find("?")<0:
        url=request.url+"?page="
    else:
        if request.url.find("page")<0:
            url=request.url+"&page="
        else:
            url=request.url[0:request.url.rfind("=")+1]
    pageCounts=math.ceil(counts/pageNum)
    currentPage=int(request.args.get("page") or 0)
    strs="<a href='%s'> First </a> "%(url+str(0))
    last=currentPage-1 if currentPage-1>0 else 0
    strs+=" <a href='%s'> Previous </a> "%(url+str(last))
    start=currentPage-2 if currentPage-2> 0 else 0
    end=start+4 if currentPage+4<pageCounts else pageCounts
    for item in range(start,end):
        if currentPage==item:
            strs+=" <a href='%s' style='color=red'>%s</a> "%(url+str(item),item+1)
        else:
            strs+=" <a href='%s'>%s</a> "%(url+str(item),item+1)
    next=currentPage+1 if currentPage+1<pageCounts else pageCounts-1
    strs+=" <a href='%s'> Next </a> "%(url+str(next))
    strs+=" <a href='%s'> End </a>"%(url+str(pageCounts-1))
    limit=" limit "+str(currentPage*pageNum)+","+str(pageNum)
    return {'limit':limit,'strs':strs}

@app.route('/')
def index():
    if session.get("login") == "yes":
        return render_template('index.html',login="yes")
    else:
        return render_template('index.html',login="no")

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/signUp',methods=["GET","POST"])
def signup():
    if request.method == 'POST':
        db = connect()
        cur = db.cursor()
        user_code = request.form["username"]
        cur.execute("select * from user where user_code = %s",(user_code))
        if cur.fetchone():
            return render_template('signup.html',text="Repetitive username")
        user_password = request.form["password"]
        md5 = hashlib.md5()
        md5.update(user_password.encode("utf8"))
        upass=md5.hexdigest()
        cur.execute('insert into user(user_code,user_password) value(%s,%s)', (user_code, upass))
        db.commit()
        db.close()
        cur.close()
        return render_template('signup.html',text="Successful")
    else:
        return render_template('signup.html')

@app.route('/checkLogin',methods=["POST"])
def checkLogin():
    db = connect()
    cur = db.cursor()
    user_code = request.form["username"]
    user_password = request.form["password"]
    md5 = hashlib.md5()
    md5.update(user_password.encode("utf8"))
    upass=md5.hexdigest()
    cur.execute('select * from user where user_code=%s and user_password=%s', (user_code, upass))
    result = cur.fetchone()
    db.close()
    cur.close()
    if(result):
        res = make_response(redirect('/'))
        # 用户ID
        session["user_code"] = user_code
        session["plants"] = result['plants']
        session["login"] = "yes"
        return res
    else:
        return render_template('login.html',text="The user name or password is incorrect!")

# 退出登录
@app.route('/logout')
def logout():
    res = make_response(redirect('/'))
    session.pop("login")
    session.pop("user_code")
    session.pop('plants')
    return res

@app.route('/about')
def about():
    return render_template('about.html')

@app.route('/plants')
def plants():
    db = connect()
    cur = db.cursor()
    if not request.url.find("?")<0:        
        if request.args.get('Name') and request.args.get('Name') != '':
            plant_name = request.args.get('Name')
            cur.execute("select * from plant where plant_latin_name = %s or plant_common_name = %s",(plant_name,plant_name))
            pag = pages(len(cur.fetchall()), 8)
            cur.execute("select * from plant where plant_latin_name = %s or plant_common_name = %s" + pag['limit'],(plant_name,plant_name))
            result = cur.fetchall()
            db.close()
            cur.close()
            return render_template('plants.html', data=result, pag=pag)
        if request.args.get('Type') and request.args.get('Type') != 'all':
            plant_type = request.args.get('Type')
        else:
            plant_type = ""
        if request.args.get('Sunshine') and request.args.get('Sunshine') != 'all':
            plant_sun_reqs = request.args.get('Sunshine')
        else:
            plant_sun_reqs = ""
        if request.args.get('Water') and request.args.get('Water') != 'all':
            plant_water_freqs = request.args.get('Water')
        else:
            plant_water_freqs = ""              
        if request.args.get('Type') and request.args.get('Type') != 'all':
            if request.args.get('Sunshine') and request.args.get('Sunshine') != 'all':
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select * from plant where plant_type = %s and plant_sun_reqs = %s and plant_water_freqs = %s",(plant_type,plant_sun_reqs,plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_type = %s and plant_sun_reqs = %s and plant_water_freqs = %s" + pag['limit'],(plant_type,plant_sun_reqs,plant_water_freqs))
                else:
                    cur.execute("select * from plant where plant_type = %s and plant_sun_reqs = %s",(plant_type,plant_sun_reqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_type = %s and plant_sun_reqs = %s" + pag['limit'],(plant_type,plant_sun_reqs))
            else:
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select * from plant where plant_type = %s and plant_water_freqs = %s",(plant_type,plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_type = %s and plant_water_freqs = %s" + pag['limit'],(plant_type,plant_water_freqs))
                else:
                    cur.execute("select * from plant where plant_type = %s",(plant_type))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_type = %s" + pag['limit'],(plant_type))
        else:
            if request.args.get('Sunshine') and request.args.get('Sunshine') != 'all':
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select * from plant where plant_sun_reqs = %s and plant_water_freqs = %s",(plant_sun_reqs,plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_sun_reqs = %s and plant_water_freqs = %s" + pag['limit'],(plant_sun_reqs,plant_water_freqs))
                else:
                    cur.execute("select * from plant where plant_sun_reqs = %s",(plant_sun_reqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_sun_reqs = %s" + pag['limit'],(plant_sun_reqs))
            else:
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select * from plant where plant_water_freqs = %s",(plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant where plant_water_freqs = %s" + pag['limit'],(plant_water_freqs))
                else:
                    cur.execute("select * from plant")
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select * from plant" + pag['limit'])
        result = cur.fetchall()
        db.close()
        cur.close()
        return render_template('plants.html', data=result, pag=pag)
    else:
        cur.execute("select * from plant")
        pag = pages(len(cur.fetchall()), 8)
        cur.execute('select * from plant' + pag['limit'])
        result = cur.fetchall()
        db.close()
        cur.close()
        return render_template('plants.html', data=result, pag=pag)
    
@app.route('/content/<plant_id>')
def content(plant_id):
    db = connect()
    cur = db.cursor()
    cur.execute('select * from plant where plant_id=%s',(plant_id))
    result = cur.fetchone()
    db.close()
    cur.close()
    if session.get('login') == "yes":
        plantsList = session.get('plants').split(",")       
        if plant_id in plantsList:
            checkStatu = "checked"
        else:
            checkStatu = "check"
        return render_template('content.html',data=result,checkStatu=checkStatu)
    else:
        return render_template('content.html',data=result)

@app.route('/add/<plant_id>')
def add(plant_id):
    db = connect()
    cur = db.cursor()
    cur.execute('select * from plant where plant_id=%s',(plant_id))
    result = cur.fetchone()
    plantsList = session.get('plants').split(",")
    session.pop('plants')
    plantsList.append(plant_id)
    plantsString = ",".join(plantsList)
    cur.execute("Update user Set plants=%s Where user_code=%s",(plantsString,session.get("user_code")))
    db.commit()
    db.close()
    cur.close()
    session["plants"] = plantsString
    if plant_id in plantsList:
        checkStatu = "checked"
    else:
        checkStatu = "check"
    return render_template('content.html',data=result,checkStatu=checkStatu)

@app.route('/pop/<plant_id>')
def pop(plant_id):
    db = connect()
    cur = db.cursor()
    cur.execute('select * from plant where plant_id=%s',(plant_id))
    result = cur.fetchone()
    plantsList = session.get('plants').split(",")
    session.pop('plants')
    plantsList.remove(plant_id)
    plantsString = ",".join(plantsList)
    cur.execute("Update user Set plants=%s Where user_code=%s",(plantsString,session.get("user_code")))
    db.commit()
    db.close()
    cur.close()
    session["plants"] = plantsString
    if plant_id in plantsList:
        checkStatu = "checked"
    else:
        checkStatu = "check"
    return render_template('content.html',data=result,checkStatu=checkStatu)

# 提醒浇水(如果检查到有checked plant就会触发提醒,轮询间隔时间设置在index.html中)
@app.route('/search')
def search():
    if session.get('user_code'):
        plantsList = session.get('plants').split(",")
        if len(plantsList) > 1:
            return 'success'
        else:
            return 'fail'
    else:
        return 'fail'

@app.route('/maps')
def maps():
    # return redirect('https://www.google.com/maps/search/%E5%85%AC%E5%9B%AD/@-37.8201109,144.9126469,11z/data=!3m1!4b1?hl=en')
    return render_template('tempmaps.html')
    # return app.send_static_file('tempmaps.html')
    
if __name__ == '__main__':
    app.run(host=server_host,port=server_port)     
    