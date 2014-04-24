program lista;
uses crt;

{
  Programa Lista Telefônica
}

{
  Cada registro telefônico segue a estrutura de tipo
  tRegistro:
    nome: String[10]
    telefone: Int
    prox: ponteiro pro próximo registro | nil caso for último
}
type
  tPtRegistro = ^tRegistro;
  tRegistro = record
                nome: String[10];
                telefone: Integer;
                prox: tPtRegistro;
              end;



function IntToStr(I:Integer):String;
var
  S:String;
begin
  Str(I, S);
  IntToStr := S;
end;



{
  1) Função para inserir registro.
  Cria novo registro após o último registro existente.
  Caso o registro atual estiver ocupado, tentar próximo até encontrar um vazio (último).

  Parâmetros:
    p - ponteiro para um registro
    nome - String - nome do sujeito que será inserido, valor será truncado em 10 posições
    telefone - Integer - valor a ser guardado como telefone

  Retorno:
    Devolve string contendo mensagem de registro incluído com sucesso.
}
function inserir(var p:tPtRegistro; nome:String; telefone:Integer):String;
begin
  if p <> nil then
    { se registro não for nulo, acessar próximo }
    inserir := inserir(p^.prox, nome, telefone)
  else
    begin

      { inserir quando o registro atual for nil }
      new(p);
      p^.nome := nome;
      p^.telefone := telefone;
      p^.prox := nil;

      inserir := 'Número inserido com sucesso.';
    end;
end;



{
  2) Remove a primeira ocorrência exata do string nome na lista telefônica.
  Caso o registro atual não for igual ao nome fornecido, avançar para o próximo registro.
  Fornecer um erro caso não encontrou nenhum nome e é o último registro da lista.

  Parâmetros:
    p - ponteiro para um registro
    nome - String - Nome a ser buscado para apagar

  Retorno:
    Retorna mensagem de sucesso ou de registro não encontrado.
}
function remover(var p:tPtRegistro; nome:String):String;
var
  reg:tPtRegistro;
begin
  if p <> nil then
    begin
      if p^.nome = nome then
        begin

          { rotina para remoção de registro }
          reg := p;
          p := p^.prox;
          dispose(reg);

          remover := 'Registro removido com sucesso!';
        end
      else
        { se o nome não for encontrado, acessar o próximo }
        remover := remover(p^.prox, nome);
    end
  else
    { chegou no último registro sem encontrar o nome buscado }
    remover := 'Registro não encontrado.';
end;



{
  3) Altera um registro dado o nome (ocorrência exata).

  Parâmetros:
    p - ponteiro para um registro
    nome - String - Nome a ser buscado para alterar

  Retorno:
    Retorna que o registro foi alterado após preenchimento ou retorna que o registro
    não foi encontrado, caso o nome fornecido não for igual a algum registro da lista.
}
function alterar(var p:tPtRegistro; nome:String):String;
begin
  if p <> nil then
    begin
      if p^.nome = nome then
        begin

          { nome encontrado. tela de alteração e escreve direto na variável }
          writeln('Informe o novo nome ou redigite o anterior (', p^.nome, '):');
          readln(p^.nome);
          writeln('Informe o novo telefone ou redigite o anterior (', p^.telefone, '):');
          readln(p^.telefone);

          alterar := 'Registro alterado com sucesso!';
        end
      else
        { se o nome não for encontrado, acessar o próximo }
        alterar := alterar(p^.prox, nome);
    end
  else
    { chegou no último registro sem encontrar o nome buscado }
    alterar := 'Registro não encontrado.';
end;



{
  4) Lista todos os registros da lista.
  A cada registro, ele imprime o nome e o telefone do sujeito.

  Parâmetros:
    p - ponteiro para um registro
    i - Int - Numeração de cada registro ao imprimir

  Retorno:
    String dizendo que chegou ao fim da lista ou se a lista está vazia.
}
function listar(p:tPtRegistro; i:Integer):String;
begin
  if p <> nil then
    begin

      { impressão de cada registro }
      writeln('Registro ', i, ':');
      writeln('Nome: ', p^.nome);
      writeln('Telefone: ', p^.telefone);
      writeln('');

      { acessar o próximo }
      listar := listar(p^.prox, i + 1);
    end
  else
    begin
      if i = 1 then
        { se o item for vazio e é o primeiro ítem, a lista está vazia }
        listar := 'Lista vazia.'
      else
        { senão informar final da listagem }
        listar := 'Fim da lista.'
    end;
end;



