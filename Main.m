I = imread("pepper.bmp");
I = rgb2gray(I);    %converting into greyscale image
size(I)
A = imnoise(I, "gaussian",0.1,0.01);%adding white gaussian noise in the image
                                       %with mean 0.1 and variance 0.01
size(I)
B = variational_denoiser(A,100,4,0.05,0.999,0.99,0.03,0.03,30);%denoiser
C = wiener2(A,[5,5]);
D = imsmooth(A,"Average");
E = imsmooth(A,"Perona and Malik");
F = imsmooth(A, "Gaussian");
imshow(I)
title('Original Image')
figure, imshow(A)
title('Noised Image')
figure, imshow(B)
title('Variational Denoiser')
figure, imshow(C)
title('Wiener Filter Denoiser')
imshow(B)
title('Average Filter Denoiser')
figure, imshow(E)
title('Perona and Malik Denoiser')
figure, imshow(F)
title('2D Gaussian Filter Denoiser')
NE1 = sqrt(sum(sum((A - I).^2)))
NE2 = sqrt(sum(sum((B - I).^2)))
NE3 = sqrt(sum(sum((C - I).^2)))
NE4 = sqrt(sum(sum((D - I).^2)))
NE5 = sqrt(sum(sum((E - I).^2)))
NE6 = sqrt(sum(sum((F - I).^2)))