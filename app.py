# encoding: utf-8
from flask import Flask,render_template,request,redirect,make_response,session
import pymysql
import hashlib
import math
from configs import server_host,server_port,secret_key
from configs import mysqlhost,dbuser,dbpassword,dbname,mysqlport
from flask_mail import Mail, Message
from configs import mailserver, mailusername, mailpassword
from flask_apscheduler.scheduler import APScheduler
import base64
import datetime

app = Flask(__name__,)
app.secret_key=secret_key

class APSchedulerConfig(object):
    JOBS = [
        {
            'id':'job1',
            'func':'app:reminder',
            'trigger':'cron',
            'day_of_week':"0-6",
            'hour':'14',
            'minute':'0',
            'second':'0'
        }
    ]
    SCHEDULER_API_ENABLE = True

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

def reminder():
    app.config['MAIL_SERVER'] = mailserver
    app.config['MAIL_PORT'] = 465
    app.config['MAIL_USE_SSL'] = True
    #app.config['MAIL_PORT'] = 578
    #app.config['MAIL_USE_TSL'] = True
    app.config['MAIL_USERNAME'] = mailusername
    app.config['MAIL_PASSWORD'] = mailpassword
    mail = Mail(app)
    
    db = connect()
    cur = db.cursor()
    cur.execute("select * from plant")
    plant_dict_list = cur.fetchall()
    plants_dict = {}
    for item in plant_dict_list:
        plants_dict.setdefault(item['plant_id'],[item['plant_latin_name'],item['plant_water_freqs']])
    days = (datetime.date.today()-datetime.date.fromisocalendar(2020,1,1)).days
    cur.execute("select * from user")
    user_dict_list = cur.fetchall()
    if days % 21 == 0:
        for user_dict in user_dict_list:
            if user_dict['plants'] == '0' or user_dict['email'] == '':
                continue
            else:
                user_mail = base64.b64decode(user_dict['email']).decode()
                user_name = user_dict['user_code']
                user_plants_list = user_dict['plants'].split(',')
                user_plants_list.remove('0')
                plants_latin_name_list = []
                for plant_id in user_plants_list:
                    if plants_dict[int(plant_id)][1] == 'low' or plants_dict[int(plant_id)][1] == 'med' or plants_dict[int(plant_id)][1] == 'high':
                        plants_latin_name_list.append(plants_dict[int(plant_id)][0])
                if plants_latin_name_list:
                    plants = ','.join(plants_latin_name_list)
                    try:
                        msg = Message('Watering Reminder', sender=mailusername, recipients=[user_mail])
                        msg.body = 'Dear ' + user_name + ':\n  Your plants need watering.(' + plants + ')'
                        with app.app_context():
                            mail.send(msg)
                    except:
                        pass
                else:
                    continue
    elif days % 7 == 0:
        for user_dict in user_dict_list:
            if user_dict['plants'] == '0' or user_dict['email'] == '':
                continue
            else:
                user_mail = base64.b64decode(user_dict['email']).decode()
                user_name = user_dict['user_code']
                user_plants_list = user_dict['plants'].split(',')
                user_plants_list.remove('0')
                plants_latin_name_list = []
                for plant_id in user_plants_list:
                    if plants_dict[int(plant_id)][1] == 'low' or plants_dict[int(plant_id)][1] == 'high':
                        plants_latin_name_list.append(plants_dict[int(plant_id)][0])
                if plants_latin_name_list:
                    plants = ','.join(plants_latin_name_list)
                    try:
                        msg = Message('Watering Reminder', sender=mailusername, recipients=[user_mail])
                        msg.body = 'Dear ' + user_name + ':\n  Your plants need watering.(' + plants + ')'
                        with app.app_context():
                            mail.send(msg)
                    except:
                        pass
                else:
                    continue
    elif days % 3 == 0:
        for user_dict in user_dict_list:
            if user_dict['plants'] == '0' or user_dict['email'] == '':
                continue
            else:
                user_mail = base64.b64decode(user_dict['email']).decode()
                user_name = user_dict['user_code']
                user_plants_list = user_dict['plants'].split(',')
                user_plants_list.remove('0')
                plants_latin_name_list = []
                for plant_id in user_plants_list:
                    if plants_dict[int(plant_id)][1] == 'med' or plants_dict[int(plant_id)][1] =='high':
                        plants_latin_name_list.append(plants_dict[int(plant_id)][0])
                    else:
                        continue
                if plants_latin_name_list:
                    plants = ','.join(plants_latin_name_list)
                    try:
                        msg = Message('Watering Reminder', sender=mailusername, recipients=[user_mail])
                        msg.body = 'Dear ' + user_name + ':\n  Your plants need watering.(' + plants + ')'
                        with app.app_context():
                            mail.send(msg)
                    except:
                        pass
                else:
                    continue
    else:
        for user_dict in user_dict_list:
            if user_dict['plants'] == '0' or user_dict['email'] == '':
                continue
            else:
                user_mail = base64.b64decode(user_dict['email']).decode()
                user_name = user_dict['user_code']
                user_plants_list = user_dict['plants'].split(',')
                user_plants_list.remove('0')
                plants_latin_name_list = []
                for plant_id in user_plants_list:
                    if plants_dict[int(plant_id)][1] == 'high':
                        plants_latin_name_list.append(plants_dict[int(plant_id)][0])
                if plants_latin_name_list:
                    plants = ','.join(plants_latin_name_list)
                    try:
                        msg = Message('Watering Reminder', sender=mailusername, recipients=[user_mail])
                        msg.body = 'Dear ' + user_name + ':\n  Your plants need watering.(' + plants + ')'
                        with app.app_context():
                            mail.send(msg)
                    except:
                        pass
                else:
                    continue
    cur.close()
    db.close()


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
            plant_name = '%'+request.args.get('Name')+'%'
            cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_latin_name like %s or plant_common_name like %s",(plant_name,plant_name))
            pag = pages(len(cur.fetchall()), 8)
            cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_latin_name like %s or plant_common_name like %s" + pag['limit'],(plant_name,plant_name))

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
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s and plant_sun_reqs = %s and plant_water_freqs = %s",(plant_type,plant_sun_reqs,plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s and plant_sun_reqs = %s and plant_water_freqs = %s" + pag['limit'],(plant_type,plant_sun_reqs,plant_water_freqs))
                else:
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s and plant_sun_reqs = %s",(plant_type,plant_sun_reqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s and plant_sun_reqs = %s" + pag['limit'],(plant_type,plant_sun_reqs))
            else:
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s and plant_water_freqs = %s",(plant_type,plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s and plant_water_freqs = %s" + pag['limit'],(plant_type,plant_water_freqs))
                else:
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s",(plant_type))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_type = %s" + pag['limit'],(plant_type))
        else:
            if request.args.get('Sunshine') and request.args.get('Sunshine') != 'all':
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_sun_reqs = %s and plant_water_freqs = %s",(plant_sun_reqs,plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_sun_reqs = %s and plant_water_freqs = %s" + pag['limit'],(plant_sun_reqs,plant_water_freqs))
                else:
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_sun_reqs = %s",(plant_sun_reqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_sun_reqs = %s" + pag['limit'],(plant_sun_reqs))
            else:
                if request.args.get('Water') and request.args.get('Water') != 'all':
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_water_freqs = %s",(plant_water_freqs))
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy where plant_water_freqs = %s" + pag['limit'],(plant_water_freqs))
                else:
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy")
                    pag = pages(len(cur.fetchall()), 8)
                    cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy" + pag['limit'])
        result = cur.fetchall()
        db.close()
        cur.close()
        return render_template('plants.html', data=result, pag=pag)
    else:
        cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy")
        pag = pages(len(cur.fetchall()), 8)
        cur.execute("select plant.plant_id,plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy,group_concat(location separator ' and ') as location from plant LEFT OUTER JOIN plant_location on plant.plant_id = plant_location.plant_id GROUP BY plant.plant_id, plant_latin_name,plant_common_name,plant_family,plant_desc,plant_type,plant_size,plant_maint_amount,plant_sun_reqs,plant_water_freqs,plant_soil_reqs,plant_allergy" + pag['limit'])
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

