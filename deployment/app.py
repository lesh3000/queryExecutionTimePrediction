from flask import Flask, request, jsonify, render_template
import re
import tensorflow
from tensorflow.keras.preprocessing.sequence import pad_sequences
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras import backend as K
import pickle
import numpy as np



app = Flask(__name__)

def metr(y_true, y_pred):
  '''custom keras metric to monitor real data'''
  return K.mean(K.square(K.exp(y_pred)- K.exp(y_true)))


with open('model/tokenizer.pkl','rb') as tks:
    tokenizer = pickle.load(tks)

model= tensorflow.keras.models.load_model('model/modelRnn.h5',
                                         custom_objects={'metr': metr}, compile=True)





@app.route('/')
def home():
    return "Please call /predict to make predictions"


def clean(s):
    s= re.sub('\s+', ' ', s)
    try:
        s=re.search(r'(.*)/(.*)',s).group(2)

    except:
        pass
    return s.lower()



def extendedClean(s):
    s= re.sub('\d{4}-\d{2}-\d{2}',"|date|",s)
    s= re.sub('\d{2}:\d{2}:\d{2}',"|time|",s)
    s= re.sub('\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}',"|datetime|",s)
    s= re.sub('\d{13}',"|datetime|",s)
    s= re.sub('\d{8,12}',"|id|",s)
    s= re.sub('\d{2,7}',"|number|",s)
    return s



@app.route('/predict',methods=['POST'])
def predict():

    data = request.get_json(force=True)
    text=data['data'].strip()
    
    if text != "":
        pr=clean(text)
        
        pr= extendedClean(pr)
        pr=pr.replace(",", " , ").replace("("," ( ").replace(")"," ) ").replace("="," = ")
        X = tokenizer.texts_to_sequences([pr])
        X = pad_sequences(X,model.layers[0].input_shape[0][1])
    
        z=model.predict(X)
        z= str(np.exp(z[0][0]))
        output= {"text":text, "query_time": z}
    else:
        output= {"text":text, "query_time": "Please provide a SQL command"}
        
    return jsonify(output)



if __name__ == "__main__":
    app.run(debug=True)