%---------------------------------------------------------------------------
% calc_R.m
%---------------------------------------------------------------------------

% This function calculates the channel matrix R for the OFDM and 
% and MC-CDMA schemes

function [H_ofdm,R_ofdm,R_mccdm,Fwt]=calc_R(channel)

format loose;
global num_channels;

% parameters of OFDM and MC-CDM system
num_spread=4;
num_users=num_channels/num_spread;

% calculate spreading matrix Fwt
Fw=1/sqrt(num_spread)*hadamard(num_spread);
Fwt=kron(eye(num_users),Fw);

% interleaving of the spreading matrix Fwt
Fwt=interleave(Fwt,num_users,num_spread);

% calculate the matrices R
H_ofdm=diag(fft([channel zeros(1,num_channels-length(channel))]));

R_ofdm=H_ofdm'*H_ofdm;
R_mccdm=Fwt'*R_ofdm*Fwt;

%---------------------------------------------------------------------------




