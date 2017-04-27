# SPR

## 软件无线电实现
## 结构为： 读取图片 -> 图片加密（混沌加密） -> 信源编码（霍夫曼） -> 射频调制 -> 信道传输 -> 接收机下变频 -> 相干解调 -> 解码 -> 解密 -> 得到消息

### 文件：encode
params：输入文件路径
return：加密后的图片信息矩阵

### 文件：decode
params：信息矩阵
return：解密后的图片信息矩阵

### 文件：img2bins
params：所要编码的数据
return：经霍夫曼编码后的数据矩阵

### 文件：modulate
params：所要调制的信号矩阵，调制方式（QAM，QPSK）
return：调制后的行向量

### 文件：convcode
params：卷积码输入
return：卷积编码后的数据

### 文件：channel_encode
params：待编码输入，编码方式（目前仅支持卷积码）
return：信道编码之后的数据

