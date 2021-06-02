from flask import Flask,render_template,request,jsonify
from flask_sqlalchemy import SQLAlchemy
from algo_mini_project import predict_inf
import json
from datetime import datetime
import pandas as pd


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "sqlite:///userdata.db"
app.config['SQLALCHEMY_TRACK_MODIFICATION'] = False; 

user = SQLAlchemy(app)

class datacollec(user.Model):
    sno = user.Column(user.Integer,primary_key = True)
    id = user.Column(user.String,nullable=False)
    longitude = user.Column(user.Float,nullable = False)
    latitude = user.Column(user.Float,nullable = False)
    date = user.Column(user.String, nullable = False)
    
    def __repr__(self) -> str:
        return f"{self.sno}-{self.longitude}"

@app.route('/',methods = ['POST','GET'])
def user_det():
    if request.method=='POST':
        request_data = request.data
        request_data = json.loads(request_data)
        name = request_data['name']
        long = request_data['long']
        latt = request_data['latti']
        # print(name)
        # print(long)
        # print(latt)
        date = request_data['date']
        user1 = datacollec(id=name,longitude=long,latitude=latt,date=date)
        user.session.add(user1)
        user.session.commit() 
        return ""

    # data = pd.read_csv('proj_dataset.csv')
    # data['id'] = data['id'].astype('string')
    # data['timestamp'] = data['timestamp'].astype('string')
    # object1 = []
    # for i in range(len(data)):
    #     name = data['id'][i]
    #     date = data['timestamp'][i]
    #     latt = data['latitude'][i]
    #     long = data['longitude'][i]
    #     user1 = datacollec(id=name,longitude=long,latitude=latt,date=date)
    #     object1.append(user1)
    # user.session.bulk_save_objects(object1)
    # user.session.commit() 


    # return ""                

@app.route('/predict',methods=['POST','GET'])
def prediction():
    if request.method =='POST':
        request_data = request.data
        request_data = json.loads(request_data)
        name = request_data['name']
        ptime = request_data['date']//1000 
        userdata = datacollec.query.all()
        lists = []
        for user in userdata:
            lists.append([user.id,user.latitude,user.longitude,user.date])
            
        df = pd.DataFrame(lists,columns=['id','latitude','longitude','date'])

        result = predict_inf(df, name, ptime)
        data = json.dumps(result)

        return data

if __name__ == "__main__":
    app.run(port = 8000,debug=True)