CREATE OR REPLACE FUNCTION f_qtd_veiculo_locacao  (ano_mes NUMBER, 
  cd_prop loc_proprietario.cd_proprietario%TYPE) RETURN NUMBER IS
  qtd NUMBER := 0;
  BEGIN  
     SELECT COUNT(*) INTO qtd FROM loc_item_locacao l INNER JOIN loc_veiculo v ON  l.nr_placa = v.nr_placa
                AND v.cd_proprietario = cd_prop 
                AND TO_CHAR(l.dt_retirada ,'YYYY') = SUBSTR(ano_mes,1,4) 
                AND TO_CHAR(L.DT_RETIRADA ,'MM') =  SUBSTR(ANO_MES,5,2);
  RETURN qtd;
  EXCEPTION
  WHEN OTHERS THEN 
    raise_application_error(-20001, 'Erro inesperado =>' || sqlerrm);
END;