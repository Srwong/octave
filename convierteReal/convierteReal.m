function [R,E] = convierteReal(n,m,e,b)
  if b == 0
    R = decimalBinario(n,e,m);
    E = binarioDecimal(R,e,m) - n;
  else
    R = binarioDecimal(n,e,m);
    E = "No importa";
  endif
end

%el numero debe ser mayor o igual a 1
function R = decimalBinario(n,e,m)
  if(n >= 0)  %signos de la mantiza y el exponente
    R(1) = "0";
  else
    n = -n;
    R(1) = "1";
  endif
  
  R(2) = "0";
      
  num = floor(n); %separamos el entero del decimal
  dec = n-num;    %nos quedamos solo con el decimal
  m2 = m;         %copiamos el tamaño de la mantiza para un ciclo
  numBin = dec2bin(num);%convertimos el numero a binario
  decBin = "0"; %aqui guardaremos la parte decimal echa binario
  j = 1;  %contador de espacio del array
  
  while(m2 != 0) 
    dec = (dec*2);
    decBin(j) = num2str(floor(dec));
    
    if dec >= 1
      dec = dec - 1;
    endif
    m2--;
    j++;
  endwhile
  
  if(n >=1)   %el valor del exponente cuando es mayor a 1
    exp = 1;
    while(str2num(numBin)/(10.^exp) >=1)
      exp++;
    endwhile
    
    magExp = dec2bin(exp);
  else
    exp = -1;
    R(2) = "1";
    
    while(str2num(decBin)/(10.^exp) <= 1)
      exp--;
    endwhile
    
    magExp = dec2bin(exp*-1)
  endif
  
  temp = 0;
  temp2 = 1;
  for j = 1:e
    if length(magExp) < e+1-j
      R(3+j-1) = "0";
      temp++;
    else
      R(3+e-j+temp) = magExp(length(magExp)+1-temp2); %añadimos el valor del exponente en binario a R
      temp2++;
    endif
  endfor
  
  %normalizamos
  binNorm = "";
  for j = 1:length(numBin)
    binNorm(j) = numBin(j);
  endfor
  for j = 1:length(decBin)
    binNorm(length(binNorm)+1) = decBin(j);
  endfor
  
  %metemos todo a R
  if(length(binNorm) < m)
    for j = 1:length(binNorm)
      R(length(R)+1) = binNorm(j);
    endfor
    
    for j = length(R)-e-2-lenght(binNorm):m
      R(length(R)+1) = "0";
    endfor
    else
      for j = 1:m
        R(length(R)+1) = binNorm(j);
      endfor
  endif  
end

function R = binarioDecimal(n,e,m)
  binNorm = n(3+e:length(n));
  exponente = bin2dec(n(3:2+e));

  if n(2) == "1"
    exponente = exponente * -1;
  end
  
  if exponente > 0 %exponente positivo
    binEnt = binNorm(1:exponente);
    
    binDec = binNorm(exponente+1:length(binNorm));
    
    decimal = 0;
    for j = 1:length(binDec)
      decimal = decimal + (str2num(binDec(j))/(2.^j));
    endfor
    
    R = bin2dec(binEnt) + decimal;
    
  else %exponente negativo
    
    binDec = "";
    for j = 1: exponente*-1
      binDec(j) = "0";
    endfor
    
    for j = 1:m
      binDec(length(binDec)+1) = binNorm(j);
    endfor
    
    decimal = 0;
    for j = 1:length(binDec)
      decimal = decimal + (str2num(binDec(j))/(2.^j));
    endfor
    
    R = decimal;
  endif
  
  if n(1) == "1"
    R = -R;
  endif
end