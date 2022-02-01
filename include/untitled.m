clear all; close all; clc
%%
EOP_table= readtable('eopc04_14_IAU2000.62-now.csv');
%%
EOP = [EOP_table.MJD EOP_table.x_pole EOP_table.y_pole...
    -EOP_table.UT1_UTC EOP_table.LOD EOP_table.dX EOP_table.dY];
%%
Delta_AT_table = readtable('Delta_AT.csv');
Delta_AT = [Delta_AT_table.Var1 Delta_AT_table.Var7];
%%
X_coe_0 = readmatrix('tab5.2a.txt','Range','38:1343');
X_coe_0 = X_coe_0(:, 2:end);
X_coe_1 = readmatrix('tab5.2a.txt','Range','1347:1599');
X_coe_1 = X_coe_1(:, 2:end);
X_coe_2 = readmatrix('tab5.2a.txt','Range','1603:1638');
X_coe_2 = X_coe_2(:, 2:end);
X_coe_3 = readmatrix('tab5.2a.txt','Range','1642:1645');
X_coe_3 = X_coe_3(:, 2:end);
X_coe_4 = readmatrix('tab5.2a.txt','Range','1647:1649');
X_coe_4 = X_coe_4(2, 2:end);
%%
Y_coe_0 = readmatrix('tab5.2b.txt','Range','38:999');
Y_coe_0 = Y_coe_0(:, 2:end);
Y_coe_1 = readmatrix('tab5.2b.txt','Range','103:1279');
Y_coe_1 = Y_coe_1(:, 2:end);
Y_coe_2 = readmatrix('tab5.2b.txt','Range','1281:1312');
Y_coe_2 = Y_coe_2(2:end, 2:end);
Y_coe_3 = readmatrix('tab5.2b.txt','Range','1316:1320');
Y_coe_3 = Y_coe_3(:, 2:end);
Y_coe_4 = readmatrix('tab5.2b.txt','Range','1322:1324');
Y_coe_4 = Y_coe_4(2, 2:end);