create or replace function fnc_veiculo 
return sys_refcursor 
is
cursor_saida  sys_refcursor;
begin
  open cursor_saida for select * from loc_veiculo;
  return cursor_saida;
exception
  when others then
  raise_application_error(-20001,'Erro inesperado.' || sqlerrm);
end;

set serveroutput on
declare
  saida_cursor  sys_refcursor;
  registro      loc_veiculo%rowtype;
begin
  saida_cursor := fnc_veiculo;
  loop
    fetch saida_cursor into registro;
    exit when saida_cursor%notfound;
    dbms_output.put_line(registro.nr_placa);
  end loop;
  close saida_cursor;
end;

create table log2tdss 
(
data_evento date,
evento  varchar2(50),
valores varchar2(4000)
)

create or replace procedure log_2tdss
(
p_data_evento in date,
p_evento  in varchar2,
p_valores in log2tdss.valores%type
) is
pragma autonomous_transaction;
begin
  insert into log2tdss (data_evento, evento, valores)
   values (p_data_evento, p_evento, p_valores);
  commit;
exception
 when others then
  null;
end;

create or replace trigger trg_cliente_biu
before insert or update on loc_cliente
for each row
declare
  v_data  date;
  v_evento  varchar2(50);
  v_valores varchar2(4000);
begin
  v_data  := sysdate;
  if inserting then
    v_evento := 'INSERT';
  elsif updating then
    v_evento := 'UPDATE';
  end if;
  v_valores := 'CD_CLIENTE :OLD=' || :OLD.CD_CLIENTE || ' :NEW=' || :NEW.CD_CLIENTE || ' ';
  v_valores := v_valores || 'NM_CLIENTE :OLD=' || :OLD.NM_CLIENTE || ' :NEW=' || :NEW.NM_CLIENTE || ' ';  
  v_valores := v_valores || 'TP_CLIENTE :OLD=' || :OLD.TP_CLIENTE || ' :NEW=' || :NEW.TP_CLIENTE || ' ';  
  
  log_2tdss(v_data, v_evento, v_valores);

exception
  when others then
  raise_application_error(-20001,'Erro na execução da Trigger' || sqlerrm);
end;

select * from loc_cliente where cd_cliente=12344

select * from log2tdss
insert into loc_cliente(cd_cliente, nm_cliente, tp_cliente)
values(12344, 'testesimulado','F');


create or replace package PKG_PROVA2TDS_RM12345 is
  procedure prc_copia_item_locacao;
  function fnc_veiculo return sys_refcursor;
end PKG_PROVA2TDS_RM12345;


create or replace package body PKG_PROVA2TDS_RM12345 is

procedure prc_copia_item_locacao
is
  type tipo_tabela is table of loc_item_locacao_bkp%rowtype;
  array_tabela  tipo_tabela;
begin
  select *
  bulk collect into array_tabela
  from loc_item_locacao;
  
  forall cRegistro  in  array_tabela.first..array_tabela.last
  insert into loc_item_locacao_bkp values array_tabela(cRegistro);
  commit;
exception
  when dup_val_on_index then
    raise_application_error(-20001,'Chave duplicada.' || sqlerrm);
  when others then
    raise_application_error(-20002,'Erro inesperado.' || sqlerrm);
end prc_copia_item_locacao;


function fnc_veiculo 
return sys_refcursor 
is
cursor_saida  sys_refcursor;
begin
  open cursor_saida for select * from loc_veiculo;
  return cursor_saida;
exception
  when others then
  raise_application_error(-20001,'Erro inesperado.' || sqlerrm);
end fnc_veiculo;


end PKG_PROVA2TDS_RM12345;

