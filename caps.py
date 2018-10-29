from clarifai.rest import ClarifaiApp, Concept
app = ClarifaiApp(api_key='')

model = app.models.get('capston')

select_concept_list = [Concept(concept_name='train'), Concept(concept_id='')]
model.predict_by_url(url='', select_concepts=select_concept_list)

import boto3
import json
from botocore.vendored import requests
from clarifai.rest import ClarifaiApp
s3_client = boto3.client('s3')
app = ClarifaiApp(api_key='')

def get_relevant_tags(image_url):
    response_data = app.tag_urls([image_url])
 
    tag_urls = []

    for concept in response_data['outputs'][0]['data']['concepts']:
        tag_urls.append(concept['name'])
        #tag_urls.append(concept['value'])
 
    return tag_urls

    # A lambda function to interact with AWS RDS MySQL

import pymysql
import sys

REGION = 'us-east-1'

rds_host  = ".ap-south-1.rds.amazonaws.com"
name = "appychip"
password = "password"
db_name = "appychip"

def save_events(event):
    """
    This function fetches content from mysql RDS instance
    """
    result = []
    conn = pymysql.connect(rds_host, user=name, passwd=password, db=db_name, connect_timeout=5)
    with conn.cursor() as cur:
        cur.execute("""insert into test (id, name) values( %s, '%s')""" % (event['id'], event['name']))
        cur.execute("""select * from test""")
        conn.commit()
        cur.close()
        for row in cur:
            result.append(list(row))
        print "Data from RDS..."
        print result

def main(event, context):
    save_events(event)
        


# event = {
#   "id": 777,
#   "name": "capston"
# }
# context = ""
# main(event, context)
