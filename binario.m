function B = binario(D, N)
  B = "0.";
  R = D;
  for j = 1:N
    R = R * 2;
    B(2+j) = num2str(floor(R));
    if R >= 1
      R = R-1;
    endif
  endfor
end