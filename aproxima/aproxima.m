function [A,E] = aproxima(X,Y,N,O,P)
  clf
  numPuntos = size(X);
  if N >= numPuntos(2)
    A = 0;
    E = 1; 
  endif
  if O == 0 && N <= numPuntos(2)#interpolacion
    #creamos la matriz de tañamo N+1
    Matriz = [1];
    for j = 1: N
      Matriz = [Matriz, X(1,1)^j];
    endfor
    E = 0;
    s = size(X); #numero de puntos disponibles
    index = [1]; #guardamos el primer punto
    si = size(index); #valores en el index
    
    cont = 2;
    while(si(2) < N)
      index = [index cont];
      cont++;
      si = size(index);
    endwhile
    index = [index numPuntos(2)];
    
    for k = 1:N
      temp = [1];
      for j = 1: N
        temp = [temp X(1,index(k+1))^j];
      endfor
      Matriz = [Matriz; temp];
    endfor
    
    #creamos el vector para gauss jordan
    D = Y(1,1);
    for j = 2: N+1
      D = [D; Y(1, index(1,j))];
    endfor
    [A,b,c,d] = gaussJordan(Matriz,D,1);#solo ocupamos A
    
    #imprimimos la recta
    x = X(1):0.1:X(numPuntos(2));
    y = num2str(A(1));
    sizeA = size(A);
    for j = 2:sizeA(1)
      y = [y "+" num2str(A(j,1)) "*x.^" num2str(j-1)];
    endfor
    
    plot(x,eval(y),'r')
    hold
    #calculamos los puntos que nos solicitan
    sp = size(P);
    for j=1 :sp(2)
      x = P(j);
      plot(P(j),eval(y),'b');
    endfor
    
    #imprimimos los puntos de la tabla
    plot(X(1),Y(1), "k");
    for j = 2: numPuntos(2)
    plot(X(j),Y(j), "k")
    endfor
  endif
  
  if O == 1 && N <= numPuntos(2)#minimos cuadrados
    Matriz = numPuntos(2);
    
    #creamos el primer renglon
    for j = 1:N
      Matriz = [Matriz sumatoria(X,j)];
    endfor
    #creamos el resto de los renglones
    for j =2: N+1
      temp = Matriz(j-1,2);
      for k = 1:N;
        temp = [temp, sumatoria(X,j)];
      endfor
      Matriz= [Matriz; temp];
    endfor
    #creamos el vector para gauss jordan
    D = sumatoria(Y,1);
    sy = size(Y);
    for j = 1: N
      D = [D; sumatoria2(X,Y,j)];
    endfor
    [A,b,c,d] = gaussJordan(Matriz,D,1);#solo ocupamos A
    
    #imprimimos la recta
    x = X(1):0.1:X(numPuntos(2)); #todas las x
    y = num2str(A(1)); #creamos un string
    sizeA = size(A);  #obtenemos el tamanio de A
    for j = 2:sizeA(1) 
      y = [y "+" num2str(A(j,1)) "*x.^" num2str(j-1)]; #creamos un string para graficar
    endfor

    plot(x,eval(y),'r')
    hold
    #calculamos los puntos que nos solicitan
    sp = size(P);
    for j=1 :sp(2)
      x = P(j);
      plot(P(j),eval(y),'b');
    endfor
    
    #imprimimos los puntos de la tabla
    plot(X(1),Y(1), "k");
    for j = 2: numPuntos(2)
    plot(X(j),Y(j), "k")
    endfor
    
    E = 0;
  endif
end

function num = sumatoria(vec,pot)
  s = size(vec);
  num = 0;
  for j = 1:s(2)
    num = num + vec(j).^pot;
  endfor
end

function num = sumatoria2(vecX,vecY,pot)
  s = size(vecX);
  num = 0;
  for j = 1:s(2)
    num = num + (vecX(1,j).^pot * vecY(1,j));
  endfor
end