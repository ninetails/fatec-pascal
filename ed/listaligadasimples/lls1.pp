program lls1;
uses crt, sysutils;

type
  tPtNode = ^tNode;
  tNode = record
            nome: String[10];
            telefone: Integer;
            next: tPtNode;
          end;



procedure printMenu();
begin
  writeln('==================================================');
  writeln('MENU PRINCIPAL');
  writeln('1) Inserir');
  writeln('2) Remover');
  writeln('3) Alterar');
  writeln('4) Listar');
  writeln('5) Pesquisar');
  writeln('6) Quantidade de Registros');
  writeln('0) Sair');
end;



function inserir(var p:tPtNode; nome:String; telefone:Integer):String;
begin
  if p <> nil then
    inserir := inserir(p^.next, nome, telefone)
  else
    begin
      new(p);
      p^.nome := nome;
      p^.telefone := telefone;
      p^.next := nil;

      inserir := 'Número inserido com sucesso.';
    end;
end;



function remover(var p:tPtNode; nome:String):String;
var
  reg:tPtNode;
begin
  if p <> nil then
    begin
      if p^.nome = nome then
        begin
          reg := p;
          p := p^.next;
          dispose(reg);
          remover := 'Registro removido com sucesso!';
        end
      else
        remover := remover(p^.next, nome);
    end
  else
    remover := 'Registro não encontrado.';
end;



function alterar(var p:tPtNode; nome:String):String;
begin
  if p <> nil then
    begin
      if p^.nome = nome then
        begin
          writeln('Informe o novo nome ou redigite o antigo (', p^.nome, '):');
          readln(p^.nome);
          writeln('Informe o novo telefone ou redigite o antigo (', p^.telefone, '):');
          readln(p^.telefone);
          alterar := 'Registro alterado com sucesso!';
        end
      else
        alterar := alterar(p^.next, nome);
    end
  else
    alterar := 'Registro não encontrado.';
end;



function listar(var p:tPtNode; i:Integer):String;
begin
  if p <> nil then
    begin
      writeln('Registro ', i, ':');
      writeln('Nome: ', p^.nome);
      writeln('Telefone: ', p^.telefone);
      writeln();
      listar := listar(p^.next, i + 1);
    end
  else
    begin
      if i = 1 then
        listar := 'Lista vazia.'
      else
        listar := 'Fim da lista.'
    end;
end;



function pesquisar(var p:tPtNode; part:String; ocorrencias:Integer):String;
begin
  if p <> nil then
    begin
      if Pos(part, p^.nome) > 0 then
        begin
          writeln('Registro encontrado:');
          writeln('Nome: ', p^.nome);
          writeln('Telefone: ', p^.telefone);
          writeln();
          ocorrencias := ocorrencias + 1;
        end;
      pesquisar := pesquisar(p^.next, part, ocorrencias);
    end
  else
    if ocorrencias = 0 then
      pesquisar := 'Fim da pesquisa. Nenhuma ocorrência encontrada.'
    else if ocorrencias = 1 then
      pesquisar := 'Fim da pesquisa. Foi encontrada 1 ocorrência.'
    else
      pesquisar := Concat('Fim da pesquisa. Foram encontradas ', IntToStr(ocorrencias), ' ocorrências.');
end;



function total(var p:tPtNode; qtd:Integer):String;
begin
  if p <> nil then
    total := total(p^.next, qtd + 1)
  else
    begin
      if qtd = 0 then
        total := 'Lista vazia.'
      else if qtd = 1 then
        total := 'Há apenas 1 registro cadastrado na lista.'
      else
        total := Concat('Há ', IntToStr(qtd), ' registros cadastrados na lista.');
    end;
end;



var
  lista:tPtNode;
  menuopt, telefone:Integer;
  ret:String;
  nome:String[10];
begin
  lista := nil;

  clrscr;
  writeln('Bem vindo ao programa de Lista Telefônica.');
  writeln();

  menuopt := -1;
  repeat
    if menuopt > -1 then
      clrscr;

    printMenu();
    writeln();
    writeln('Escolha sua opção abaixo:');
    readln(menuopt);
    writeln();

    ret := '';
    case menuopt OF
      0 : menuopt := menuopt;
      1 : begin
            writeln('Digite o nome:');
            readln(nome);
            writeln('Digite o telefone:');
            readln(telefone);
            ret := inserir(lista, nome, telefone);
          end;
      2 : begin
            writeln('Digite o nome:');
            readln(nome);
            ret := remover(lista, nome);
          end;
      3 : begin
            writeln('Digite o nome:');
            readln(nome);
            ret := alterar(lista, nome);
          end;
      4 : begin
            writeln('Listando registros...');
            writeln();
            ret := listar(lista, 1);
          end;
      5 : begin
            writeln('Digite o nome:');
            readln(nome);
            ret := pesquisar(lista, nome, 0);
          end;
      6 : begin
            ret := total(lista, 0);
          end;
      else writeln('Opção inválida.');
    end;

    if ret <> '' then
      begin
        writeln('--------------------------------------------------');
        writeln(ret);
      end;

    if menuopt <> 0 then
      begin
        writeln();
        writeln('Digite qualquer tecla para voltar ao menu inicial.');
        readkey;
      end;

  until(menuopt = 0);
  writeln('Obrigado por utilizar o programa.');
end.
