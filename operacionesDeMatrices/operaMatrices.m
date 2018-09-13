function [R, E, M] = operaMatrices(A,B,N)
  SA = size(A); % aqui guarda el tamaño de A mxn
  SB = size(B); % aqui guarda el tamaño de B mxn
  
  %SUMA
  if SA(1) != SB(1) || SA(2) != SB(2) && N == 0 %comprobamos el tamaño
    R = [];
    E = 1;  % 1 significa error
    M = "Las dimensiones de las matrices impide su suma"; %Mensaje
  end 
  if SA(1) == SB(1) && SA(2) == SB(2) && N == 0
    R = sumaMatrices(A,B);
    E = 0;
    M = "No hay error";
  end
  
  %RESTA
  if SA(1) != SB(1) || SA(2) != SB(2) && N == 1 %comprobamos el tamaño
    R = [];
    E = 1;  % 1 significa error
    M = "Las dimensiones de las matrices impide su resta"; %Mensaje
  end 
  if SA(1) == SB(1) && SA(2) == SB(2) && N == 1
    R = restaMatrices(A,B);
    E = 0;
    M = "No hay error";
  end
  
  %MULTIPLICACION
  if SA(2) != SB(1) && N == 2%comprobamos el tamaño
    R = [];
    E = 1;  % 1 significa error
    M = "Las dimensiones de las matrices impide su multiplicacion"; %Mensaje
  end 
  if SA(2) == SB(1) && N == 2
    R = multMatrices(A,B);
    E = 0;
    M = "No hay error";
  end
  
  %Promedio y desviacion estandar
  if N == 3
    R = prob(A);
    E = 0;
    M = "No hay error";
  end
  
  %Max y min
  if N == 4
    R = maxmin(A);
    E = 0;
    M = "No hay error";
  end
  
  if N < 0 || N > 4
    R = [];
    E = 1;
    M = "Operacion No existe";
  end
end
function R1 = sumaMatrices(A,B)
  SA = size(A);
  SB = size(B);
  R1 = []; %la matriz que regresamos
  R2 = []; %el vector con el que llenamos las lineas
  for j = 1:SA(1) %primer ciclo para escoger el renglon
    for k = 1:SA(2) %segundo cilco para la columna 
      R2(k) = A(j,k) + B(j,k);
    end
    R1 = [R1; R2];
    R2 = [];
  end
end

function R1 = restaMatrices(A,B)
  SA = size(A);
  SB = size(B);
  R1 = []; %la matriz que regresamos
  R2 = []; %el vector con el que llenamos las lineas
  for j = 1:SA(1) %primer ciclo para escoger el renglon
    for k = 1:SA(2) %segundo cilco para la columna 
      R2(k) = A(j,k) - B(j,k);
    end
    R1 = [R1; R2];
    R2 = [];
  end  
end

function R1 = multMatrices(A,B)
  SA = size(A);
  SB = size(B);
  R1 = []; %la matriz que regresamos
  R2 = []; %el vector con el que llenamos las lineas
  R3 = 0; %el valor de cada elemento
  for j = 1:SA(1) %primer ciclo para escoger el renglon A
    for k = 1:SB(2) %segundo cilco para la columna A
      for l = 1:SB(1) %Ciclo para renglon de B
        R3 = R3 + (A(j,l) * B(l,k));
      end
      R2 = [R2, R3];
      R3 = 0;
    end
    R1 = [R1; R2];
    R2 = [];
  end   
end

function R1 = prob(A)
  R1 = [];
  R2 = [];
  sum = 0;
  SA = size(A);
 
  for j = 1:SA(1)
    for k = 1:SA(2)
      sum = sum + A(j,k);
    end
    R3 = A(j,:);
    R2 = [R2 ; sum/SA(2), std(R3)];
    sum = 0;
  end
  R1 = [R1; R2];
end

function R1 = maxmin(A)
  R1 = [];
  R2 = [];
  R3 = [];
  SA = size(A);
  for k = 1:SA(2)
    max = A(1,k);
    min = A(1,k);
    for j = 1:SA(1)
      if max < A(j,k)
        max = A(j,k);
      end  
      if min > A(j,k)
        min = A(j,k);
      end
    end
    R2 = [R2, max];
    R3 = [R3, min];
    max = 0;
    min = 0;
  end
  R1 = [R1; R2; R3];
  R2 = [];
  R3 = [];
end