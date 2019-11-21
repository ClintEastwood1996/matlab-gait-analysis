function [Center, BC, bw] = obj_count(video, frameNo)
    frame = read(video, frameNo);%функция для чтения кадра
    grayimg = rgb2gray(frame);%перевод цветного изобр в полутон
    porog0 = graythresh(grayimg);
    try
        bw = im2bw(grayimg, porog0-0.1);% бинаризация с заданным порогом
    catch
        bw = im2bw(grayimg, porog0);
    end
    bw = imfill(bw,'holes');%заполнение отверстий на бинар. изобр
    se = strel('disk',1);%создание формы DISC с радиусом 1
    bw = imopen(bw,se);%морфол. открытие "уходят линии
    Center = regionprops(bw, 'Centroid', 'BoundingBox');%определение цетнра                                                    %масс объектов 
    BC = length(Center);%кол-во объектов
end