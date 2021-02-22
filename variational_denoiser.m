function [denoised_image] = variational_denoiser(I,alpha,k,neta,beta,gamma,nu,lambda,N)
  I = uint8(I); %converting into 8-bit image
  u = I;
  [X Y Z] = size(I);
  for t=1:N
    o = zeros(X,Y,Z);
    o(1:X-1,:,:) = u(2:X,:,:);
    c1 = o - u;
    o = zeros(X,Y,Z);
    o(2:X,:,:) = u(1:X-1,:,:);
    c2 = o - u;    
    o = zeros(X,Y,Z);
    o(:,1:Y-1,:) = u(:,2:Y,:);
    c3 = o - u;
    o = zeros(X,Y,Z);
    o(:,2:Y,:) = u(:,1:Y-1,:);
    c4 = o - u;
    del1 = (sqrt(beta*(norm(double(c1))^2) + gamma) + neta*sqrt(k))/(sqrt(beta*(norm(double(c1))^2) + gamma));
    del2 = (sqrt(beta*(norm(double(c2))^2) + gamma) + neta*sqrt(k))/(sqrt(beta*(norm(double(c2))^2) + gamma));
    del3 = (sqrt(beta*(norm(double(c3))^2) + gamma) + neta*sqrt(k))/(sqrt(beta*(norm(double(c3))^2) + gamma));
    del4 = (sqrt(beta*(norm(double(c4))^2) + gamma) + neta*sqrt(k))/(sqrt(beta*(norm(double(c4))^2) + gamma));
    u = u + lambda*(del1*c1 + del2*c2 + del3*c3 + del4*c4) - (u-I)/alpha;
  endfor
  denoised_image = uint8(u);%converting into 8-bit image
endfunction
