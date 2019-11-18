function []= plot_ber_curves(H_ofdm,R_ofdm,R_mccdm,Fwt)

% This function plots the BER curves for the given R and H matrices (second part of ex5)

% All the variables are declared global because this function is called in a loop
global FIG1 FIG2 PLOTNO num_channels alphabet num_channels num_antennas

% To create the two main plotting windows only the first time
if (isempty(PLOTNO)==1) 

	% Keeps track of the subplot number
	PLOTNO=1;
	
	% Contains the settings for Figure 1 (for OFDM)
	FIG1=figure;
	set(gcf,'Units','centimeters')
	set(gcf,'Position',[7.5 9.5 27 16])
	set(gcf,'Name','OFDM');	

	% Contains the settings for Figure 2 (for MC-CDMA)
	FIG2=figure;
	figure(FIG2);
	set(gcf,'Units','centimeters')
	set(gcf,'Position',[7.5 9.5 27 16])
	set(gcf,'Name','MC-CDMA');
end

% used in the plot properties
sub_title=sprintf(' for %d antenna(s)',PLOTNO);

%---------------------------------------------------------------------------
% code segment from exercise 5

EbN0dB=0:25;
EbN0=10.^(EbN0dB/10);

% calculate awgn reference
awgn=0.5*erfc(sqrt(0.5*EbN0));

% compute all possible transmit vectors
all_tvec=tx_vec(alphabet,num_channels);

% calculate distance profiles
%d_ofdm=dist_prof(H_ofdm,all_tvec);
%d_mccdm=dist_prof(H_ofdm*Fwt,all_tvec);


% calculate MFB
mfb_ofdm=calc_mfb(diag(R_ofdm),EbN0);
mfb_mccdm=calc_mfb(diag(R_mccdm),EbN0);

% calculate MF
mf_mccdm=calc_mf(R_mccdm,all_tvec,EbN0);

% calculate ZF-TE
zf_mccdm=calc_mfb(1./diag(inv(R_mccdm)),EbN0);

% calculate MMSE-TE
mmse_mccdm=calc_mmse(R_mccdm,all_tvec,EbN0);

% calculate ML
%ml_mccdm=calc_ml(d_mccdm,EbN0);

%---------------------------------------------------------------------------
% Visualization
%---------------------------------------------------------------------------
	
% OFDM
%---------------------------------------------------------------------------

% Make the first figure active
figure(FIG1);

% plot the OFDM matrix using the "plot_mat" function
% --------------------------------------------------
	
subplot(2,num_antennas,PLOTNO)
plot_mat(R_ofdm)

title(strcat('OFDM channel Matrix',sub_title))
xlabel('subchannel index')

box on
grid on
set(gca,'XTick',[0:2:num_channels],'YTick',[0:2:num_channels])
set(gca,'YDir','reverse');
axis([0.5 8.5 0.5 8.5])


% plot the OFDM ber curves
% ------------------------
subplot(2,num_antennas,PLOTNO+num_antennas)
semilogy(EbN0dB,awgn,'b');	       % AWGN
hold on

semilogy(EbN0dB,mfb_ofdm,'k');         % matched-filter-bound

title(strcat('OFDM ber curves',sub_title))
xlabel('Eb/N0 [dB]')

box on
grid on
set(gca,'YScale','log')
set(gca,'YTick',[1e-6 1e-4 1e-2 1e-0])
axis([0 25 1e-6 1e-0])
axis square


% MC-CDM
%---------------------------------------------------------------------------

% Make the second figure active
figure(FIG2)

% plot the MC-CDM matrix using the "plot_mat" function
% ----------------------------------------------------

subplot(2,num_antennas,PLOTNO)
plot_mat(R_mccdm)

title(strcat('MC-CDM channel matrix',sub_title))
xlabel('subchannel index')

box on
grid on
set(gca,'XTick',[0:2:num_channels],'YTick',[0:2:num_channels])
set(gca,'YDir','reverse');
axis([0.5 8.5 0.5 8.5])

% plot the MC-CDM ber curves
% --------------------------
subplot(2,num_antennas,PLOTNO+num_antennas)
semilogy(EbN0dB,awgn,'b');	      % AWGN
hold on

semilogy(EbN0dB,mfb_mccdm,'k');       % matched-filter-bound

semilogy(EbN0dB,mf_mccdm,'c');        % matched-filter detector
semilogy(EbN0dB,zf_mccdm,'m');        % ZF-TE
semilogy(EbN0dB,mmse_mccdm,'g');      % MMSE-TE

%semilogy(EbN0dB,ml_mccdm,'r');        % ML upper bound 

title(strcat('MC-CDM ber curves',sub_title))
xlabel('Eb/N0 [dB]')
box on
grid on
set(gca,'YScale','log')
set(gca,'YTick',[1e-6 1e-4 1e-2 1e-0])
axis([0 25 1e-6 1e-0])
axis square
	
PLOTNO=PLOTNO+1;
%---------------------------------------------------------------------------
		
