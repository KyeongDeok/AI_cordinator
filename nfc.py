from __future__ import print_function
# Import SDK packages
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import time,json,ssl
from AWSIoTPythonSDK.exception.AWSIoTExceptions import connectTimeoutException

# scard
from smartcard.Exceptions import NoCardException
from smartcard.Exceptions import CardConnectionException
from smartcard.System import readers
from smartcard.util import toHexString
from smartcard.CardType import AnyCardType
from smartcard.CardRequest import CardRequest
import threading
import time

from operator import eq

# For certificate based connection
myMQTTClient = AWSIoTMQTTClient("capstonpi")
# For Websocket connection
# myMQTTClient = AWSIoTMQTTClient("myClientID", useWebsocket=True)
# Configurations
# For TLS mutual authentication
myMQTTClient.configureEndpoint("a1118c5lm8uox.iot.ap-northeast-2.amazonaws.com", 8883)
# For Websocket
# myMQTTClient.configureEndpoint("YOUR.ENDPOINT", 443)
myMQTTClient.configureCredentials("./cert/rootCA.pem", "private.pem.key", "certificate.pem.crt")
# For Websocket, we only need to configure the root CA
# myMQTTClient.configureCredentials("YOUR/ROOT/CA/PATH")
myMQTTClient.configureOfflinePublishQueueing(-1)  # Infinite offline Publish queueing
myMQTTClient.configureDrainingFrequency(2)  # Draining: 2 Hz
myMQTTClient.configureConnectDisconnectTimeout(10)  # 10 sec
myMQTTClient.configureMQTTOperationTimeout(5)  # 5 se





#sema
#sem = threading.Semaphore(1)

#class RestrictedArea(threading.Thread):
 #   def run(self):
        
                
#flag=False
readnum=0
id=6
#while(True):
#for reader in readers():
while(True):
    try:
    #reader = readers()
        cardtype = AnyCardType()
        cardrequest = CardRequest(cardType=cardtype )
        cardservice = cardrequest.waitforcard()
        reader = readers()[readnum]
        connection = reader.createConnection()
        connection.connect()
        print(reader, toHexString(connection.getATR()))
        myMQTTClient.connect()
	if(eq(connection.getATR(),"")):
		myMQTTClient.disconnect()
		connection.disconnect()
		continue
        myPayload = json.dumps({'ATR':toHexString(connection.getATR())})
        id+=1
        myPayload = myPayload.decode('utf-8')
        myMQTTClient.publish("capstonpi",myPayload, 0)
        myMQTTClient.subscribe("capstonpi", 1,0)
        myMQTTClient.unsubscribe("capstonpi")
        print('success!!')
        myMQTTClient.disconnect()
        connection.disconnect()
    #        readnum+=1
    except NoCardException:
        print(reader, 'no card inserted')
    except CardConnectionException:
        print("card removed")
    except connectTimeoutException:
        print("connect timeout!")

    import sys
    if 'win32' == sys.platform:
        print('press Enter to continue')
        sys.stdin.read(1)

#while(True):
#    threads = []
#    for i in range(10):
#        threads.append(readATR())
        #t = threading.Thread(target=readATR)
#    for t in threads:
#        t.start()
        
#    for t in threads:
#        t.join()
