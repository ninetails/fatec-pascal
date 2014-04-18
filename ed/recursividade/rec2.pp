program rec2;

const MAX = 10;

type
  ArrayInt = Array[1..MAX] of Integer;

procedure init(var A:ArrayInt);
var
  i:Integer;
begin
  for i := 1 to MAX do
    begin
      A[i] := 2 * i;
    end;
end;

function buscasimples(A:ArrayInt; needle:Integer; i:Integer):String;
begin
  if A[i] = needle then
    buscasimples := 'SIM'
  else if i+1 <= MAX then
    buscasimples := buscasimples(A, needle, i+1)
  else
    buscasimples := 'NÃO';
end;

var
  A:ArrayInt;
  num:Integer;
  output:String;
begin
  init(A);
  writeln('Digite o número para busca: ');
  read(num);

  output := buscasimples(A, num, 1);
  writeln(output);
end.
