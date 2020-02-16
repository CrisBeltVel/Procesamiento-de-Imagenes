
A = imread('1_Nature.jpg');
a= rgb2gray(A);
[m,n] = size(a);


%punto1_grises(A,a)
%punto2_histograma();
%punto3_reduccion(A,a,m,n)
%punto4_Iluminacion();
%punto5_vecindad(a,m,n)
%punto6_Redux_resol(a,m,n)

%c=20; punto7_Constante(c);
 punto8_Diferencia(a);



function []= punto1_grises(A,a)
figure(1), subplot(1,2,1),imshow(A),title("Imagen Original")
figure(1), subplot(1,2,2),imshow(a),title("Imagen en escala de grises");
end

function []= punto2_histograma()
A = imread('1_Nature.jpg');
a= rgb2gray(A);
[m,n] = size(a);
inc =0;
temp=0;
frecuencia =zeros(256,1);

for f=1:m
  for c=1:n
   inc=inc+1;
    a_vec(inc)=a(f,c);
  end
end

    for i = 1: inc 
      for j = 1: inc-i 
            if a_vec(j) > a_vec(j+1)
                temp = a_vec(j+1);
                a_vec(j+1) = a_vec(j);
                a_vec(j) = temp;
            end
       end
    end
    a_vec=int16(a_vec);

 for k=1: inc
     pos= a_vec(k);
     frecuencia(pos+1)=frecuencia(pos+1)+1; 
 end
 x=0:255;
 x = transpose(x);
 
figure(3),bar(x,frecuencia)


Q = imread('1_Nature.jpg');
q= rgb2gray(Q);
figure(2),imhist(q)

end

function []= punto3_reduccion(A,a,m,n)

m2= round(m/2)-1;
nfa=0;
for nf=1:m2
    nfa=nfa+1;
   a(nfa,:)=[];
end

n2= round(n/2)-1;
nfa=0;
for nf=1:n2
    nfa=nfa+1;
   a(:,nfa)=[];
end
whos
figure(1), subplot(1,2,1),imshow(A),title("Imagen Original")
figure(1), subplot(1,2,2),imshow(a),title("Imagen en reducida")


end

function [] = punto4_Iluminacion()

G = imread('1_Nature.jpg');
g =rgb2gray(G);

titulos = ["256 Niveles","128 Niveles","64 Niveles","32 Niveles","16 Niveles","8 Niveles","4 Niveles","2 Niveles","1 Niveles" ]


for i=0:7
newbits=2^(8-i)-1;
imgredux= floor(g./2^i);
figure(i+1), imshow(imgredux,[0 newbits]), title(titulos(i+1))  ;
end

end
 
%Md = [0 14 3 13;11 5 8 6; 2 12 1 15; 9 7 10 4];

%https://www.uv.es/gpoei/eng/Pfc_web/generalidades/dithering.htm
%https://www.lpi.tel.uva.es/~nacho/docencia/ing_ond_1/trabajos_03_04/sonificacion/cabroa_archivos/cuantizacion.html
% [m,n] = size(g);
%     for F=1:m
%         x= mod(F,4);
%         for C=1:n
%             in= g(F,C);
%               b0=in/16;
%             
%             if b0>= 0
%                 b1=0;
%             else
%                 b1= b0+1;
%             end
%             vi=in & 0;
%              y= mod(C,4);
%             if vi > Md(x+1,y+1)
%                 s(F,C)=b1;
%             else
%                 s(F,C)=b0;
%             end
%             
%         end
%     end
%     


%  figure(1),imshow(s)

% figure(1), subplot(2,4,1),imshow(g/2)
% 
% figure(1), subplot(2,4,2),imshow(g/4)
% 
% figure(1), subplot(2,4,3),imshow(g/8)
% 
% figure(1), subplot(2,4,4),imshow(g/16)
% 
% figure(1), subplot(2,4,5),imshow(g/32)
% 
% figure(1), subplot(2,4,6),imshow(g/64)
% 
% figure(1), subplot(2,4,7),imshow(g/128)
% 
% figure(1), subplot(2,4,8),imshow(g/256)





%figure(11), imagesc((g/256)>0.40), axis image, colormap gray


% [m,n] = size(g);
%     for F=11:m
%         for C=11:n
%             if g(F,C)>=16 && g(F,C)<255
%                 g(F,C)=g(F,C)/16;
%             end
%         end
%     end
% 
% 
% whos
% figure(3),imshow(g); 
% figure(4),imshow(G); 



function [] = punto5_vecindad(a,m,n)

H = fspecial('motion',20,45); MotionBlur = imfilter(a,H,'replicate');figure(21),  imshow(MotionBlur), title("Funcion fspecial");
w=a;
u=a;
suma=0;


%3x3

z=zeros(m,1);
a3=[z a];
a3=[a3 z];
[m3,n3] = size(a3);
z=zeros(1,n3);
a3=[z;a3];
a3=[a3;z];
a3=double(a3);

[m3,n3] = size(a3);

for F=2:m-1
   for C=2:n-1 
     for fa=F-1:F+1
        for ca=C-1:C+1
          suma=a3(fa,ca)+suma;
        end
     end
     b(F-1,C-1)= suma/9;
     suma=0;
   end
end
 

 b=uint8(b)
 a3=uint8(a3);
 figure(4),imshow(a3); title("Imagen Original")
 figure(5),imshow(b);title("Imagen 3x3")

 
 
