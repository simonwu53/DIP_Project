

import cv2
import sys
import argparse

parser = argparse.ArgumentParser(description='image argument')
parser.add_argument('image', metavar='im', type=str, nargs='+',
                   help='Image input')
args = parser.parse_args() 


                  
#Create the haar cascade
cascPath = "haarcascade_frontalface_default.xml"
faceCascade = cv2.CascadeClassifier(cascPath)

# Read the image
image = cv2.imread(args.image[0])
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# Detect faces in the image
faces = faceCascade.detectMultiScale(
    gray,
    scaleFactor=1.05,
    minNeighbors=2,
    minSize=(10, 10),
    #flags = cv2.cv.CV_HAAR_SCALE_IMAGE
)


# Draw a rectangle around the faces\
for (x, y, w, h) in faces:
    
    face = cv2.rectangle(image, (x, y), (x+w, y+h), (0, 255, 0), 2)
    cv2.imwrite("src/image_fd.jpg", face)
    if id:
        key = 1
    else:
        key = 0
    cv2.waitKey(key)


#send back the number of faces found
sys.stdout.write(str(len(faces)))






