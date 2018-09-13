function r = factorial(a)
  r = factIt(a)
  r = factRec(a)
end  

function r = factIt(a)
  r = 1;
  for j= 1:a
    r = r *j;
  end  
end  

function r = factRec(a)
r = 1;
  if a == 0
    r = 1;
  else 
    r = a * factRec(a-1);
  end
end  