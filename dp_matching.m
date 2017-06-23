%% DP�}�b�`���O���|�[�g
% 1526708 ���q�m�u
% 
%% �ړI
% ����b�ҕʘb�҂��ꂼ��̑g�ݍ��킹�̉����F���������߁ADP�}�b�`���O�̃A���S���Y���𗝉�����B

%% �f�[�^�̎��O����
% �f�[�^��read_file.m���g�����炩���߂��ꂼ���cell�z����쐬�����B

%% ���ʂP�i����b�ҁj

% city011&city012
%tic;RecogRate(city011,city012);toc;
% �Ǐ�������2�{�Ōv�Z(�F����=100%,�o�ߎ���=85s)
% �Ǐ�������sqrt(2)�{�Ōv�Z(�F����=100%,�o�ߎ���=84s)
% �Ǐ�������1�{�Ōv�Z(�F����=100%,�o�ߎ���=84s)

% city021&city022
%tic;RecogRate(city021,city022);toc;
% �Ǐ�������2�{�Ōv�Z(�F����=100%,�o�ߎ���=57s)
% �Ǐ�������sqrt(2)�{�Ōv�Z(�F����=100%,�o�ߎ���=56s)
% �Ǐ�������1�{�Ōv�Z(�F����=100%,�o�ߎ���=56s)

%% ���ʂQ�i�ʘb�ҁj

% city011&city021
%tic;RecogRate(city011,city021);toc;
X = [1 sqrt(2) 2];
figure
diff1 = [92 92 83];
plot(X, diff1)
title('�Ǐ��W���Ɗe�F�����̕ω��̐��ځi�ʘb�ҁj')
xlabel('�Ǐ������W��')
ylabel('�F�����i%�j')
% �Ǐ�������2�{�Ōv�Z(�F����=83%,�o�ߎ���=68s)
% �Ǐ�������sqrt(2)�{�Ōv�Z(�F����=92%,�o�ߎ���=67s)
% �Ǐ�������1�{�Ōv�Z(�F����=92%,�o�ߎ���=67s) 

% city011&city022
%tic;RecogRate(city011,city022);toc;
hold on
diff2 = [95 94 86];
plot(X, diff2)
% �Ǐ�������2�{�Ōv�Z(�F����=86%,�o�ߎ���=70s)
% �Ǐ�������sqrt(2)�{�Ōv�Z(�F����=94%,�o�ߎ���=70s)
% �Ǐ�������1�{�Ōv�Z(�F����=95%,�o�ߎ���=70s)

% city012&city021
%tic;RecogRate(city012,city021);toc;
hold on
diff3 = [99 98 91];
plot(X, diff3)
% �Ǐ�������2�{�Ōv�Z(�F����=91%,�o�ߎ���=68s)
% �Ǐ�������sqrt(2)�{�Ōv�Z(�F����=98%,�o�ߎ���=67s)
% �Ǐ�������1�{�Ōv�Z(�F����=99%,�o�ߎ���=67s)

% city012&city022
%tic;RecogRate(city012,city022);toc;
hold on
diff4 = [98 95 94];
plot(X, diff4)
legend('011&021','011&022','012&021','012&022')
% �Ǐ�������2�{�Ōv�Z(�F����=94%,�o�ߎ���=71s)
% �Ǐ�������sqrt(2)�{�Ōv�Z(�F����=95%,�o�ߎ���=70s)
% �Ǐ�������1�{�Ōv�Z(�F����=98%,�o�ߎ���=70s)

%% �e�L�X�g�t�@�C������f�[�^���C���|�[�g�iread_file.m�j
% �S�Ẵf�[�^�����ԂɃZ���z��ɃZ�b�g����
city022 = cell(100,1);
for i = 1:100
% �ϐ���������
if i < 10
    filename = ['/Users/kmasash1/Desktop/city_mcepdata/city022/city022_00' int2str(i) '.txt'];
elseif i < 100
    filename = ['/Users/kmasash1/Desktop/city_mcepdata/city022/city022_0' int2str(i) '.txt'];
else
    filename = ['/Users/kmasash1/Desktop/city_mcepdata/city022/city022_' int2str(i) '.txt'];
end
delimiter = ' ';
startRow = 4;

% �e�L�X�g�̊e�s�̏����ݒ�
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

% �e�L�X�g�t�@�C�����J��
fileID = fopen(filename,'r');

% �f�[�^�̗�������ݒ�ɏ]���ēǂݎ��
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,...
    'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

% �e�L�X�g�t�@�C�������
fclose(fileID);

% �C���|�[�g�ł��Ȃ��f�[�^�̌㏈��

% �o�͕ϐ��̍쐬
city022{i}= [dataArray{1:end-1}];
% �ꎞ�ϐ��̃N���A
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

end

%% �֐��P�i�P��ԋ����j
function wd = word_dist(a,b)
% �P������܂ޔz��a,b�������Ƃ��A�ގ�����P��ԋ���wd�Ƃ��ĕԂ��B
% �P��ԋ���wd=0�ł���΁A���ꂼ��̒P��͓���B

% (4)�Ǐ������̌v�Z
[I, dim] = size(a);
[J, dim] = size(b);

d = zeros(I,J);
for i = 1:I
    for j = 1:J
        vec = a(i,:) - b(j,:);
        d(i,j) = sqrt(vec*vec'); % 1x15 15x1
    end
end

% (5)DP�}�b�`���O

% (6)��������
g = zeros(I,j);
g(1,1) = d(1,1);

% (7)���E����
i = 0;
for i = 2:I
    g(i,1) = g(i-1,1) + d(i,1);
end

j = 0;
for j = 2:J
    g(1,j) = g(1,j-1) + d(1,j);
end

% (8)���̑��̊i�q�_
for i = 2:I
    for j = 2:J
        g_hor = g(i,j-1) + d(i,j);
        g_dia = g(i-1,j-1) + 2*d(i,j);% ������d�̌W����ω�������
        g_ver = g(i-1,j) + d(i,j);
        [g(i,j),idx] = min([g_hor g_dia g_ver]);
    end
end

% (9)�P��ԋ���
wd = g(I,J)/(I+J);

end

%% �֐��Q�i�F�����j
function R = RecogRate(A,B)
% (10)�F�����̌v�Z
% ����A,B�͒P��100�i�̉������j���܂�Cell�z���
% �߂�lR�͂������ׂ����̒P��̔F����(%)

% �P��ԋ������i�[�����}�g���b�N�XD�����߂�i�e���v���[�gx�F���Ώہj
D = zeros(100);
for i = 1:100
    for j = 1:100
        D(i,j) = word_dist(A{i},B{j});
    end
end

% �ŏ��̒P��ԋ����Ƃ��̃C���f�b�N�X�����߂�
[Min,Ind] = min(D);

% �F���������߂�
hundred = [1:100];
Correct = (hundred == Ind);
R = sum(Correct);
%fprintf("�F����=%d\n", R);

end