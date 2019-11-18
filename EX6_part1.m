%------------------------------------------------------------------------------
% EX6_part1.m
%------------------------------------------------------------------------------

clear all;

%------------------------------------------------------------------------------
% declarations

% The following variables are used by the called functions. Hence they are in 
% global scope

global num_channels alphabet num_antennas

num_channels=8;

% BPSK modulation
alphabet=[+1 -1];

% specify the number of antennas for which the simulation has to be performed

num_antennas=3;

% specify the length of channel impulse response vector (row)

imp_res_len=3;

%------------------------------------------------------------------------------

%------------------------------------------------------------------------------
% specify the channel 

channel=zeros(num_antennas,imp_res_len);

% SIMO 1
channel(1,:)=[0.7  0.5 0];
channel(2,:)=[0.7 -0.7 0.7+0.7j];
channel(3,:)=[0 0.7-0.7j 0.7+0.7j];

% SIMO 2
%channel(1,:)=[0.7  0.5 0];
%channel(2,:)=[0.7  0.5 0];
%channel(3,:)=[0.7  0.5 0];

%------------------------------------------------------------------------------
% Template for the experiment 
% Summation of the matrices R(k) for multiple receiving antennas
%------------------------------------------------------------------------------
for i=1:num_antennas

R_ofdm=zeros(num_channels);
R_mccdm=zeros(num_channels);
H_ofdm=zeros(num_channels);

	for j=1:i
		[H_ofdmt,R_ofdmt,R_mccdmt,Fwt]=calc_R(channel(j,:));
			R_ofdm=R_ofdm+R_ofdmt;
			R_mccdm=R_mccdm+R_mccdmt;
	end
	
	% Energy normalization
	R_ofdm=norm_R(R_ofdm);	
	R_mccdm=norm_R(R_mccdm);
	
	% visualization of channel matrices R and BER curves
	plot_mat_ber(H_ofdm,R_ofdm,R_mccdm,Fwt);
end

%------------------------------------------------------------------------------
