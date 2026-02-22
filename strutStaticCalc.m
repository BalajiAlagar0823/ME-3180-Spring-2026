function [] = strutStaticCalc ()
    WFan = 300;
    WStrut = 500;
    theta1 = 51.39;
    theta2 = 38.61;
    T1 = 337.3449;
    T2 = 45;
    fanThrust = 175.713;

    T1y = T1 * sind(theta1);
    T2y = T2 * sind(theta2);
    T1x = T1 * cosd(theta1);
    T2x = T1 * cosd(theta2);

    % Static Equilibrium Equations 2 & 5
    AMatrix_EQ25 = [2 -2;
                    0 2];
    bVec_EQ25 = [WStrut;
                WFan + T1y + T2y];
    x_EQ25 = AMatrix_EQ25 \ bVec_EQ25;
    Ay = x_EQ25(1);
    Cy = x_EQ25(2);
    By = Ay;
    Dy = Cy;

    % Static Equilibrium Equations for Torsion/Torques about Y Axis
    AMatrix_Tau = [-76.2 76.2;
                 1 1];
    bVec_Tau = [(-50.8*T1x) + (-50.8*T2x) + (100 * fanThrust);
                T1x + T2x];
    x_Tau = AMatrix_Tau \ bVec_Tau;
    Cx = x_Tau(1);
    Dx = x_Tau(2);clc
    
    % Static Equilibrium Equations 1 & 4
    AMatrix_EQ14 = [1 1;
                    -1960 0 ];
    bVec_EQ14 = [T1x + T2x - Cx - Dx;
                 (-248.84*T1y) + (18.87 * T2y) + (961.9 * Dx) + (1038.1 * Cx) + (-118.87*T1x) + (-851.16 * T2x) + (-100 * WFan)];
    x_EQ14 = AMatrix_EQ14 \ bVec_EQ14;
    Ax = x_EQ14(1);
    Bx = x_EQ14(2);

    % Static Equilibrium Z-Axis Pin Reactions

    % Global Az & Bz Reactions at top/bottom of Fan Support Strut
    AMatrix_ZGlobal = [1 1;
                       1920 0];
    bVec_ZGlobal = [fanThrust;
                    (fanThrust * 960) + (WFan * 74.6)];
    x_ZGlobal = AMatrix_ZGlobal \ bVec_ZGlobal;

    % Local Cz & Dz Reactions at the Fan Support Box
    AMatrix_ZLocal = [1 1;
                      0 76.2];
    bVec_ZLocal = [fanThrust;
              (fanThrust * 38.1) + (WFan * 74.6) + (-125.4 * (T1y + T2y))];
    x_ZLocal = AMatrix_ZLocal \ bVec_ZLocal;

    Az = x_ZGlobal(1);
    Bz = x_ZGlobal(2);
    Cz = x_ZLocal(1);
    Dz = x_ZLocal(2);

    disp(sprintf("Pin A Reactions: Ax = %f [N] , Ay = %f [N] , Az = %f [N]\nPin B Reactions: Bx = %f [N] , By = %f [N] , Bz = %f [N]\nPin C Reactions: Cx = %f [N] , Cy = %f [N] , Cz = %f [N]\nPin D Reactions: Dx = %f [N] , Dy = %f [N] , Dz = %f [N]", Ax, Ay, Az, Bx, By, Bz, Cx, Cy, Cz, Dx, Dy, Dz));

    fprintf("Pin A Force Magnitude: %f [N] \nPin B Force Magnitude: %f [N] \nPin C Force Magnitude: %f [N] \nPin D Force Magnitude: %f [N]\n", fMag(Ax,Ay,Az), fMag(Bx,By,Bz), fMag(Cx,Cy,Cz), fMag(Dx,Dy,Dz));

    fprintf("Max Loading X: %f [N] | Y: %f [N] | Z: %f [N]", max([abs(Ax),abs(Bx),abs(Cx),abs(Dx)]), max([abs(Ay),abs(By),abs(Cy),abs(Dy)]), max([abs(Az),abs(Bz),abs(Cz),abs(Dz)]));
end

function [result] = fMag (x, y, z)
    result = ((x^2) + (y^2) + (z^2))^0.5;
end