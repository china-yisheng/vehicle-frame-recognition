# -*- coding: utf-8 -*-
"""
Created on Fri Apr  3 17:58:16 2020

@author: Wang
"""



import skimage.io
import skimage.color
import skimage.transform

import numpy as np
import os
import random

import keras

from keras import backend as K

from keras.models import load_model

from PIL import Image


# DATASET_DIR = 'E:/code/python/chepai/dataset/carplate'#数据集的位置

TEST_DIR = 'E:/code/python/chepai/DATA/'

# classes = os.listdir(DATASET_DIR + "/ann/")#类别
# =============================================================================
# data = []
# for cls in classes: #这一段循环是给每一个图片增加类别
#     files = os.listdir(DATASET_DIR + "/ann/"+cls)
#     for f in files:
#         img = skimage.io.imread(DATASET_DIR + "/ann/"+cls+"/"+f)
#         img = skimage.color.rgb2gray(img)
#         data.append({
#             'x': img,
#             'y': cls
#         })
# =============================================================================
#这里增加自己的测试数据
# classes1 = os.listdir(TEST_DIR + "/ann/")#类别
data1 = []
# for cls in classes1: #这一段循环是给每一个图片增加类别
files = os.listdir(TEST_DIR)
for f in files:
  img = skimage.io.imread(TEST_DIR+f)
  img = skimage.color.rgb2gray(img)
  data1.append({
             'x': img,
#             'y': cls
         })
print(len(files))

#random.shuffle(data)    #打乱顺序
#random.shuffle(data1)

#X = [d['x'] for d in data]  #获取图片
#y = [d['y'] for d in data]  #获取图片类别

X1 = [d['x'] for d in data1]  #获取图片-测试数据集
#y1 = [d['y'] for d in data1]  #获取图片类别-测试数据集


#ys = list(np.unique(y))     #这里是获取图片的类别总数，0~9，A~Z
#y = [ys.index(v) for v in y]    #这里把每个图片的类别用数字表示

#y1 = [ys.index(v) for v in y1]

y = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G',
 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

#x_test = np.array(X[int(len(X)*0.8):])  #测试集的图片
#y_test = np.array(y[int(len(X)*0.8):])  #测试集的类别

x_test = np.array(X1[:])  #测试集的图片
#y_test = np.array(y1[:])  #测试集的类别

batch_size = 128                    
#num_classes = len(classes)      #类别的个数
epochs = 30

# input image dimensions
img_rows, img_cols = 20, 20     #输入图片的维度

def extend_channel(data):   #这里好像是对图片进行标准化，规范大小，但是后面又加上了一维，赋值为1
    if K.image_data_format() == 'channels_first':   #这一句判断不太明白
        data = data.reshape(data.shape[0], 1, img_rows, img_cols)
    else:
        data = data.reshape(data.shape[0], img_rows, img_cols, 1)
        
    return data


x_test = extend_channel(x_test)


   #转换类型
x_test = x_test.astype('float32')       #转换类型
                    
x_test /= 255                           #归一化

print(x_test.shape[0], 'test samples')

model = load_model('char_cnn_6G.h5')

predictions = model.predict_classes(x_test, verbose=0)
#print(predictions)
#score = model.evaluate(x_test, y_test2, verbose=0)

#print('Test loss:', score[0])
#print('Test accuracy:', score[1])

#model.save_weights('char_cnn.h5')
out_dir = 'E:/code/python/chepai/dataset_liu/ann2/'
a = []
i = 0
while i < len(predictions):
    a.append(y[predictions[i]])
    i = i + 1
i = 0
while i<len(X1):
   L = Image.fromarray(X1[i])
   savedir = out_dir+str(a[i])+'/';
   if not os.path.exists(savedir):
       os.makedirs(savedir)
   L.save(savedir+str(i)+'.png')
   i = i + 1

