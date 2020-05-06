function [ K ] = RG( I )
%RG ����������ȥ��ϸС����
    I = im2double(I); %ͼ��Ҷ�ֵ��һ����[0,1]֮��
    [h,w] = size(I); 
    J = zeros(size(I));%�����жϵ��Ƿ��ѱ����ʹ���ͼƬ
    K = J;%���ڸ������������ͼ��
    Isizes = size(I);
    neg_free = 10000; %��̬�����ڴ��ʱ��ÿ������������ռ��С
    neg_list = zeros(neg_free,2);%���������б�����Ԥ�ȷ������ڴ�������������ص������ֵ�ͻҶ�ֵ�Ŀռ䣬����
    %���ͼ��Ƚϴ���Ҫ���neg_free��ʵ��matlab�ڴ�Ķ�̬����
    point = 0;%���ڼ�¼��Ч���ص�ĸ���
    index = 0;
    list = neg_list;
    neigb = [ -1 0;
              1  0;
              0 -1;
              0  1];
    for m =1:w%������ͼƬ����ɨ�裬�ȹ̶���ȣ�Ҳ��������ɨ��
        for n = 1:h
            x = n;
            y = m;
            while (I(x,y) == 1)
            %�����µ��������ص�neg_list��
                J(x,y) = 1;
                for j=1:4    %�����Ƿ���������
                    xn = x + neigb(j,1);
                    yn = y + neigb(j,2);
                    ins = (xn>=1)&&(yn>=1)&&(xn<=h)&&(yn<=w);%������������Ƿ񳬹���ͼ��ı߽�

                    if( ins && J(xn,yn) == 0 && I(xn,yn) == 1) %�������������ͼ���ڲ���������Ԫֵ��Ч����ô������ӵ������б���
                         point = point + 1;
                         index = index + 1;
                         neg_list(index,:) = [xn, yn];%�洢����Ҫ�����������
                         list(point,:) = [xn, yn];
                         J(xn,yn) = 1;%��ע���������ص��Ѿ������ʹ� ������ζ�ţ����ڷָ�������
                    end
                end
                    %ָ���µ����ӵ�
                if(index == 0)
                    break;
                end
                x = neg_list(index,1);
                y = neg_list(index,2);
                    %���µ����ӵ�Ӵ����������������б����Ƴ�
                index = index -1;
            end

            if(point > 40)    %�����Ч��Ԫ����ֵ����10������ô����Ϊ�ҵ�����ͨ��Ŀ�����򣬿�ʼ���и�ֵ
                for i = 1:point
                         %��־�����ص��Ѿ��Ƿָ�õ����ص�
                         x = list(i,1);
                         y = list(i,2);
                         K(x,y)=1;
                end        
            end
                        point = 0;
                        neg_list = zeros(neg_free,2);
                        list = neg_list;
       end
    end
end

