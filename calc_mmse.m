%---------------------------------------------------------------------------
% calc_mmse.m
%---------------------------------------------------------------------------

% calculates the MMSE-TE ber curve
% modulation: BPSK


function out=calc_mmse(R,all_tvec,EbN0)
  eps=1e-8;

  % parameters
  num_channels=size(R,1);
  num_tvec=2^num_channels;


  % calc mmse-curve
  out=zeros(size(EbN0));
  Pb=size(1,num_channels);

  for k=1:length(EbN0)
    % mmse equalization matrix
    M=inv(R+eye(size(R))/EbN0(k));
    energy=diag(M*R*M);

    T=M*R;
    diagonal=diag(T);
    T=T-diag(diagonal);

    % all_rvec: matrix of all possible receive vectors
    all_rvec=T*all_tvec;

    for l=1:num_channels
      if (diagonal(l)<eps)
        Pb(l)=0.5;
      else
        Pb(l)=sum(0.5*erfc(sqrt(0.5*EbN0(k)/energy(l))*...
            (diagonal(l)+all_rvec(l,:))))/num_tvec;
      end
    end
    out(k)=sum(Pb)/num_channels;
  end


%---------------------------------------------------------------------------
