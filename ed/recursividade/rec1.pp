program rec1;

type
  ArrayInt = Array[1..100] of Integer;

procedure init(var A:ArrayInt);
var
  i: Integer;
begin
  i := 1;
  while i <= 100 do
    begin
      A[i] := 2 * i;
      i := i + 1;
    end;
end;

function binsearch(A:ArrayInt; needle:Integer; min:Integer; max:Integer):Integer;
var
  mid:Integer;
  midval:Integer;
begin
  mid := Trunc((min + max) / 2);
  midval := A[mid];
  if midval = needle then
    binsearch := mid
  else
    if max - min = 1 then
      binsearch := -1
    else
      begin
        if needle < midval then
          binsearch := binsearch(A, needle, min, mid)
        else
          binsearch := binsearch(A, needle, mid, max)
      end;
end;

var
  A: ArrayInt;
  num, pos: Integer;
begin
  init(A);

  writeln('Digite o número para busca: ');
  read(num);

  if A[100] = num then
    writeln('pos: 100')
  else
    begin
      pos := binsearch(A, num, 0, 100);
      if pos > 0 then
        writeln('pos: ', pos)
      else
        writeln('Número não encontrado.');
    end;

end.
