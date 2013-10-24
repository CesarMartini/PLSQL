CREATE OR REPLACE PROCEDURE p_gerar_sap_prop(ano_mes NUMBER) AS
  CURSOR c_prop IS SELECT cd_proprietario, nome_proprietario, telefone, nr_cpf, tp_proprietario FROM loc_proprietario;
  v_prop c_prop%rowtype;
  qtde NUMBER:= 0;
  PRAGMA autonomous_transaction;
  BEGIN
    OPEN c_prop;
      LOOP
        FETCH c_prop INTO v_prop;
          EXIT WHEN c_prop%notfound;
          SELECT f_qtd_veiculo_locacao(ano_mes, v_prop.cd_proprietario) INTO qtde FROM dual;
          IF qtde > 0 THEN
             IF v_prop.tp_proprietario = 'F' THEN
                 INSERT
                   INTO TAB_ENVIO_EBS
                   (
                       DT_ENVIO,
                       ANO_MES,
                       CD_PROPRIETARIO,
                       NOME_PROPRIETARIO,
                       TELEFONE,
                       NR_CPF,
                       QTD_LOCACOES
                    )
                    VALUES
                    (
                        SYSDATE,
                        ano_mes,
                        v_prop.cd_proprietario,
                        v_prop.nome_proprietario,
                        v_prop.telefone,
                        v_prop.nr_cpf,
                        qtde
                    );
                    COMMIT;
                ELSIF v_prop.tp_proprietario = 'J' THEN
                   INSERT
                      INTO TAB_ENVIO_EBS
                      (
                          DT_ENVIO,
                          ANO_MES,
                          CD_PROPRIETARIO,
                          NOME_PROPRIETARIO,
                          TELEFONE,
                          NR_CNPJ,
                          QTD_LOCACOES
                      )
                      VALUES
                      (
                        SYSDATE,
                        ano_mes,
                        v_prop.cd_proprietario,
                        v_prop.nome_proprietario,
                        v_prop.telefone,
                        v_prop.nr_cpf,
                        qtde
                      );
                      COMMIT;
                END IF;
            ELSE
               prc_log_carloca(SYSDATE, v_prop.nome_proprietario, 'O proprietario não possui nenhuma locação');
            END IF;
       END LOOP;
    CLOSE c_prop;
    EXCEPTION
        WHEN OTHERS THEN 
              prc_log_carloca(SYSDATE, v_prop.nome_proprietario, sqlerrm);
END p_gerar_sap_prop;