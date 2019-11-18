function out=interleave(spread_mat,num_col,num_row)
  % spreading matrix should have dimension num_sub x num_sub
  % num_col*num_row=num_sub
  % Interleaver reads in data rowise and writes it columnwise to
  % the output
  % call OUT = INTERLEAVE(SPREAD_MAT,NUM_COL,NUM_ROW)
  
  
  %check parameters
  %-------------------------------------------------------------------
  [spread_row,spread_col]=size(spread_mat);
  if(spread_row~=spread_col)
    error('spread_mat must be square')
  end
  if((num_col*num_row)~=spread_row)
    error('dim spread_mat must be equal to (num_col*num_row)')
  end
  
  %calculate interleaver index
  %------------------------------------------------------------------
  index=1:spread_row;
  index_mat=zeros(num_row,num_col);
  index_mat(:)=index;
  index_mat=transpose(index_mat);
  index(:)=index_mat;
  out=zeros(size(spread_mat));
  out=spread_mat(index,:);