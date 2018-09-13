function [x, Ainv, d, Solucion] = gaussJordan(A, b, op)
  if op == 1  #Solucion
    Ainv = 0; #asi queda
    d = 0;  #asi queda
    
    M = [A b];  #juntamos para tener una matriz aumentada
    s = size(M); #sacamos el tamaño
    y = 1;  #para escoger fila
    z = 1;  #para escoger columna
    for k = 1: s(2)-1 #columna
      M(y,:) = M(y,z)^-1 * M(y,:);
      for j = 1: s(1) #fila
         if y != j
          M(j,:) = M(j,:) - (M(j,y) * M(y,:));
         endif
      endfor
      y++;
      z++;
    endfor
    
    x = M(:,s(2));
    s = size(x);
    bool = false;
    for k = 1:s(1);
      if isnan(x(k,1))
        bool = true;
      endif  
    endfor
    
    Solucion = 1;
    if bool == true
      x = 0;
      Solucion = 0;
    endif    
    
  elseif op == 2 #inversa y determinante
    x = 0;
    Solucion = 2;
    sa = size(A);
    e = eye(sa(1));
    M = [A e];
    sm = size(M);
    
    #calculamos la inversa con gaussJorda
    y = 1;  #para escoger fila
    z = 1;  #para escoger columna
    for k = 1: sa(2) #columna
      M(y,:) = M(y,z)^-1 * M(y,:);
      for j = 1: sm(1) #fila
         if y != j
          M(j,:) = M(j,:) - (M(j,y) * M(y,:));
         endif
      endfor
      y++;
      z++;
    endfor

    #separamos la inversa de la matriz
    Ainv = M(:,sa(1)+1);
    for k = (sa(1)+2):sm(2)
      Ainv = [Ainv M(:,k)];
    endfor
    
    #checamos si existe la matriz inversa
    bool = false;
    for j = 1:sa(1)
      for k = 1:sa(2)
        if isnan(Ainv(j,k)) == true 
          bool = true;
        endif
      endfor
    endfor    
    
    d = 1; #determinante
    M = A;  #juntamos para tener una matriz aumentada
    s = size(M); #sacamos el tamaño
    y = 1;  #para escoger fila
    z = 1;  #para escoger columna
    for k = 1: s(2) #columna
      for j = 1: s(1) #fila
         if y != j && M(y,z) != 0
          M(j,:) = M(j,:) - (M(j,k)/M(y,z) * M(y,:));
         endif
      endfor
      d = d * M(y,z);
      y++;
      z++;
    endfor
    
    #volvemos 0 en caso de que no exista
    if bool == true
      Ainv = 0;
      Solucion = 0;   
      d = 0;   
    endif
    
   endif
end