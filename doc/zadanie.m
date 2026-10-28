close all
% trójkąty rotacja
figure(1);
t1 = (imread('triangle1.png'));
t1 = t1(:, :, 1);
j = 0;
s1 = 'trojkaty';
for i=1:25:91
    j = j+1;
    t1r = imrotate(t1,i-1,'crop');
    L1 = fftshift(fft2(t1r));
    subplot(2,4,j)
    s1=strcat('kąt=',num2str(i-1));
    imshow(t1r,[])
    title(s1);
end
subplot(2,4,1)
ylabel('Trójkąty rotacja');
sc= int8(-150 + 250.*rand(4,2));
for i=1:4
j=j+1;
t1t=imtranslate(t1,sc(i,:));
L1=fftshift(fft2(t1t));
subplot(2,4,j)
imshow(t1t,[])
end
subplot(2,4,5)
ylabel('Trójkąty translacja');

% * kółko i linie *
t2 = imread("circle1.png");
t2 = t2(:,:,1);
t3 = imread("lines.png");
t3 = t3(:,:,1);
% * kółko i linie *
scales = [0.5, 0.8, 1.2, 1.5];
angles = [0, 30, 60, 90];
target_size = 512; % Docelowy rozmiar płótna
figure(2);

for j = 1:4
    t_temp = imresize(t2, scales(j));
    [h, w, ~] = size(t_temp);
    t2r = zeros(target_size, target_size, class(t2));
    
    if h <= target_size
        r = floor((target_size - h)/2) + (1:h);
        c = floor((target_size - w)/2) + (1:w);
        t2r(r, c) = t_temp;
    else
        r = floor((h - target_size)/2) + (1:target_size);
        c = floor((w - target_size)/2) + (1:target_size);
        t2r = t_temp(r, c);
    end
    
    subplot(2, 4, j);
    imshow(t2r, []); axis image;
    title(['Skala = ', num2str(scales(j))]);
    
    subplot(2, 4, j + 4);
    imshow(imrotate(t3, angles(j), 'crop'), []); axis image;
    title(['Kąt = ', num2str(angles(j))]);
end

subplot(2, 4, 1); ylabel('Koła różnej wielkości');
subplot(2, 4, 5); ylabel('Linie rotacja');

figure(3);

a=10*[1 -1 2 -4000];
b=5* [1 1 4 2];
subtitle('Sinus');
j=0; 
for i=1:4
    for u = 1:512
        for v=1:512
        a1(u,v)=uint8(127+128*sin(u/a(i)+v/b(i)));
        end
    end
    j=j+1;
    subplot(1,4,j)
    s1=strcat('a,b=',num2str(a(i)),',',num2str(b(i))) ;
    imshow(a1,[])
    title(s1);
end

% scales = [0.5, 0.8, 1.2, 1.5];
% angles = [0, 30, 60, 90];
% figure(2);
% for j = 1:4
%     t2r = imresize(t2, scales(j));
%     subplot(2,4,j)
%     imshow(t2r, [])
%     axis image;
%     title(['Skala = ', num2str(scales(j))]);
%     t3r = imrotate(t3, angles(j), 'crop');
%     subplot(2, 4, j + 4);
%     imshow(t3r, []);
%     title(['Kąt = ', num2str(angles(j))]);
% end
% 
% subplot(2,4,1)
% ylabel('Koła różnej wielkości');
% subplot(2,4,5)
% ylabel('Linie rotacja');
% saveas(figure(1), 'testowe1.png');
% saveas(figure(2), 'testowe2.png');
% saveas(figure(3), 'testowe3.png');

% zad2 - Analiza obrazów z wykorzystaniem widma mocy
%****** rotacja i translacja - trojkaty ****
figure
sgtitle("Trójkąty rotacja i translacja");
t1 = imread('triangle1.png');
t1 = t1(:, :, 1);
angles_tri = [0, 25, 50, 75];
sc = int8(-150 + 250.*rand(4,2));

for i=1:4
    g1 = imrotate(t1, angles_tri(i), 'crop');
    subplot(3,4,i)
    imshow(g1);
    s1=strcat('kąt=',num2str(angles_tri(i)));
    title(s1);
    subplot(3,4,i+4);
    L1=fftshift(fft2(g1(:,:,1)));
    imshow(log(1+abs(L1)),[]);
    subplot(3,4,i+8)
    imshow(angle(L1),[]);
end
subplot(3,4,5)
ylabel('Widmo mocy');
subplot(3,4,9)
ylabel('Faza');

figure
sgtitle("Trójkąty translacja");
for i=1:4
    g1=imtranslate(t1, sc(i,:));
    subplot(3,4,i)
    imshow(g1);
    subplot(3,4,i+4);
    L1=fftshift(fft2(g1(:,:,1)));
    imshow(log(1+abs(L1)),[]);
    subplot(3,4,i+8)
    imshow(angle(L1),[]);
end
subplot(3,4,5)
ylabel('Widmo mocy');
subplot(3,4,9)
ylabel('Faza');

%****** skala - kola ****
figure
sgtitle("Koła skala");
scales = [0.5, 0.8, 1.2, 1.5];
target_size = 512;
circle_size = cell(1, 4);
for i=1:4
    t_temp = imresize(t2, scales(i));
    [h, w, ~] = size(t_temp);
    g1 = zeros(target_size, target_size, class(t2));
    if h <= target_size
        r = floor((target_size - h)/2) + (1:h);
        c = floor((target_size - w)/2) + (1:w);
        g1(r, c) = t_temp;
    else
        r = floor((h - target_size)/2) + (1:target_size);
        c = floor((w - target_size)/2) + (1:target_size);
        g1 = t_temp(r, c);
    end
    circle_size{i} = g1;
    subplot(3,4,i)
    imshow(g1, []);
    title(['Skala = ', num2str(scales(i))]);
    subplot(3,4,i+4);
    L1=fftshift(fft2(g1(:,:,1)));
    imshow(log(1+abs(L1)),[]);
    subplot(3,4,i+8)
    imshow(angle(L1),[]);
end
subplot(3,4,5)
ylabel('Widmo mocy');
subplot(3,4,9)
ylabel('Faza');

%****** linie rotacja ****
figure
sgtitle("Linie rotacja");
angles = [0, 30, 60, 90];
for i=1:4
    g1=imrotate(t3, angles(i), 'crop');
    subplot(3,4,i)
    imshow(g1, []);
    s1=strcat('kąt=',num2str(angles(i)));
    title(s1);
    subplot(3,4,i+4);
    L1=fftshift(fft2(g1(:,:,1)));
    imshow(log(1+abs(L1)),[]);
    subplot(3,4,i+8)
    imshow(angle(L1),[]);
end
subplot(3,4,5)
ylabel('Widmo mocy');
subplot(3,4,9)
ylabel('Faza');

%****** sinusy ****
figure
sgtitle('Sinus');
a=10*[1 -1 2 -4000];
b=5* [1 1 4 2];
for i = 1:4
    for u = 1:512
        for v = 1:512
            a1(u, v) = uint8(127+128*sin(u/a(i) + v/b(i)));
        end
    end
    subplot(3, 4, i)
    s1 = strcat('a,b = ', num2str(a(i)), ',', num2str(b(i)));
    imshow(a1, [])
    title(s1);
    subplot(3,4,i+4);
    L1=fftshift(fft2(a1(:,:,1)));
    imshow(log(1+abs(L1)),[]);
    subplot(3,4,i+8)
    imshow(1+abs(L1),[]);
end
subplot(3,4,5)
ylabel('Widmo mocy');
subplot(3,4,9)
ylabel('Widmo bez log');