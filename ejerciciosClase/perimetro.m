function P = perimetro(M)
  P = 0;
  
  for j = 2: length(M)
    X = (M(1,j-1) - M(1,j));
    Y = (M(2,j-1) - M(2,j));
    P = sqrt(X.^2 + Y.^2) + P;
  endfor
  
  X = M(1,1) - M(1,length(M));
  Y = (M(2,1) - M(2,length(M)));
  P = sqrt(X.^2 + Y.^2) + P;
end