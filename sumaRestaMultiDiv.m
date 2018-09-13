function [V] = sumaRestaMultiDiv(x,y)
  a = x + y;
  b = x - y;
  c = x * y;
  d = x / y;
  V = [a b c d];  
 end