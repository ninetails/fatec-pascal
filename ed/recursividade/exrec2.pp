program exrec2;

function fatorial(n:Integer):Integer;
begin
  if n <= 0 then
    fatorial := 1
  else
    fatorial := n * fatorial(n-1);
end;

function limit(n:Integer):Real;
begin
  if n <= 1 then
    limit := 1
  else
    limit := 1 / fatorial(n) + limit(n-1);
end;

var
  n:Integer;
begin
  writeln('Set n:');
  read(n);

  if n > 0 then
    begin
      writeln('result: ', limit(n));
    end;

end.
