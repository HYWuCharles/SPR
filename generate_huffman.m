function dict = generate_huffman(data)

[M,N] = size(data);
imagel = data(:);
P = zeros(1,256);
for i = 0:255
  P(i+1) = length(find(imagel == i))/(M*N);
end
k = 0:255;
dict = huffmandict(k,P); 
end