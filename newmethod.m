function newmethod 
mi = im2double(rgb2gray(imread('cover.jpg')));
A = rgb2gray(im2double(imread('cameraman.jpg')));
z=zeros(size(mi));
sig=0.001;
k1=0.5;
k2=0.5;
kp=100;
psnrt=45;
xmin=[ones(1,64),1-sig,-sig];
xmax=[64*ones(1,64),1+sig,sig];
n=length(xmax);
N=10*n;
Iter_max=10;
fontSize=15;
for u=1:N
%     F=0.2;
%     cr=0.4;
F=random('Normal',0.5789,0.05);
cr=random('Normal',0.1609,0.03);
    Ipop(u,1:n-2)=randperm(64);
    Ipop(u,n-1)=random('Normal',1,sig);
    Ipop(u,n)=random('Normal',0,sig);
    for i=1:64
    m=1;
    for t=1:8
        if Ipop(u,i)<=8*m
          break
        else
            m=m+1;
        end
    end
    nn=8-(8*m-Ipop(u,i));  
        mii=1;
    for t=1:8
        if i<=8*mii
          break
        else
            mii=mii+1;
        end
    end
    nii=8-(8*mii-i);
    z(8*(m-1)+1:8*m,8*(nn-1)+1:8*nn)=mi(8*(mii-1)+1:8*mii,8*(nii-1)+1:8*nii);
    end 
    
    C=Ipop(u,n-1)*A+Ipop(u,n)*z;
    zp=((C-Ipop(u,n-1)*A)/(Ipop(u,n)+eps));
    cost(u,1)=-(k1*psnr(C,A)+k2*psnr(z,zp))+kp*max(psnrt-psnr(z,zp),0)+kp*max(psnrt-psnr(C,A),0);
end
cost_min=min(cost);
loc_min=find(cost==cost_min);
best_solution=[Ipop(loc_min(1,1),:),cost_min];
for iter=1:Iter_max
    for u=1:N
        L=randperm(N-20);
        LL=find(L~=u);
        LLL=L(1,LL);
        k1=LLL(1);
        k2=LLL(2);
        k3=LLL(3);
        xmat(1,1:n-2)=Ipop(k1,1:n-2)+F*(Ipop(k2,1:n-2)-Ipop(k3,1:n-2));
        xmat(1,n+1:n+2)=rand(1,2)*Ipop(u,n-1)+rand(1,2)*Ipop(u,n);
        zz=randperm(n);
        for j=1:n
            if cr>rand || zz(1,1)==u
                x_new(1,j)=round(xmat(1,j));
            else
                x_new(1,j)=round(Ipop(u,j));
            end
        end
        zz=randperm(2);
        for j=1:2
            if cr>rand || zz(1,1)==u
                x_new(1,64+j)=(xmat(1,64+j));
            else
                x_new(1,64+j)=(Ipop(u,64+j));
            end
        end
        
        x_new=min(x_new,xmax);
        x_new=max(x_new,xmin);
        
            for i=1:64
    m=1;
    for t=1:8
        if x_new(1,i)<=8*m
          break
        else
            m=m+1;
        end
    end
    nn=8-(8*m-x_new(1,i));  
        mii=1;
    for t=1:8
        if i<=8*mii
          break
        else
            mii=mii+1;
        end
    end
    nii=8-(8*mii-i);
    z(8*(m-1)+1:8*m,8*(nn-1)+1:8*nn)=mi(8*(mii-1)+1:8*mii,8*(nii-1)+1:8*nii);
            end 
    C=x_new(1,n-1)*A+x_new(1,n)*z;
    zp=(1/(x_new(1,n)+eps))*(C-x_new(1,n-1)*A);
    cost_new=-(k1*psnr(C,A)+k2*psnr(z,zp))+kp*max(psnrt-psnr(z,zp),0)+kp*max(psnrt-psnr(C,A),0);
        if cost_new<cost(u,1)
            Ipop(u,:)=x_new;
            cost(u,1)=cost_new;
        end
        if best_solution(1,end)>cost_new
            best_solution=[x_new,cost_new];
        end
    end
end
% disp(best_solution(1,end))
subplot(2,2,1)
imshow(A)
title('Original cover Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
subplot(2,2,2)
imshow(C)
title('watermarked Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
subplot(2,2,3)
imshow(z)
title('disorgenized Original watermark Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
subplot(2,2,4)
imshow(zp)
title('disorgenized extracted watermark Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
psnrwatermarked=psnr(C,A)
psnrextracted=psnr(z,zp)
% %%
% [m,n] = size(zp);
% Blocks = cell(m/8,n/8);
% counti = 0;
% for i = 1:8:m-7
%    counti = counti + 1;
%    countj = 0;
%    for j = 1:8:n-7
%         countj = countj + 1;
%         Blocks{counti,countj} = zp(i:i+7,j:j+7);
%    end
% end
% original=zeros(64);
% [mw,nw] = size(original);
% Blockswat = cell(mw/8,nw/8);
% countiw = 0;
% for iw = 1:8:mw-7
%    countiw = countiw + 1;
%    countjw = 0;
%    for jw = 1:8:nw-7
%         countjw = countjw + 1;
%         Blockswat{countiw,countjw} = original(iw:iw+7,jw:jw+7);
%    end
% end
% [ra,ca]=size(Blocks);
% [rb,cb]=size(Blockswat);
% caa=ca;
% for k=2:ra
%     for d=1:ca
%         Blocks{1,caa+1}=Blocks{k,d};
%         caa=caa+1;
%     end
% end
% cab=cb;
% for kk=2:rb
%     for d=1:cb
%         Blockswat{1,cab+1}=Blockswat{kk,d};
%         cab=cab+1;
%     end
% end
% X=best_solution(1:64);
% for l=1:64
%     num=X(l);
%     bwatermark=l;
%     Blockswat{1,bwatermark}=Blocks{1,num};
% end
% B=cell2mat(Blockswat);
% figure
% imshow(B)
%%encoder
imwrite(C,'D:\nimsale avale 96-97\thesis\implementation\optimizationDE\implementation\Watermarked.bmp');
save best_solution
save psnrwatermarked
imwrite(zp,'D:\nimsale avale 96-97\thesis\implementation\optimizationDE\implementation\extracted.bmp');
end

