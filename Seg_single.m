img_path = 'E:\code\matlab\����\getword\data\3.png'; 
img=imread(img_path); %Img=imread('30test.png')
    %2.��ͼ�������ֵ�ָ�õ���ֵͼ��
   %img = region_yuzhi(img);
   %3.����������ȥ��
   %img = RG(img);
    %4.��ȥͼ���Ե�ĺڱ�
  img = RemoveEdge(img);

    %5.��ȡ��ͼƬÿһ�еĺ�
    col=sum(img); 
   %6.�и��ַ������������
   %ͼƬ�Ŀ��
   [height,width] = size(img);
   %��ʼλ��left
   left = 0;
   %����ʼλ������ֹΪֹ�ƶ���ָ��index,��ֵ��0.85���ַ������1.15���ַ����֮��
   index = 1;%0.85*40=34��1.15*40=46
    %�ַ����
    lw = 40;
    %���� cell�ṹ���洢�и���ַ� 
    Letter = cell(1,17);
    %seg����洢ÿ���ַ�����ʼ����ֹλ��
    seg = zeros(2,17);

for i = 1:17;    
index = 1; 
        %ָ��С�������ַ��Ŀ��
        %Ѱ���ַ�����߽磬
         while col(left + index)==0 
             %��¼��һ����Ԫ��ֵ��Ϊ0������
             index = index+1;  
         end
         %��0��ǰһ��λ��
         left = left + index - 1; %�ַ��ָ�����־��
         %�ҵ���߽��ָ������
         %����ַ������ѵ����
         index = 20;
         %�ж���һ���ַ������colΪ0��λ�ã�����ָ�벻�ܳ���ͼƬ���
         while ((col(left+index))~=0) && (index<=2*lw-1) && ((left + index)<width) %��������������������δ����Ƿ�Ӧ���趨һ����ֵ��
             index = index+1;
         end
         

         %�ж��Ƿ����ַ�ճ����һ����
         %����ַ���ȴ���1.5�����ַ�������Ϊ��ճ��
         if (index >= 1.2*lw)
             %������Ҫ���left:left+index֮����Сֵ��λ��
            [val,num] = min(col(1,left+lw*0.85:left+lw*1.15));   
            % Lw =num - Left_index; %���㵱ǰ��ĸ��ʵ�ʿ�ȣ�����Ϊ��һ����ĸ�Ŀ�ȵĲο�ֵ�� %����ʵ��������Ƿ���øò��ԣ�����ȡ���������Ķ��١�
            index = num + lw*0.85;
         end
          Letter{i} =  img(:,left:left+index); %���ַ��и����
          %seg(1,i) = left;
          left = left + index;
          %seg(2,i) = left;
          subplot(5,4,i),imshow(Letter{i});
end