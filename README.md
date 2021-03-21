
**This project is licensed under the terms of the MIT license.**

# Data Analytics #

dataAnalysis.ipynb requires access to data/ and functions.py

# Model Training #

modelTraining.ipynb ran on google colab: <br>
https://colab.research.google.com/drive/1tCdCI6rzDgySILAf5GtQCX67n55AZ8eX?usp=sharing

# Model Deployment #

Deployed on AZURE app services as FLASK app:<br>
https://sqlproblemapp.azurewebsites.net/<br><br>

Deployement specs explained: deploymentSpecs.pdf<br><br>

Source code is available in deployment/ <br>
model/ contains deployed Tensorflow model and tokenizer<br>
app.py is FLASK app scoring script<br><br><br>

Prediction URI: https://sqlproblemapp.azurewebsites.net/predict<br>
Required parameters: data|str<br><br>

Example:<br><br>

import requests<br>
url = 'https://sqlproblemapp.azurewebsites.net/predict'<br>
r = requests.post(url,json={'data':'quit'})<br>
print(r.json())<br>







