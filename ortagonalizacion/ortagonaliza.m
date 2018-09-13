function [VO, R] = ortagonaliza(V, eps)
  VT = V(1,:); #añade la primera linea
  s = size(V); #columnas y filas
  svo = size(VT);
  temp = 0;
  for j = 2:s(1);#cambiar vectores
    for k = 1: svo(1)#cambiar las e
      temp = landa(VT(k,:), V(j,:)) * VT(k,:) + temp; #calculamos las restas aparte
    endfor
    tempVec = V(j,:) - temp;#a la x actual le restamos lo que se debe
    VT = [VT; tempVec];
    svo = size(VT);
    temp = 0;
  endfor 

  #Rango por pivoteo
  VP = VT; #VP vectores para pivoteo
  
  for k = 1: svo(2)-1#columna
    maximo = max(abs(VP(:,k))); #obtenemos el maximo de la columna
    for j = k: svo(1)
      if abs(maximo) < abs(VP(j,k))
        maximo = VP(j,k);
      endif
    endfor
    
    for j = 1:svo(1)#fila
      if VP(j,k) == 0
        VP(j,k) = 0;
      elseif VP(j,k) == maximo
        VP(j,k) = maximo;
      else
        VP(j,k) = maximo - (maximo/(VP(j,k)) * VP(j,k));
      endif  
    endfor
  endfor
 
  #Quitar las dependientes
  svo = size(VP);
  VO = 0;
  for j = 1: svo(1) #fila
    s = size(VP(j,:));
    difCero = false;
    for k = 1:s(2); #columna
      if VP(j,k) != 0;
        difCero = true;
      endif  
    endfor
      if size(VO) == [1 1] && difCero == true
        VO = VT(j,:);
      elseif difCero == true
        VO = [VO; VT(j,:)];
      endif
  endfor
  s = size(VO);
  R = s(1);
  #fin
end

function L = landa(e, x)
  s = size(e);
  v = 0;
  m = 0;
  for j = 1: s(2)
    n = e(j)*x(j);
    v = n + v; #multiplicacion de x * e
    m = m + e(j)*e(j);#multiplicacion de e * e
  endfor
  
  if m == 0 || v == 0
    L = 0;
  else
    L = v/m;
  endif
end