%Devoir3


function [Coup tf vbaf vbof wbof rbaf rbof ]=Devoir3(vbal,wboi,tl)
    

global mBoite
global hBoite

global RayonBoite

global AxeCylindre

global vInitialeBoite

global rCM

global RayonBalle

global mBalle

global posBalleDepart

global k
global aBalle
global aBoite

global coefficientRestitution


mBoite = 0.075; % kg
hBoite = 0.15; %m
RayonBoite = hBoite/sqrt(6);

AxeCylindre = [0 0 1];

vInitialeBoite = 0;

rCM = [3 0 10]; %m
%w = constante;

RayonBalle = 0.0335;

mBalle = 0.058; %kg

posBalleDepart = [0 0 2]; %m

k = 0.1; %kg/((m^2)s)
aBalle = pi * (RayonBalle^2);
aBoite = (RayonBoite^2) + (hBoite^2);

coefficientRestitution = 0.5;

max_error = [0.001 0.001 0.001; 0.001 0.001 0.001; 0.001 0.001 0.001];
% pos_x, pos_y, pos_z v_x, v_y, v_z w_x w_y w_z tl
q0Balle=[posBalleDepart(1) posBalleDepart(2) posBalleDepart(3) vbal(1) vbal(2) vbal(3) 0 0 0 tl];
q0Boite=[];

%Solution
DeltaT = 0.001;
m=1;


end


function MI = MomentInertieSphere(m, r)
    Ic = 2 * m * r^2 / 3;
    MI = [Ic 0 0; 0 Ic 0; 0 0 Ic];
end

function MI = MomentInertieCylindre(m, r, l)
    Ixy = m * r^2 / 2 + m * l^2 / 12;
    Iz = m * r^2
    MI = [Ixy 0 0; 0 Ixy 0; 0 0 Iz];
end

function qs=SEDRK4t0(q0,t0,Deltat,g)
    % Solution equations differentielles par methode de RK4
    % Equation a resoudre : dq/dt=g(q,t)
    % avec
    %   qs        : solution [q(to+Deltat)]
    %   q0        : conditions initiales [q(t0)]
    %   Deltat    : intervalle de temps
    %   g         : membre de droite de ED. 
    %               C'est un m-file de matlab
    %               qui retourne la valeur de g au temps choisi
    k1=feval(g,q0,t0);
    k2=feval(g,q0+k1*Deltat/2,t0+Deltat/2);
    k3=feval(g,q0+k2*Deltat/2,t0+Deltat/2);
    k4=feval(g,q0+k3*Deltat,t0+Deltat);
    qs=q0+Deltat*(k1+2*k2+2*k3+k4)/6;
end

function [conv, Err]=ErrSol(qs1,qs0,epsilon)
    % Verification si solution convergee
    %   conv      : variable logique pour convergence
    %               Err<epsilon pour chaque elements
    %   Err       : Difference entre qs1 et qs0 
    %   qs1       : nouvelle solution
    %   qs0       : ancienne solution
    %   epsilon   : pr?cision pour chaque variable
    Err = qs1-qs0;
    conv = all(abs(Err) < epsilon);
end