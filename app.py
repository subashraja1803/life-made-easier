from flask import Flask, jsonify, request
import json
import smtplib
import cv2
import numpy as np
import urllib.request
response = ''

app = Flask(__name__)

@app.route('/name', methods = ['POST'])
def nameRoute():

    global response
    
    if(request.method == 'POST'):
        #request.headers.add("Access-Control-Allow-Origin", "*")
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) 
        name = request_data['name'] 
        email = request_data['email']
        detail = request_data['detail']
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login("cip.2021.lme@gmail.com","lmelme123")
        message = 'Subject: {}\n\n{}'.format("Acknowledgement of report", f'Report status : Sent\n\nReport against : {name}\n\nDetail : {detail}')
        server.sendmail("cip.2021.lme@gmail.com",email,message)
        server.quit()
        response = f'Hi {name}! this is Python' 
        return " " 
   
@app.route('/cancel', methods = ['POST'])
def cancelRoute():

    
    global response
    
    if(request.method == 'POST'):
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) 
        email = request_data['email']
       
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login("cip.2021.lme@gmail.com","lmelme123")
        message = 'Subject: {}\n\n{}'.format("Service cancellation", f'Service status : Cancelled\n\nKindly avoid cancellation of service in future.\nIt will cause problems to the service providers.\n\n Thanking you,\nLME')
        server.sendmail("cip.2021.lme@gmail.com",email,message)
        server.quit()
        return " "

@app.route('/allotment', methods = ['POST'])
def allotmentRoute():

    global response
    
    if(request.method == 'POST'):
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) 
        email = request_data['email']
        print(email);
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login("cip.2021.lme@gmail.com","lmelme123")
        message = 'Subject: {}\n\n{}'.format("Service Allotment", f'Service status : Pending\n\nPlease check your pending details in LME app \n\nThanking you,\nLME')
        server.sendmail("cip.2021.lme@gmail.com",email,message)
        server.quit()
        return " "

@app.route('/urltest', methods = ['POST'])
def urltestRoute():

    global response
    
    if(request.method == 'POST'):
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) 
        url1 = request_data['url1']
        print(url1)
        net = cv2.dnn.readNet("yolov3.weights","yolov3.cfg")
        classes = []
        with open("coco.names","r") as f:
            classes = [line.strip() for line in f.readlines()]
        layer_names = net.getLayerNames()
        outputlayers = [layer_names[i[0]  - 1] for i in net.getUnconnectedOutLayers()]

        resp = urllib.request.urlopen(url1)
        image = np.asarray(bytearray(resp.read()),dtype="uint8")
        image = cv2.imdecode(image,cv2.IMREAD_COLOR)
        #process image
        #response = requests.get("https://firebasestorage.googleapis.com/v0/b/lifemadeeasier-4cf1d.appspot.com/o/varoonsb1311%40gmail.com%2FReport?alt=media&token=20b771c4-5c5d-4e2f-8305-887c37f4f08d")

        #file = open("sample_image.png", "wb")
        #file.write(response.content)
        #file.close()
        img = image #cv2.imread(resp)
        height, width, channels = img.shape
        #Object detection blob is to extract feature from the image
        blob = cv2.dnn.blobFromImage(img, 0.00392, (640, 480), (0, 0, 0), True, crop=False)

        #this blob is passed to yolo
        net.setInput(blob)
        outs = net.forward(outputlayers)


        #showing info
        class_ids=[]
        confidences = []
        objects = []
        for out in outs:
            for detection in out:
                scores = detection[5:]
                class_id = np.argmax(scores)
                confidence = scores[class_id]
                if confidence > 0.5: #0-1
                    center_x = int(detection[0] * width)
                    center_y = int(detection[1] * height)
                    w = int(detection[2] * width)
                    h = int(detection[3] * height)
                    x = int(center_x  - w/2)
                    y = int(center_y  - h/2)
                    #cv2.circle(img , (center_x,center_y), 10, (0,255,0), 2)
                    objects.append([x, y, w, h])
                    confidences.append(float(confidence))
                    class_ids.append(class_id)


        indexes = cv2.dnn.NMSBoxes(objects, confidences, 0.5, 0.4)#to reduce the multiple detection(noices)
        print(len(objects))
        print(indexes)
        for i in range(len(objects)):
            if i in indexes:
                x, y, w, h = objects[i]
                lable = str(classes[class_ids[i]])
                if (lable == 'microwave' or lable == 'refrigerator'):
                    print(lable)
        quit()
        return " "


@app.route('/progress', methods = ['POST'])
def progressRoute():

    global response
    
    if(request.method == 'POST'):
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) 
        email = request_data['email']
        name = request_data['name']
        ph_no = request_data['ph_no']
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login("cip.2021.lme@gmail.com","lmelme123")
        message = 'Subject: {}\n\n{}'.format("Service started", f'Service status : On progress\n\nDetails of the service providers are as follow :\n\nName : {name}\nPh.no : {ph_no} \n\nThanking you,\nLME')
        server.sendmail("cip.2021.lme@gmail.com",email,message)
        server.quit()
        return " "

@app.route('/complete', methods = ['POST'])
def completeRoute():

    global response
    
    if(request.method == 'POST'):
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) 
        email = request_data['email']
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login("cip.2021.lme@gmail.com","lmelme123")
        message = 'Subject: {}\n\n{}'.format("Service Completed", f'Service status : Finished\n\nKindly rate the service provider in the history tab. \n\nThanking you,\nLME')
        server.sendmail("cip.2021.lme@gmail.com",email,message)
        server.quit()
        return " "




if __name__ == "__main__":
    app.run(debug=True)