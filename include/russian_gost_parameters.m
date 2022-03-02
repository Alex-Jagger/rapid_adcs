clear all; close all; clc
%%
russian_gost_param = readmatrix('include\russian_gost_parameters.csv');

F_107 = readmatrix("include\f_107.csv");

%% Calculate F_107_daily
ii = 1;
F_107_daily = zeros(size(F_107));
col_JD = F_107(:, 1);
JD = floor(col_JD(1));
col_F_107 = F_107(:, 2);
while JD <= col_JD(end)
    F_107_daily(ii, 1) = JD;
    F_107_JD = mean(col_F_107((JD < col_JD) & (col_JD < (JD + 1))));
    F_107_daily(ii, 2) = F_107_JD;
    ii = ii + 1;
    JD = JD + 1;
end
F_107_daily( ~any(F_107_daily,2), : ) = [];
for ii = 1:length(F_107_daily)
    if isnan(F_107_daily(ii, 2))
        F_107_daily(ii, 2) = F_107_daily(ii - 1, 2);
    end
end

F_81 = zeros(length(F_107_daily) - 80, 2);
w = zeros(81, 1);
for ii = 1:length(w)
    w(ii) = 0.5 + 0.5*(ii - 1)/80;
end
W = sum(w);

for ii = 1:length(F_81)
    F_107_last_81 = F_107_daily(ii : ii + 80, 2);
    F_81(ii, 2) = F_107_last_81'*w/W;
    F_81(ii, 1) = F_107_daily(ii + 80, 1);
end
%%
% figure
% hold on
% grid on
% plot(F_107_daily(:, 1), F_107_daily(:, 2));
% plot(F_81(:, 1), F_81(:, 2));
%%
Ad = [0, -0.028
10, -0.045
20, -0.047
30, -0.035
40, -0.011
50, 0.022
60, 0.057
70, 0.090
80, 0.114
90, 0.125
100, 0.118
110, 0.096
120, 0.060
130, 0.013
140, -0.037
150, -0.086
160, -0.128
170, -0.162
180, -0.185
190, -0.199
200, -0.202
210, -0.193
220, -0.173
230, -0.140
240, -0.096
250, -0.042
260, 0.015
270, 0.070
280, 0.115
290, 0.144
300, 0.155
310, 0.145
320, 0.120
330, 0.084
340, 0.044
350, 0.006
360, -0.023
370, -0.040];

%%
save("include\russian_gost_parameters","russian_gost_param","F_107_daily","F_81", "Ad")