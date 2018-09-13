function v = reversa(I)
  v = reversaRec(I);
end

function v = reversa1(l)
  v = [];
  for j  = 1:length(l)
    v = [l(j) v];
  end
end  

function v = reversa2(l)
  v = [];
  for elemento = l
    v = [elemento v];
  end
end
  
function V = reversa3(V)
r = V;
  for j = 1:length(V)
    V(j) = r(length(V) - j +1);
  end
end  

function v = reversaRec(l)
  if length(l) == 0
    v = l;
  else
    v = [reversa(l (2:length(l))) l(1)];
  end
end  