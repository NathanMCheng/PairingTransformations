function [output] = ChiFit2RefDie(x,rpaChi,Chi,w,kernel,T,dstart,dend,Rstart,Rend)
%PitoDielectric Converts a bosonic spectral density into a dielectric function of w (eV)
%               for given values of w, and at temperature T (K) with plasma
%               frequency (wp) and impurity scattering rate (impScat)
%   Converts Pi to selfE, selfE to cond, cond to dielec
impScat = x(17);
einf = 0;
wp = x(3);

% osc = [4264,22041800,4069;6789,8142014,3925;11650,5307060,3500;15409,45542000,8905;21300,223159025,13898;30756,320536896,6908;34946,214474009,6396;40421,756371984,7518];
% osc = osc/8065.6;
% osc(:,2) = osc(:,2)/8065.6;

% oscE = [0.48,1.34,0.9;1.41,0.44,0.67;2.51,1.54,1.78;3.36,0.23,0.24;4.87,3.92,2.21];
% osc = [1.28320465902843,1.73993717599773,2.34492909044301,2.64845782511498;2.46325602296711,1.49809047299572,1.66488020974720,2.64845782511498;3.81921295116640,1.72246532204933,0.778691572537650,2.64845782511498;4.94333575701083,4.99990924685092,2.00918704525150,2.64845782511498];
% osc = [1.28318480344487,1.73994904101306,2.34493795962950,2.64846432766651;2.46326970622789,1.49812726787857,1.66493726775236,0;3.81921086273872,1.72240833488554,0.778647696536999,0;4.94332718738614,4.99990921681664,2.00918847949794,0];

% osc2_4 = [0.250212190343865,1.74090804810944,0.795972710796902,3;2.14688044705227,1.36748644979815,1.37171022018268,2.95769855426537;2.66783076704216,0.629335546378512,0.629246136576293,2.34215783687093;3.91606842714619,2.59534990218040,1.15123242185284,3.00003475855938;3.89164876612109,1.21168706768227,2.58800922152018,3.00003475855938;5.20659548937881,4.85762651840813,1.44248254654272,3.00003475855938];

% osc2_4 = [2.14688044705227,1.36748644979815,1.37171022018268,3;2.66783076704216,0.629335546378512,0.629246136576293,2.34215783687093;3.91606842714619,2.59534990218040,1.15123242185284,3.00003475855938;3.89164876612109,1.21168706768227,2.58800922152018,3.00003475855938;5.20659548937881,4.85762651840813,1.44248254654272,3.00003475855938];

% osc2_5 = [0.204885852212980,1.48659659057855,0.665748230179831,2.35472727494332;0.453161536043633,1.60592093034796,3.26249663013983,3.29619642047691;2.72698309849193,1.33257704421614,1.22241312793096,3.28002071456181;2.05696815152128,0.808682777574457,0.826754541530829,3.08289528131293;3.78736833947791,2.04487696291957,0.876967324793210,3.29620981239363;4.39737119919129,2.76675209401471,1.18468127090527,3.29620981239363;5.30429906483613,3.94085316290074,0.571171149037852,3.29620981239363];

epsL = LorentzOscill(w,x(5:8),x(9:12),x(13:16),x(4));

selfE = x(1)*KernelPitoSelfE(rpaChi,kernel,w)+x(2)*KernelPitoSelfE(Chi,kernel,w);
cond = SelfEtoCondNegative(selfE,w,T,impScat,wp);
dielec = CondtoDielec(cond,w,einf)+epsL;
ref = DielectoRef(real(dielec),imag(dielec));
dielec = dielec(dstart:dend);
ref = ref(Rstart:Rend);
output = [dielec;ref];
end