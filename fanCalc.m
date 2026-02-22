function [fanForce, fanFluidPower, fanMechPower] = fanCalc ()
    % Given parameters per the assignment prompt
    % cfmIMP [ft^3/min]
    % PsIMP [inches of H2O water pressure]
    % fanArea [m^2]
    cfmIMP = 30000;
    PsIMP = 0.125;
    fanArea = (0.9.^2) .* pi; % Already in SI ✅
    eff = 0.38; % 38% Efficiency

    % Changing from Imperial Units to SI Standard (So that the output force is in Newtons & Output power is in Watts)
    % PsSI [N/m^2]
    % cfmSI [m^3/s]
    % rhoAir [kg/m^3]
    % Fan Force Calc
    PsSI = PsIMP * (249.08891);
    cfmSI = cfmIMP * (0.0004719);
    rhoAir = 1.225;
    vel = cfmSI ./ fanArea;
    fanForce = (rhoAir .* cfmSI .* vel) + (PsSI .* fanArea);

    % Fan Power Calc
    PVel = 0.5 .* rhoAir .* (vel.^2);
    PTot = PVel + PsSI;
    fanFluidPower = cfmSI .* PTot;
    fanMechPower = fanFluidPower ./ eff;
    disp(sprintf("Fan Force: %.3f [N] \nFan Fluid Power: %.3f [W] \nFan Mechanical Power: %.3f [W]", fanForce, fanFluidPower, fanMechPower));


    % Calculating Tensions of the Belt
    % Ttight - Tweak = FanTorque / Driven Pulley Radius
    Tweak = 45; % Belt Tension of the weaker side
    TPreload = 130; % Belt Preload
    RPM = 320;
    
    fanTorque = fanMechPower ./ (2.* pi .* RPM ./ 60);
    Ttight = (fanTorque ./ 0.1905) + Tweak
end
