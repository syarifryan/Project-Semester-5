img = imread('o.jpg');
grayscale = rgb2gray(img);
[M,N]=size(grayscale);
B_seg = zeros(M,N);
for k = 1 : M
   for l = 1 : N
     if grayscale(k,l)<120 
         B_seg(k,l)=1;
      else
         B_seg(k,l)=0;
      end
   end
end

subplot(1,4,1),imshow(img);
subplot(1,4,2),imshow(grayscale);
subplot(1,4,3),imhist(grayscale);
subplot(1,4,4),imshow(B_seg);
