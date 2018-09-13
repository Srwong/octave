function [inv, det, error] = inversa(Matriz)
  s = size(Matriz); #sacamos el tamaño
  if s(1) != s(2)
    inv = 0;
    det = 0;
    error = "La matriz no es cuadrada";
  else
    diagonal = true; #la diagonal principal tiene numeros distintos a 0
    for k = 1:s(1);
      if Matriz(k,k) == 0
        diagonal = false;
      endif
   endfor
  
  if diagonal == false
    inv = 0;
    det = 0;
    error = "La diagonal principal contiene un 0";
  else
    #determinante
    det = 1;
    copia = Matriz;

    y = 1;  #para escoger fila
    z = 1;  #para escoger columna
    for k = 1: s(2) #columna
      for j = 1: s(1) #fila
         if y != j && Matriz(y,z) != 0
          Matriz(j,:) = Matriz(j,:) - (Matriz(j,k)/Matriz(y,z) * Matriz(y,:));
        endif
      endfor
      det = det * Matriz(y,z);
      y++;
      z++;
    endfor
  
    if det == 0 || det == -0
      inv = 0;
      det = 0;
      error = "El determinante es 0, la matriz no tiene inversa";
    else
      I = eye(s(1)); #obtenemos la matriz identidad
      copia = [copia I]; #juntamos la matriz identidad y la del usuario
      #calculamos la inversa con el metodo visto en clase
      sm = size(copia);
      y = 1;  #para escoger fila
      z = 1;  #para escoger columna
      for k = 1: s(2) #columna
        copia(y,:) = copia(y,z)^-1 * copia(y,:);
        for j = 1: sm(1) #fila
           if y != j
            copia(j,:) = copia(j,:) - (copia(j,y) * copia(y,:));
           endif
       endfor
        y++;
        z++;
        
        #separamos la inversa de la matriz
        inv = copia(:,s(1)+1);
        for k = (s(1)+2):sm(2)
        inv = [inv copia(:,k)];
        endfor
    
    error = "ninguno";
     endfor
    endif
  endif
  endif
end