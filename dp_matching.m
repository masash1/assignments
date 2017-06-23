%% DPマッチングレポート
% 1526708 兼子仁志
% 
%% 目的
% 同一話者別話者それぞれの組み合わせの音声認識率を求め、DPマッチングのアルゴリズムを理解する。

%% データの事前処理
% データはread_file.mを使いあらかじめそれぞれのcell配列を作成した。

%% 結果１（同一話者）

% city011&city012
tic;RecogRate(city011,city012);toc;
% 局所距離を2倍で計算(認識率=100%,経過時間=85s)
% 局所距離をsqrt(2)倍で計算(認識率=100%,経過時間=84s)
% 局所距離を1倍で計算(認識率=100%,経過時間=84s)

% city021&city022
tic;RecogRate(city021,city022);toc;
% 局所距離を2倍で計算(認識率=100%,経過時間=57s)
% 局所距離をsqrt(2)倍で計算(認識率=100%,経過時間=56s)
% 局所距離を1倍で計算(認識率=100%,経過時間=56s)

%% 結果２（別話者）

% city011&city021
tic;RecogRate(city011,city021);toc;
% 局所距離を2倍で計算(認識率=83%,経過時間=68s)
% 局所距離をsqrt(2)倍で計算(認識率=92%,経過時間=67s)
% 局所距離を1倍で計算(認識率=92%,経過時間=67s) 

% city011&city022
tic;RecogRate(city011,city022);toc;
% 局所距離を2倍で計算(認識率=86%,経過時間=70s)
% 局所距離をsqrt(2)倍で計算(認識率=94%,経過時間=70s)
% 局所距離を1倍で計算(認識率=95%,経過時間=70s)

% city012&city021
tic;RecogRate(city012,city021);toc;
% 局所距離を2倍で計算(認識率=91%,経過時間=68s)
% 局所距離をsqrt(2)倍で計算(認識率=98%,経過時間=67s)
% 局所距離を1倍で計算(認識率=99%,経過時間=67s)

% city012&city022
tic;RecogRate(city012,city022);toc;
% 局所距離を2倍で計算(認識率=94%,経過時間=71s)
% 局所距離をsqrt(2)倍で計算(認識率=95%,経過時間=70s)
% 局所距離を1倍で計算(認識率=98%,経過時間=70s)

%% 関数１（単語間距離）
function wd = word_dist(a,b)
% 単語情報を含む配列a,bを引数とし、類似性を単語間距離wdとして返す。
% 単語間距離wd=0であれば、それぞれの単語は同一。

% (4)局所距離の計算
[I, dim] = size(a);
[J, dim] = size(b);

d = zeros(I,J);
for i = 1:I
    for j = 1:J
        vec = a(i,:) - b(j,:);
        d(i,j) = sqrt(vec*vec'); % 1x15 15x1
    end
end

% (5)DPマッチング

% (6)初期条件
g = zeros(I,j);
g(1,1) = d(1,1);

% (7)境界条件
i = 0;
for i = 2:I
    g(i,1) = g(i-1,1) + d(i,1);
end

j = 0;
for j = 2:J
    g(1,j) = g(1,j-1) + d(1,j);
end

% (8)その他の格子点
for i = 2:I
    for j = 2:J
        g_hor = g(i,j-1) + d(i,j);
        g_dia = g(i-1,j-1) + 2*d(i,j);% ここでdの係数を変化させた
        g_ver = g(i-1,j) + d(i,j);
        [g(i,j),idx] = min([g_hor g_dia g_ver]);
    end
end

% (9)単語間距離
wd = g(I,J)/(I+J);

end

%% 関数２（認識率）
function R = RecogRate(A,B)
% (10)認識率の計算
% 引数A,Bは単語100個（の音響情報）を含むCell配列で
% 戻り値Rはそれらを比べた時の単語の認識率(%)

% 単語間距離を格納したマトリックスDを求める（テンプレートx認識対象）
D = zeros(100);
for i = 1:100
    for j = 1:100
        D(i,j) = word_dist(A{i},B{j});
    end
end

% 最小の単語間距離とそのインデックスを求める
[Min,Ind] = min(D);

% 認識率を求める
hundred = [1:100];
Correct = (hundred == Ind);
R = sum(Correct);
%fprintf("認識率=%d\n", R);

end