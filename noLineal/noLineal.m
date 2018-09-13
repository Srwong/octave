function [x,E,i] = noLineal(x0, eps, maxit, metodo)
  j = 0;
  
  if metodo == 0  %Newton-Raphson
    x2 = x0;
    x1 = 0;
    while(j < maxit)
      x1 = x2; %se vuelve la anterior
      x2 = x1-(f(x1)/df(x1));
      
      if eps > abs(x2- x1)
        x = x2;
        i = j;
        E = false;
        break
      endif
      j++;
      
      if j == maxit
        x = "El metodo no converge";
        E = true;
        i = maxit;
      endif
    endwhile
    
  else %secante
    x1 = x0(1);
    x2 = x0(2);
    
    while (j < maxit)
      
      x3 = x2 - ((x2-x1)*f(x2)/(f(x2)-f(x1)));
      
      if eps > abs(x3- x2)
        x = x3;
        i = j+1;
        E = false;
        break
      endif
      
      x1 = x2;
      x2 = x3;
      j++;
      
      if j == maxit
        x = "El metodo no converge";
        E = true;
        i = maxit;
      endif
    endwhile
  endif
end