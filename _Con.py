#GPIO import
import RPi.GPIO as GPIO
import time

#S3Cam import
from datetime import datetime
from time import sleep
import picamera
import os
import boto3
import botocore
import yaml

#GPIO Setting
GPIO.setmode(GPIO.BCM)
GPIO.setup(4, GPIO.IN, pull_up_down=GPIO.PUD_UP)

#S3Cam Setting
with open("config3.yml", 'r') as ymlfile:
    cfg = yaml.load(ymlfile)
image_width = cfg['image_settings']['horizontal_res']
image_height = cfg['image_settings']['vertical_res']
file_extension = cfg['image_settings']['file_extension']
file_name = cfg['image_settings']['file_name']
photo_interval = cfg['image_settings']['photo_interval']
image_folder = cfg['image_settings']['folder_name']

#Camera Setup
camera = picamera.PiCamera()
camera.resolution = (image_width, image_height)
camera.awb_mode = cfg['image_settings']['awb_mode']

#verify image folder exists and create if it does not
if not os.path.exists(image_folder):
    os.makedirs(image_folder)

#Camera Warmup
sleep(2)
file_num = 0
s3 = boto3.resource('s3')
while(True):
    input_state = GPIO.input(4)
    file_name = cfg['image_settings']['file_name']
    filepath = file_name + str(file_num) + file_extension
    if input_state == False:
        try:
            s3.Object(cfg['s3']['bucket_name'], filepath).load()
        except botocore.exceptions.ClientError as ex:
            if ex.response['Error']['Code'] == '404':
                print('NoSuchKey')
                camera.capture(filepath)
                data = open(filepath, 'rb')
                s3.Bucket(cfg['s3']['bucket_name']).put_object(Key=filepath, Body=data, ACL='public-read-write')
                print('Upload Success')
                file_num += 1
            else:
                print('Wrong!')
                raise
        else:
            print('SuchKey')
            file_num += 1
        sleep(photo_interval)
