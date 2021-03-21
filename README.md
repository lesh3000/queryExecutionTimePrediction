
**This project is licensed under the terms of the MIT license.**

# Data Analytics #

dataAnalysis.ipynb requires access to data/ and functions.py

# Model Training #

modelTraining.ipynb ran on google colab:
https://colab.research.google.com/drive/1rIeIPLkFO4aSdHuaxu-NALf9ptP6WLsF?usp=sharing

# Model Deployment #

Deployed on AZURE app services as FLASK app:
https://sqlproblemapp.azurewebsites.net/

Deployement specs explained: deploymentSpecs.pdf

Source code is available in deployment/
model/ contains deployed Tensorflow model and tokenizer
app.py is FLASK app scoring script

Prediction URI: https://sqlproblemapp.azurewebsites.net/predict
Required parameters: data|str

Example:

import requests
url = 'https://sqlproblemapp.azurewebsites.net/predict'
r = requests.post(url,json={'data':'quit'})
print(r.json())







