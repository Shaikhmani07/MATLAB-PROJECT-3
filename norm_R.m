% function for energy normalization of R matrices

function [norm]=norm_R(notnorm);

global num_channels

% normalize matrix so that the arithmetic mean of the energy 
% of 'num_channels' main diagonal elements is equal to one

   mean_energy_maindiag=sum(abs(diag(notnorm)).^2)./num_channels;
   norm_factor=1./sqrt(mean_energy_maindiag);
   norm=notnorm*norm_factor;

