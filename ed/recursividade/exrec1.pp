program exrec1;

const N = 4;

type
  ArrayInt = Array[1..N] of Integer;

function findEqualIndex(A:ArrayInt; B:ArrayInt; i:Integer):Integer;
begin
  if i > N then
    findEqualIndex := -1
  else if A[i] = B[i] then
    findEqualIndex := i
  else
    findEqualIndex := findEqualIndex(A, B, i+1);
end;

var
  i, pos:Integer;
  A, B:ArrayInt;
begin
  for i := 1 to N do
    A[i] := i;

  for i := 1 to N do
    B[i] := 2;

  pos := findEqualIndex(A, B, 1);
  if pos > 0 then
    writeln('pos: ', pos)
  else
    writeln('not found.');
end.