%  
%  10x10
 
z=zeros(m,4);
a10=[z a];
a10=[a10 z];
[m10,n10] = size(a10);
z=zeros(4,n10);
a10=[z;a10];
a10=[a10;z];

suma=0;
a10=double(a10);
[m10,n10] = size(a10);

     for F=5:m10-5
        for C=5:n10-5
            for f=F-4:F+4
                for c=C-4:C+4
                    suma=a10(f,c)+suma;
                end
            end
            w(F-4,C-4)=suma/100;
            suma=0;
        end
     end
     w
     whos

 w=uint8(w);
figure(10),imshow(w);title("Imagen 10x10")


 %20x20
z=zeros(m,9);
a20=[z a];
a20=[a20 z];
[m20,n20] = size(a20);
z=zeros(9,n20);
a20=[z;a20];
a20=[a20;z];
a20=double(a20);
[m20,n20] = size(a20);

      for F=10:m20-10
        for C=10:n20-10
            for f=F-9:F+9
                for c=C-9:C+9
                   suma=a20(f,c)+suma;
                end
            end
            u(F-9,C-9)=suma/400;
            suma=0;
        end
     end


 u=uint8(u);

figure(20), imshow(u);title("Imagen 20x20")

 

%  
%  
% %  figure(1), subplot(2,4,2),imshow(A),title("Imagen Original")
% % figure(1), subplot(2,4,5),imshow(a),title("Imagen en escala de grises");
% % figure(1), subplot(2,4,6),imshow(b),title("Imagen en escala 3x3");
% 
% 
% 
% 
% end
%  
% function [] = punto6_Redux_resol(a,m,n)
% a=double(a);
%  suma=0;
%  r=1;
%  j=1;
% 
% for F=2:3:m-3
%     fj = F-j;
%    for C=2:3:n-3 
%      for f=F-1:F+1
%         for c=C-1:C+1
%           suma= a(f,c)+suma;
%         end
%      end
%      cr= C-r;
%      s(fj,cr)= suma/9;
%      r=r+2;
%      suma=0;
%    end
%    j=j+2;
%    r=1;
% end
% 
%  a=uint8(a);
%  s=uint8(s);
% 
% figure(20), imshow(s);
% figure(2),imshow(a); 
% whos
% end
% 
% function [] = punto7_Constante(c)
% V = imread('Vela.jpg');
% v= rgb2gray(V);
% figure(4),imshow(v); 
%      v(:,:)=v(:,:)*c;
% figure(3),imshow(v); 
% end
% 
% function [] = punto8_Diferencia(a)
% 
% b = imrotate(a,2,'bicubic','crop');
% c=a-b;
% 
% figure(1), subplot(2,3,2),imshow(a),title("Imagen Original")
% figure(1), subplot(2,3,4),imshow(b),title("Imagen rotada");
% figure(1), subplot(2,3,6),imshow(c),title("Imagen Diferenciada");

end

 
function [] = punto6_Redux_resol(a,m,n)
a=double(a);
 suma=0;
 r=1;
 j=1;

for F=2:3:m-3
    fj = F-j;
   for C=2:3:n-3 
     for f=F-1:F+1
        for c=C-1:C+1
          suma= a(f,c)+suma;
        end
     end
     cr= C-r;
     s(fj,cr)= suma/9;
     r=r+2;
     suma=0;
   end
   j=j+2;
   r=1;
end

 a=uint8(a);
 s=uint8(s);

figure(20), imshow(s);
figure(2),imshow(a); 
whos
end

function [] = punto7_Constante(c)
V = imread('Vela.jpg');
v= rgb2gray(V);
figure(4),imshow(v); 
     v(:,:)=v(:,:)*c;
figure(3),imshow(v); 
end

function [] = punto8_Diferencia(a)


A = imread('I_diferente_A.JPG');
B = imread('I_diferente_B.JPG');

a= rgb2gray(A);
b= rgb2gray(B);

[m,n] = size(a);
[j,k] = size(b);

nm=abs(j-m);
nn=abs(k-n);
c=a-b;


if j>m 
    for i=1:nm
    b(j-nm,:)=[];
    end
else
    for i=1:nm
    a(j-nm,:)=[];
    end
end


if k>n
  for i=1:nn
  b(:,k-nn)=[];
  end
else
    for i=1:nn
  a(:,k-nn)=[];
  end
end

 b=double(b);
 a=double(a);
 
for f=1:m
  for c=1:n
      umbral= abs(a(f,c)-b(f,c));
    if umbral<3     
       e(f,c)=0;
    else
        e(f,c)=a(f,c);
    end
  end
end

a=uint8(a);
b=uint8(b);
e=uint8(e);



figure(1), subplot(2,3,2),imshow(a),title("Imagen Original")
figure(1), subplot(2,3,4),imshow(b),title("Imagen rotada");
figure(1), subplot(2,3,6),imshow(e),title("Imagen Diferenciada");

end


% 
% a=[222,120,100,68,205,190,165,121;220,36,122,65,170,155,245,72;64,210,58,96,54,181,236,101;89,100,80,97,32,111,214,105;111,21,55,61,111,62,198,178;22,33,66,105,155,65,69,222;68,25,89,75,36,145,33,200;250,220,11,29,192,25,222,230]
% 
% whos
% hist(a);
% [C,ia,ic] = unique(a);
% a_counts = accumarray(ic,1);
% value_counts = [C, a_counts]



