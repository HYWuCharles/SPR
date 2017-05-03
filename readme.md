# SPR

## 软件无线电实现
## 结构为： 读取图片 -> 图片加密（混沌加密） -> 信源编码（霍夫曼）-> 信道编码  -> 射频调制   -> 信道传输 -> 接收机下变频 -> 相干解调 -> 信道码解码 -> 信源码解码 -> 解密 -> 得到消息

### 文件：encode
params：输入文件路径
return：加密后的图片信息矩阵，图片宽、高

### 文件：generate_huffman
params：待编码数据
return：编码中产生的霍夫曼编码字典

### 文件：decode
params：信息矩阵
return：解密后的图片信息矩阵

### 文件：source_coding_decoding
params：所要编码的数据，所要实现的模式（编码或解码）
return：经霍夫曼编码后的数据矩阵（或解码后的数据）

### 文件：modulate
params：所要调制的信号矩阵，调制方式（QAM，QPSK）
return：调制后的行向量，在调制时所补的零的个数

### 文件：demod
params：所要解调的信号数据，模式
return：解调之后的数据

### 文件：channal_encode
params：待信道编码数据
return：卷积编码后的数据（也可CRC编码，但未实现）

### 文件：channel_encode
params：待编码输入，编码方式（目前仅支持卷积码）
return：信道编码之后的数据

### 文件：channel
params：所要经过信道的数据
return：加入高斯白噪声之后的数据

### 文件：fixed
params：待处理的数据
return：去掉末尾原补的零

## 困难&问题
1. 在霍夫曼编码时，默认信宿处得知编码字典，不知道如何将字典传至信宿处
2. 在信道编码时，未实现CRC码的纠错功能
3. 在调制时若补零，则不知如何将其补零个数传至信宿
构想：在发送信号时其头部含有报头，例如HTTP协议的报头，给信宿解释所收到的信息