{
  5) Pesquisa na lista telefônica por parte do nome.
  Caso encontrar um nome que contenha a substring pesquisada, imprime o registro na tela.

  Parâmetros:
    p - ponteiro para um registro
    part - String - Parte de nome pra busca
    ocorrencias - Int - Acumulador de ocorrências

  Retorno:
    String indicando fim da pesquisa.
}
function pesquisar(var p:tPtRegistro; part:String; ocorrencias:Integer):String;
begin
  if p <> nil then
    begin

      { se parte da string for encontrada, imprimir }
      if Pos(part, p^.nome) > 0 then
        begin

          { imprimindo registro }
          writeln('Registro encontrado:');
          writeln('Nome: ', p^.nome);
          writeln('Telefone: ', p^.telefone);
          writeln('');

          ocorrencias := ocorrencias + 1;
        end;

      { partir pro próximo registro }
      pesquisar := pesquisar(p^.prox, part, ocorrencias);
    end
  else
    begin

      { mostrar no final da listagem quantas ocorrências foram encontradas }
      if ocorrencias = 0 then
        pesquisar := 'Fim da pesquisa. Nenhuma ocorrência encontrada.'
      else if ocorrencias = 1 then
        pesquisar := 'Fim da pesquisa. Foi encontrada 1 ocorrência.'
      else
        pesquisar := Concat('Fim da Pesquisa. Foram encontradas ', IntToStr(ocorrencias), ' ocorrências de nomes contendo "', part, '".');

    end
end;



{
  6) Varre a lista e quando chegar no final, imprime quantos registros a lista possui.

  Parâmetros:
    p - ponteiro para um registro
    qtd - Int - Quantidade de registros até o registro atual
}
function total(var p:tPtRegistro; qtd:Integer):String;
begin
  if p <> nil then
    { enquanto registro não for vazio, acessar próximo e incrementar quantidade }
    total := total(p^.prox, qtd + 1)
  else
    begin

      { chegou ao fim da lista. mostra quantos cadastros existem }
      if qtd = 0 then
        total := 'Lista vazia.'
      else if qtd = 1 then
        total := 'Há apenas 1 registro cadastrado na lista.'
      else
        begin
          total := Concat('Há ', IntToStr(qtd), ' registros cadastrados na lista.');
        end;
    end;
end;



{ Programa principal }
var
  l:tPtRegistro;
  menuopt, telefone:Integer;
  ret:String;
  nome:String[10];
begin
  l := nil;

  { Banner }
  clrscr;
  writeln('Bem vindo ao programa de Lista Telefônica.');
  writeln('');

  menuopt := -1;
  repeat
    if menuopt > -1 then
      clrscr;

    { Imprime menu e habilita ao usuário a escolha das opções }
    writeln('==================================================');
    writeln('MENU PRINCIPAL');
    writeln('1) Inserir');
    writeln('2) Remover');
    writeln('3) Alterar');
    writeln('4) Listar');
    writeln('5) Pesquisar');
    writeln('6) Quantidade de Registros');
    writeln('0) Sair');
    writeln('');
    writeln('Escolha sua opção abaixo:');
    readln(menuopt);
    writeln('');

    ret := '';
    case menuopt OF
      { Opção 0: sair }
      0 : menuopt := menuopt;
      { Opção 1: inserir }
      1 : begin
            writeln('Digite o nome:');
            readln(nome);
            writeln('Digite o telefone:');
            readln(telefone);
            ret := inserir(l, nome, telefone);
          end;
      { Opção 2: remover }
      2 : begin
            writeln('Digite o nome:');
            readln(nome);
            ret := remover(l, nome);
          end;
      { Opção 3: alterar }
      3 : begin
            writeln('Digite o nome:');
            readln(nome);
            ret := alterar(l, nome);
          end;
      { Opção 4: listar registros }
      4 : begin
            writeln('Listando registros...');
            writeln('');
            ret := listar(l, 1);
          end;
      { Opção 5: pesquisar }
      5 : begin
            writeln('Digite o nome ou parte:');
            readln(nome);
            ret := pesquisar(l, nome, 0);
          end;
      { Opção 6: total de registros }
      6 : begin
            ret := total(l, 0);
          end;
      { Mostrar erro caso nenhuma opção for escolhida }
      else writeln('Opção inválida.');
    end;

    { Se o retorno não for vazio, mostrar a mensagem }
    if ret <> '' then
      begin
        writeln('--------------------------------------------------');
        writeln(ret);
      end;

    { Mostra mensagem e prompt antes de voltar ao menu inicial }
    if menuopt <> 0 then
      begin
        writeln('');
        writeln('Digite qualquer tecla para voltar ao menu inicial.');
        readkey;
      end;

  until(menuopt = 0);
  writeln('Obrigado por utilizar o programa.');
end.
