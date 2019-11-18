%---------------------------------------------------------------------------
% calc_mfb.m
%---------------------------------------------------------------------------

% calculates the matched-filter-bound (MFB)
% modulation: BPSK


function out=calc_mfb(energy,EbN0)


  Pb_vec=zeros(size(energy));
  out=zeros(size(EbN0));

  for k=1:length(EbN0)
    Pb_vec=0.5*erfc(sqrt(0.5*energy*EbN0(k)));
    out(k)=1/length(Pb_vec)*sum(Pb_vec);
  end


%---------------------------------------------------------------------------
