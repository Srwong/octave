function r = potenciaMultiplicacion(a,b)
  r = 1;
  for j = 1:b
    r = multRec(r,a);
  end
end

function r = multRec(a,b)
  if a == 0
    r = 0;
  else
    r = b + multRec(a-1,b);
  end
end  