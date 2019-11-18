%---------------------------------------------------------------------------
% tx_vec.m
%---------------------------------------------------------------------------

% calculates all possible transmit vectors


function all_tvec=tx_vec(alphabet,vec_length)


  M=length(alphabet);
  num_tvec=M^vec_length;

  rowid=(0:vec_length-1)';
  colid=0:num_tvec-1;

  rowmat=ones(vec_length,1)*colid;
  colmat=rowid*ones(1,num_tvec);

  alp_id=rem(floor(rowmat./(2.^colmat)),2);
  all_tvec=alphabet(alp_id+1);


%---------------------------------------------------------------------------
