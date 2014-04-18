program rec1;

type
  ArrayInt = Array[1..100] of Integer;

procedure init(var A:ArrayInt);
var
  i: Integer;
begin
  i := 0;
  while i < 100 do
    begin
      A[i] := 2 * i;
      i := i + 1;
    end;
end;

var
  A: ArrayInt;
  i, num: Integer;
begin
  init(A);

  writeln('Digite o número para busca: ');
  read(num);

  i := 0;
  while i < 100 do
    begin
      if A[i] = num then
        begin
          writeln('número encontrado na posição: ', i);
          i := 100;
        end;
      i := i + 1;
    end;

end.
