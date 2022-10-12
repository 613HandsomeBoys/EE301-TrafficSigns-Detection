clear;clc;close all;

%%

Name = {'禁止机动车通行','禁止停车','禁止左转弯'...
    'T型路口','窄桥，限制6吨','注意行人'...
    '人行横道','向右转弯','右侧行驶'}; % 这个编号号 第一个就对应 1.png 第二个就是2.png 

Num = 9; % 标识图片个数
Image = cell(1,Num); % 用来存放图像

Scale = 40; % 统一处理图片大小

Data = zeros(Scale*Scale,Num);

figure
for i = 1:Num
        
    Image{i} = imread(strcat(num2str(i),'.png'));
    
    if size(Image{i},3) ~= 1
        Image{i} = rgb2gray(Image{i});
    end
    Image{i} = imadjust(Image{i}); % 调整对比度
    
    Image{i} = imresize(Image{i},[Scale,Scale]); % 都变成40*40的图像
 
    Image{i} = im2bw(Image{i}); % 二值化
    subplot(4,5,i);
    imshow(Image{i});
   
    Data(:,i) = Image{i}(:); % 转换成向量
    
end

Dist = dist(Data);

Input = Dist;
Output = -1*ones(Num,Num);
Label = 1:Num;

for i = 1:Num
  
    Output(i,i) = 1;
    
end

% 转换成向量  每列Num个 模式所对应的那一行等于1 其余为0

Input = [Input Input Input Input]; % 重复训练
Output = [Output Output Output Output];

%% 参数设置

% 迭代次数 epochs
% 训练目标 goal
% 学习效率 lr

% 学习函数 trainFcn

% 'trainrp'   弹性梯度下降
% 'traingdm'  附加动量
% 'traingdx'  自适应
% 'trainlm'   LM算法

rng(152,'twister'); % 这里 固定随机数  里面数值可以随意换
% 这个的意思是这样： 每次跑程序 如果不固定这个 结果就是随机的 里面的数值 是可以随便换的 换一组就是一个结果


% 参数 这个我给先解释一下  matlab的ANN 一旦有一个目标满足 那就终止算法了 
% 并且 比如我们输入了100个样本 它会自己分成若干组 然后分别训练的 具体细节我也没有仔细研究

ly = [23];  %隐层和节点数目 [20,5] 的意思是 两个隐层 第一个20 第二个5 [3] 的意思就是 一层 3个神经元

net_BP = feedforwardnet(ly);
net_BP.trainParam.epochs = 1e3;   % 训练次数设置
net_BP.trainParam.goal = 1e-32;   % 训练目标设置
net_BP.trainParam.lr = 0.05;      % 学习率
net_BP.trainParam.max_fail = 1e1;      % 检测次数
net_BP.trainParam.min_grad = 1e-15;    % 最小梯度

[net_BP,tr] = train(net_BP,Input,Output);
%nntraintool('close'); % 关闭训练窗口

% 计算误差

% 训练误差

T = sim(net_BP,Input);

Lab = zeros(1,Num); % 查找每一列最接近1的

for i = 1:Num
    
    [~,id] = min(abs(T(:,i)-1));
    Lab(i) = id(1);
    
end

E1 = (Lab-Label);

% 画图

% 迭代误差图

figure;
plot(tr.perf);
title('迭代误差');

% 输出结果

clc;

fprintf('\n\n>>训练误差:\n'); % 训练误差
fprintf('  %d\n',sqrt(sum(E1.^2)/(numel(E1)-1)));

fprintf('\n\n>>迭代次数:\n'); % 迭代次数
fprintf('  %d\n',numel(tr.perf));

% 误差画图

figure; % 真实数据跟仿真数据对比

plot(Lab,'ro');
hold on;
plot(Label,'.b');
legend('仿真数据','真实数据');
xlim([1 Num]);

title(strcat('识别错误个数：',num2str(sum(Lab~=Label))));

% 保存训练好的网络以便我们用到GUI中

Trained_BP = net_BP;

save Trained_BP Trained_BP
save Name Name
save Data Data