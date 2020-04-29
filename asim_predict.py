import joblib
import numpy
import urllib.request
import sys

noShowModel = joblib.load('predict.pkl')

test = numpy.array([0, 23, 42, 1, 1, 0, 1, 0, 0, 0, 3, 11]).reshape(1,-1)

newpatientappt = numpy.array([sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5], sys.argv[6], sys.argv[7], sys.argv[8],
sys.argv[9], sys.argv[10], sys.argv[11], sys.argv[12]]).reshape(1,-1)

try:
    noshowpredict = noShowModel.predict(newpatientappt)
    print(noshowpredict[0])
    sys.stdout.flush()
except: 
    print(newpatientappt)
    sys.stdout.flush()

# p = noShowModel.predict(test)

# print(test)
# print(p[0])