@app.route('/home')
def home():
    return render_template('home.html')

@app.route('/usercenter')
def usercenter(): 
    db = connect()
    cur = db.cursor()
    cur.execute("select * from plant Left Join plant_location on plant.plant_id = plant_location.plant_id where plant.plant_id in ("+ session.get('plants') +")")
    pag = pages(len(cur.fetchall()), 8)
    cur.execute('select * from plant Left Join plant_location on plant.plant_id = plant_location.plant_id where plant.plant_id in ('+ session.get('plants') +")" + pag['limit'])
    result = cur.fetchall()
    db.close()
    cur.close()
    return render_template('usercenter.html', data=result, pag=pag)

@app.route('/pop2/<plant_id>')
def pop2(plant_id):
    db = connect()
    cur = db.cursor()
    plantsList = session.get('plants').split(",")
    session.pop('plants')
    plantsList.remove(plant_id)
    plantsString = ",".join(plantsList)
    cur.execute("Update user Set plants=%s Where user_code=%s",(plantsString,session.get("user_code")))
    db.commit()
    db.close()
    cur.close()
    session["plants"] = plantsString
    return redirect('/usercenter')

@app.route('/email')
def email():
    db = connect()
    cur = db.cursor()
    inputEmail = request.args.get('email')
    email=base64.b64encode(inputEmail.encode())
    cur.execute('UPDATE user SET email=%s WHERE user_code=%s',(email,session.get("user_code")))
    db.commit()
    db.close()
    cur.close()
    return "success"


if __name__ == '__main__':    # 覆盖 if __name__ == '__main__'之后的内容
    scheduler = APScheduler()
    app.config.from_object(APSchedulerConfig())
    scheduler.init_app(app)
    scheduler.start()
    app.run(host=server_host, port=server_port)
    