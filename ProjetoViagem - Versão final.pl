   /*UESC - Universidade Estadual de Santa Cruz
   Disciplina - Conceitos de Linguagem de Programação (CLP) 2019.2
   Docente - Francisco Bruno
   Discentes - Emmanuel, Gabriel, Guilherme, Mateus, Samuel

   Trabalho requistado pelo professor Francisco Bruno
   como primeiro crédito da disciplina.

   Este trabalho consiste no desenvolvimento de um software
   baseado em programação lógica/declarativa desenvolvido com
   a linguagem de programação Prolog.

   O software tem como propósito ser capaz de mostrar as
   rotas e horários de uma linha de ônibus entre cidades.
   Os dados utilizado para preecher a base de conhecimento foram
   retirados do site da AGERBA, onde este mesmo aparenta estar
   desatualizado.

   Como trabalho acadêmico, apenas três empresas foram consideradas:
   Cidade Sol, Águia branca e Rota.*/

   /*Função responsável por desmembrar a lista que se encontra na base de conhecimento (linha)
   e atribuir cada dado à uma variável. A função também é responsável por identificar se a cidade
   de partida ou de destino é uma cidade intermediária (onde a linha apenas passa).*/
viagem(P1, P2, Dia,Linha,Empresa,Partida) :-
	linha(P3,P4,Cidades,TravellList),
	membro(Empresa/Linha/Partida/Dias, TravellList),
	diaviagem(Dia,Dias),
	membro(P1,Cidades),
	membro(P2,Cidades),P1\=P2;
	linha(P1,P2,Cidades,TravellList),
	membro(Empresa/Partida/Dias, TravellList),
	diaviagem(Dia,Dias),
	membro(P1,Cidades),P1\=P2;
	linha(P1,P2,Cidades,TravellList),
	membro(Empresa/Partida/Dias, TravellList),
	diaviagem(Dia,Dias),
	membro(P2,Cidades),P2\=P1.

   /*Esta função é responsável por verificar de um determinado dado
   pertence à uma determinada lista.*/
membro(X, [X | _]).
membro(X, [_ | L]) :- membro(X, L).

   /*Esaa função é responsável por verificar se uma linha tem todos os horários (todoDia)
   ou apenas alguns dias em específico, retornando cada dia que consta na base de conhecimento*/
diaviagem(Dia, todoDia) :- membro(Dia,[seg,ter,qua,qui,sex,sab,dom]).
diaviagem(Dia, Dias) :- membro(Dia,Dias).

   /*Essa função recebe as informações que foram desmembradas pela função viagem e monta uma
   estrutura organizada. Pelo fato de ser recursiva este caso base apenas recebe as informações
   que foram lapidas da base de conhecimento. Apenas mostra a rota e suas informações.*/
route(P1,P2,Dia,[P1-P2 : Empresa : Linha : Partida]) :- viagem(P1,P2,Dia,Linha,Empresa,Partida).

   /*Essa função faz parte da recursividade da função acima. Esta função vai verificar
   se existem quebras de linhas, por exemplo não há linha direto de A-D, mas tem A-C e C-D
   então essa função vai verificar isso e na estrutura entre parêntese mostrar qual caminho
   deve percorrer e os horários de cada linha.*/
route(P1,P2,Dia,[P1-P3 : Empresa : Linha : Partida1 | Route]) :-
	route(P3,P2,Dia,Route),
	viagem(P1,P3,Dia,Linha,Empresa,Partida1),
	deptime(Route,Partida2).

   /*Função que retorna o tempo de partida*/
deptime([P1-P2 : Part | _], Part).


   /*Abaixo está toda a base de conhecimento retirado do site da AGERBA*/
linha(bom_despacho, cairu, [bom_despacho, nazare, sao_bernardo, ent_camassandi, valenca, taperoa, nilo_pecanha, cairu], [cidade_sol/"646"/"13:00"/[seg,ter,qua,qui,sex,sab]]).

linha(cairu, bom_despacho, [cairu, nilo_pecanha, taperoa, valenca, ent_camassandi, sao_bernardo, nazare, bom_despacho], [cidade_sol/"646"/"06:30"/[seg,ter,qua,qui,sex,sab]]).

linha(ipiau, gandu, [ipiau, ibirataia, algodao, gandu], [cidade_sol/"608"/"17:30"/[dom]]).

linha(gandu, ipiau, [gandu, ibirataia, algodao, ipiau], [cidade_sol/"608"/"05:30"/[dom]]).

linha(bom_despacho, valenca, [bom_despacho, nazare, valenca], [cidade_sol/"596.MEP"/"09:20"/[seg,ter,qua,qui,sex,sab], cidade_sol/"596.MEP"/"16:20"/[seg, ter, qua, qui, sex, sab ]]).

linha(valenca, bom_despacho, [valenca, nazare, bom_despacho], [cidade_sol/"596.MEP"/"06:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"596.MEP"/"12:40"/[seg,ter,qua,qui,sex,sab]]).

linha(bom_despacho, valenca, [bom_despacho, ent_itaparica, ent_cacha_pregos, ent_salinas_da_margarida, nazare, ent_jaguaripe, ent_camassandi, ent_guaibim, guaibim, valenca], [cidade_sol/"596"/"19:00"/[seg,ter,qua,qui,sex,sab]]).

linha(valenca, bom_despacho, [valenca, nazare, guaibim, ent_salinas_da_margarida, ent_jaguaripe, ent_itaparica, ent_guaibim, ent_camassandi, ent_cacha_pregos, bom_despacho], [cidade_sol/"596"/"14:50"/[seg,ter,qua,qui,sex,sab]]).

linha(bom_despacho, itacare, [bom_despacho, nazare, valenca, taperoa, nilo_pecanha, itubera, camamu, itacare], [cidade_sol/"579A2.EXE"/"08:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579A2.EXE"/"15:20"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itacare, bom_despacho, [itacare, valenca, taperoa, nilo_pecanha, nazare, itubera, camamu, bom_despacho], [cidade_sol/"579A2.EXE"/"09:00"/[seg,ter,quaa,qui,sex,sab,dom], cidade_sol/"579A2.EXE"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(bom_despacho, itacare, [bom_despacho, nazare, sao_bernardo, entronc_camassandi, entronc_guaibim, valenca, taperoa, nilo_pecanha, itubera, camamu, tapuia, ent_taboquinhas, itacare], [cidade_sol/"579A2"/"05:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579A2"/"06:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579A2"/"11:20"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itacare, bom_despacho, [itacare, valenca, tapuia, taperoa, sao_bernardo, nilo_pecanha, nazare, itubera, entronc_guaibim, entronc_camassandi, ent_taboquinhas, camamu, bom_despacho], [cidade_sol/"579A2"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579A2"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579A2"/"13:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(bom_despacho, marau, [bom_despacho, nazare, sao_bernardo, ent_camassandi, ent_guaibim, valenca, taperoa, nilo_pecanha, itubera, camamu, tapuia, ent_marau, marau], [cidade_sol/"579A"/"18:00"/[sab]]).

linha(marau, bom_despacho, [marau, valenca, tapuia, taperoa, sao_bernardo, nilo_pecanha, nazare, itubera, ent_marau, ent_guaibim, ent_camassandi, camamu, bom_despacho], [cidade_sol/"579A"/"05:20"/[sab]]).

linha(bom_despacho, camamu, [bom_despacho, nazare, sao_bernardo, ent_camassandi, ent_guaibim, valenca, taperoa, nilo_pecanha, itubera, camamu], [cidade_sol/"579"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579"/"18:00"/[seg,ter,qua,qui,sex]]).

linha(camamu, bom_despacho, [camamu, valenca, taperoa, sao_bernardo, nilo_pecanha, nazare, itubera, ent_guaibim, ent_camassandi, bom_despacho], [cidade_sol/"579"/"03:40"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579"/"05:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"579"/"07:20"/[seg,ter,qua,qui,sex]]).

linha(bom_despacho, jequie, [bom_despacho, ent_cacha_pregos, ent_salinas_da_margarida, nazare, muniz_ferreira, santo_antonio_de_jesus, ent_laje, laje, mutuipe, jiquirica, ubaira, engenheiro_franca, santa_ines, cravolandia, itaquara, jaguaquara, pati, baixao, jequie], [cidade_sol/"569x"/"13:10"/[sab]]).

linha(jequie, bom_despacho, [jequie, ubaira, santo_antonio_de_jesus, santa_ines, pati, nazare, mutuipe, muniz_ferreira, laje, jiquirica, jaguaquara, itaquara, ent_salinas_da_margarida, ent_laje, ent_cacha_pregos, engenheiro_franca, cravolandia, baixao, bom_despacho], [cidade_sol/"569x"/"05:00"/[sab]]).

linha(bom_despacho, cravolandia, [bom_despacho, ent_cacha_pregos, ent_salinas_da_margarida, nazare, muniz_ferreira, santo_antonio_de_jesus, ent_laje, laje, mutuipe, juquirica, ubaira, engenheiro_franca, santa_ines, cravolandia], [cidade_sol/"569"/"14:20"/[seg,ter,qua,qui,sex]]).

linha(cravolandia, bom_despacho, [cravolandia, ubaira, santo_antonio_de_jesus, santa_ines, nazare, mutuipe, muniz_ferreira, laje, juquirica, ent_salinas_da_margarida, ent_laje, ent_cacha_pregos, engenheiro_franca, bom_despacho], [cidade_sol/"569"/"07:15"/[seg,ter,qua,qui,sex]]).

linha(ilheus, calononia_de_una, [ilheus, olivenca, acuipe, lagoa, rio_da_serra, una, calononia_de_una], [cidade_sol/"567"/"16:00"/[seg,ter,qua,qui,sex,sab]]).

linha(calononia_de_una, ilheus, [calononia_de_una, una, rio_da_serra, olivenca, lagoa, acuipe, ilheus], [cidade_sol/"567"/"05:30"/[seg,ter,qua,qui,sex,sab]]).

linha(bom_despacho, amargosa, [bom_despacho, nazare, santo_antonio_de_jesus, elisio_medrado, amargosa], [cidade_sol/"563a2.exe"/"17:20"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(amargosa, bom_despacho, [amargosa, santo_antonio_de_jesus, nazare, elisio_medrado, bom_despacho], [cidade_sol/"563a2.exe"/"05:50"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(bom_despacho, amargosa, [bom_despacho, ent_cacha_pregos, ent_salinas_da_margarida, nazare, ent_muniz_ferreira, santo_antonio_de_jesus, ent_sao_miguel_das_matas, ent_elisio_medrado, elisio_medrado, amargosa], [cidade_sol/"563A2"/"07:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"563A2"/"12:20"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(amargosa, bom_despacho, [amargosa, santo_antonio_de_jesus, nazare, ent_sao_miguel_das_matas, ent_salinas_da_margarida, ent_muniz_ferreira, ent_elisio_medrado, ent_cacha_pregos, elisio_medrado, bom_despacho], [cidade_sol/"563A2"/"12:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"563A2"/"17:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(bom_despacho, casto_alves, [bom_despacho, ent_cacha_pregos, ent_salinas_da_margarida, nazare, ent_muniz_ferreira, santo_antonio_de_jesus, ent_sao_miguel_das_matas, sao_miguel_das_matas, ent_elisio_medrado, elisio_medrado, santa_teresinha, casto_alves], [cidade_sol/"563A"/"14:20"/[seg,ter,qua,qui,sex]]).

linha(casto_alves, bom_despacho, [casto_alves, sao_miguel_das_matas, santo_antonio_de_jesus, santa_teresinha, nazare, ent_sao_miguel_das_matas, ent_salinas_da_margarida, ent_muniz_ferreira, ent_elisio_medrado, ent_cacha_pregos, elisio_medrado, bom_despacho], [cidade_sol/"563A"/"05:50"/[seg,ter,qua,qui,sex]]).

linha(ilheus, canavieiras, [ilheus, olivenca, acuipe, rio_da_serra, una, comandatuba, ent_comandatuba, puxim_do_sol, ent_km18, canavieiras], [cidade_sol/"560E"/"06:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(canavieiras, ilheus, [canavieiras, una, rio_da_serra, puxim_do_sol, olivenca, ent_km18, ent_comandatuba, comandatuba, acuipe, ilheus], [cidade_sol/"560E"/"07:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itabuna, canavieiras, [itabuna, ilheus, olivenca, acuipe, rio_da_serra, una, comandatuba, ent_comandatuba, puxim_do_sul, ent_km18, canavieiras], [cidade_sol/"560"/"06:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"10:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"12:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"14:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"16:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(canavieiras, itabuna, [canavieiras, una, rio_da_serra, puxim_do_sul, olivenca, ilheus, ent_km18, ent_comandatuba, comandatuba, acuipe, itabuna], [cidade_sol/"560"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"09:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"11:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"15:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"560"/"18:10"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(vitoria_da_conquista, ibicui, [vitoria_da_conquista, planalto, pocoes, serra, nova_canaa, iguai, ibicui], [cidade_sol/"556"/"15:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"556"/"17:45"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(ibicui, vitoria_da_conquista, [ibicui, serra, pocoes, planalto, nova_canaa, iguai, vitoria_da_conquista], [cidade_sol/"556"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"556"/"07:00"/[seg,ter,qua,qui,sex,sab]]).

linha(bom_despacho, salinas_da_margarida, [bom_despacho, muta, encarnacao, salinas_da_margarida], [cidade_sol/"552.exe"/"14:01"/[sex]]).

linha(salinas_da_margarida, bom_despacho, [salinas_da_margarida, muta, encarnacao, bom_despacho], [cidade_sol/"552.exe"/"17:01"/[dom]]).

linha(bom_despacho, salinas_da_margarida, [bom_despacho, ent_itaparica, ent_cacha_pregos, ent_salinas_da_margarida, ent_muta, muta, ent_encarnacao, encarnacao, salinas_da_margarida], [cidade_sol/"552"/"09:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"552"/"13:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"552"/"15:20"/[seg,ter,quar,qui,sex,sab], cidade_sol/"552"/"17:20"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salinas_da_margarida, bom_despacho, [salinas_da_margarida, muta, ent_salinas_da_margarida, ent_muta, ent_itaparica, ent_encarnacao, ent_cacha_pregos, encarnacao, bom_despacho], [cidade_sol/"552"/"09:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"552"/"12:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"552"/"14:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"552"/"17:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, barra_do_mendes, [salvador, feira_de_santana, ipira, mundo_novo, morro_do_chapeu, irace, ibitita, ibipeba, barra_do_mendes], [cidade_sol/"548.exe"/"20:02"/[sex]]).

linha(barra_do_mendes, salvador, [barra_do_mendes, mundo_novo, morro_do_chapeu, irace, ipira, ibitita, ibipeba, feira_de_santana, salvador], [cidade_sol/"548.exe"/"19:31"/[dom]]).

linha(salvador, barra_do_mendes, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, america_dourada, joao_dourado, irece, tanquinho, ibitita, ibipeba, barra_do_mendes], [cidade_sol/"548.car"/"20:00"/[seg,ter,qua,qui,sex,sab]]).

linha(barra_do_mendes, salvador, [barra_do_mendes, tanquinho, mundo_novo, morro_do_chapeu, joao_dourado, irece, ipira, ibitita, ibipeba, feira_de_santana, ent_piritiba, ent_mundo_novo, baixa_grande, america_dourada, salvador], [cidade_sol/"548.car"/"19:30"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, barra_do_mendes, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, america_dourada, joao_dourado, irece, tanquinho, ibitita, ibipeba, barra_do_mendes], [cidade_sol/"548"/"20:00"/[sab,dom]]).

linha(barra_do_mendes, salvador, [barra_do_mendes, tanquinho, mundo_novo, morro_do_chapeu, joao_dourado, irece, ipira, ibitita, ibipeba, feira_de_santana, ent_piritiba, ent_mundo_novo, baixa_grande, america_dourada, salvador], [cidade_sol/"548"/"19:30"/[sab,dom]]).

linha(jacobina, irice, [jacobina, varzea_nova, ico, morro_do_chapeu, irice], [cidade_sol/"545"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"545"/"08:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(irice, jacobina, [irice, varzea_nova, morro_do_chapeu, ico, jacobina], [cidade_sol/"545"/"06:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"545"/"16:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, canarana, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, irece, canarana], [cidade_sol/"527"/"10:00"/[sab]]).

linha(canarana, salvador, [canarana, mundo_novo, morro_do_chapeu, irece, ipira, feira_de_santana, ent_piritiba, ent_mundo_novo, baixa_grande,salvador], [cidade_sol/"527"/"07:00"/[sab]]).

linha(salvador, tapiramuta, [salvador, feira_de_santana, ipira, baixa_grande, mundo_novo, piritiba, tapiramuta], [cidade_sol/"517.exe"/"13:01"/[sex]]).

linha(tapiramuta, salvador, [tapiramuta, piritiba, mundo_novo, ipira, feira_de_santana, baixa_grande, salvador], [cidade_sol/"517.exe"/"23:30"/[dom]]).

linha(salvador, tapiramuta, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, piritiba, entronc-ba052/ba424, tapiramuta], [cidade_sol/"517.car"/"13:00"/[sab]]).

linha(tapiramuta, salvador, [tapiramuta, serra_preta, piritiba, mundo_novo, ipira, feira_de_santana, entronc-ba052/ba424, ent_serra_preta, ent_mundo_novo, ent_bravo, ent_anguera, bravo, baixa_grande, anguera, salvador], [cidade_sol/"517.car"/"06:00"/[dom]]).

linha(salvador, tapiramuta, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, piritiba, entronc_ba052/ba424, tapiramuta], [cidade_sol/"517"/"13:00"/[ter,qua]]).

linha(tapiramuta, salvador, [tapiramuta, serra_preta, piritiba, mundo_novo, ipira, feira_de_santana, entronc_ba052/ba424, ent_serra_preta, ent_mundo_novo, ent_bravo, ent_anguera, bravo, baixa_grande, anguera, salvador], [cidade_sol/"517"/"06:00"/[sex,sab]]).

linha(salvador, morro_do_chapeu, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, morro_do_chapeu], [cidade_sol/"510"/"06:30"/[sab]]).

linha(morro_do_chapeu, salvador, [morro_do_chapeu, serra_preta, mundo_novo, morro_do_chapeu, ipira, feira_de_santana, ent_serra_preta, ent_piritiba, ent_mundo_novo, ent_bravo, ent_anguera, bravo, baixa_grande, anguera, salvador], [cidade_sol/"510"/"11:00"/[sab]]).

linha(salvador, seabra, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, ent_bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_tapiramuta, morro_do_chapeu, ent_cafarnaum, cafarnaum, mulungu_do_morro, souto_soares, iraquara, carne_assada, seabra], [cidade_sol/"503a"/"09:00"/[sab]]).

linha(seabra, salvador, [seabra, souto_soares, mundo_novo, mulungu_do_morro, morro_do_chapeu, iraquara, ipira, feira_de_santana, ent_tapiramuta, ent_serra_preta, ent_mundo_novo, ent_cafarnaum, ent_bravo, ent_anguera, carne_assada, cafarnaum, baixa_grande, anguera, salvador], [cidade_sol/"503a"/"05:00"/[seg]]).

linha(salvador, cafarnaum, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, ent_bravo, ipira, baixa_grnade, ent_mundo_novo, mundo_novo, ent_tapiramuta, morro_do_chapeu, ent_cafarnaum, cafarnaum], [cidade_sol/"503.car"/"20:01"/[dom]]).

linha(cafarnaum, salvador, [cafarnaum, mundo_novo, morro_do_chapeu, ipira, feira_de_santana, ent_tapiramuta, ent_serra_preta, ent_mundo_novo, ent_cafarnaum, ent_bravo, ent_anguera, baixa_grnade, anguera, salvador], [cidade_sol/"503.car"/"21:41"/[seg]]).

linha(salvador, cafarnaum, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, ent_bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_tapiramuta, morro_do_chapeu, ent_cafarnaum, cafarnaum], [cidade_sol/"503"/"20:01"/[sex]]).

linha(cafarnaum, salvador, [cafarnaum, mundo_novo, morro_do_chapeu, ipira, feira_de_santana, ent_tapiramuta, ent_serra_preta, ent_mundo_novo, ent_cafarnaum, ent_bravo, ent_anguera, baixa_grande, anguera, salvador], [cidade_sol/"503"/"21:20"/[dom]]).

linha(gandu, apuarema, [gandu, palmeira, itamari, apuarema], [cidade_sol/"497"/"09:00"/[sab]]).

linha(apuarema, gandu, [apuarema, palmeira, itamari, gandu], [cidade_sol/"497"/"07:10"/[sab]]).

linha(itabuna, ubata, [itabuna, ent_itajuipe, itajuipe, posto_santo_antonio, ubaitaba, orico, ubata], [cidade_sol/"496"/"15:00"/[seg,ter,qua,qui,sex]]).

linha(ubata, itabuna, [ubata, ubaitaba, posto_santo_antonio, orico, itajuipe, ent_itajuipe, itabuna], [cidade_sol/"496"/"05:40"/[seg,ter,qua,qui,sex]]).

linha(salvador, coracao_de_maria, [salvador, entronc_br324/ba093, menino_jesus, ent_sao_sebastiao_do_passe, ent_santo_amaro, ent_conceicao_do_jacuipe, ent_alianca, amelia_rodrigues, posto_sao_luiz, conceicao_do_jacuipe, coracao_de_maria], [cidade_sol/"491"/"00"/[]]).

linha(coracao_de_maria, salvador, [coracao_de_maria, posto_sao_luiz, menino_jesus, entronc_br324/ba093, ent_sao_sebastiao_do_passe, ent_santo_amaro, ent_conceicao_do_jacuipe, ent_alianca, conceicao_do_jacuipe, amelia_rodrigues, salvador], [cidade_sol/"491"/"18:00"/[dom]]).

linha(salvador, wagner, [salvador, feira_de_santana, ent_antonio_cardoso, ent_santo_estevao, ent_paiaia, argoim, vila_sao_vicente, itaberaba, ent_boa_vista_do_tupim, zuca, ent_ibiquera, ent_andarai, wagner], [cidade_sol/"475e"/"20:30"/[sab]]).

linha(wagner, salvador, [wagner, zuca, vila_sao_vicente, itaberaba, feira_de_santana, ent_santo_estevao, ent_paiaia, ent_ibiquera, ent_boa_vista_do_tupim, ent_antonio_cardoso, ent_andarai, argoim, salvador], [cidade_sol/"475e"/"21:05"/[sab]]).

linha(salvador, utinga, [salvador, feira_de_santana, ent_santo_estevao, itaberaba, ent_andarai, wagner,utinga], [cidade_sol/"475.exe"/"20:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(utinga, salvador, [utinga, wagner,ent_andarai,itaberaba, ent_santo_estevao, feira_de_santana, salvador], [cidade_sol/"475.exe"/"20:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, utinga, [salvador, feira_de_santana, ent_antonio_cardoso, ent_santo_estevao, ent_paiaia, argoim, vila_sao_vicente, itaberaba, ent_boa_vista_do_tupim, zuca, ent_ibiquera, ent_andarai, wagner, utinga], [cidade_sol/"475"/"14:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(utinga, salvador, [utinga, zuca, wagner, vila_sao_vicente, itaberaba, feira_de_santana, ent_santo_estevao, ent_paiaia, ent_ibiquera, ent_boa_vista_do_tupim, ent_antonio_cardoso, ent_andarai, argoim, salvador], [cidade_sol/"475"/"05:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(feira_de_santana, utinga, [feira_de_santana, argoim, itaberaba, zuca, wagner, utinga], [cidade_sol/"446"/"11:30"/[qui]]).

linha(utinga, feira_de_santana, [utinga, zuca, wagner, itaberaba, argoim, feira_de_santana], [cidade_sol/"446"/"05:00"/[sex]]).

linha(jequie, ilheus, [jequie, jitauna, ipiau, barra_do_rocha, ubata, ubaitaba, urucuca, ilheus], [cidade_sol/"427.exe"/"09:00"/[seg,ter,qua,qui,sex,sab]]).

linha(ilheus, jequie, [ilheus, urucuca, ubata, ubaitaba, jitauna, ipiau, barra_do_rocha, jequie], [cidade_sol/"427.exe"/"14:00"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, ilheus, [jequie, jitauna, ipiau, barra_do_rocha, ubata, entronc_br101/br330, ubaitaba, posto_santo_antonio, urucuca, ilheus], [cidade_sol/"427"/"05:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(ilheus, jequie, [ilheus, urucuca, ubata, ubaitaba, posto_santo_antonio, jitauna, ipiau, entronc_br101/br330, barra_do_rocha, jequie], [cidade_sol/"427"/"11:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itaberaba, iramaia, [itaberaba, iacu, joao_amaro, marcionilio_souza, ent_iramaia, iramaia], [cidade_sol/"411r2"/"15:50"/[sab]]).

linha(iramaia, itaberaba, [iramaia, marcionilio_souza, joao_amaro, iacu, ent_iramaia, itaberaba], [cidade_sol/"411r2"/"04:30"/[sab]]).

linha(itaberaba, marcionilio, [itaberaba, iacu, joao_amaro, marcionilio], [cidade_sol/"411r"/"15:50"/[dom]]).

linha(marcionilio, itaberaba, [marcionilio, joao_amaro, iacu, itaberaba], [cidade_sol/"411r"/"06:30"/[dom]]).

linha(salvador, iramaia, [salvador, feira_de_satana, ent_santo_estevao, itaberaba, iacu, marcionilio_souza, iramaia], [cidade_sol/"411.exe"/"10:35"/[sex]]).

linha(iramaia, salvador, [iramaia, marcionilio_souza, itaberaba, iacu, feira_de_satana, ent_santo_estevao, salvador], [cidade_sol/"411.exe"/"04:40"/[dom]]).

linha(salvador, iramaia, [salvador, ent_sao_sebastiao_do_passe, amelia_rodrigues, feira_de_santana, ent_santo_estevao, km_50, argoim, itaberaba, iacu, joao_amaro, marcionilio_souza, ent_iramaia, iramaia], [cidade_sol/"411"/"11:00"/[seg,ter,qua,qui,sex]]).

linha(iramaia, salvador, [iramaia, marcionilio_souza, km_50, joao_amaro, itaberaba, iacu, feira_de_santana, ent_sao_sebastiao_do_passe, ent_santo_estevao, ent_iramaia, argoim, amelia_rodrigues, salvador], [cidade_sol/"411"/"04:30"/[seg,ter,qua,qui,sex,sab]]).


linha(feira_de_santana, mairi, [feira_de_santana, ent_anguera, anguera, ipira, baixa_grande, mairi], [cidade_sol/"410"/"07:00"/[seg,ter,qua,qui,sex]]).

linha(mairi, feira_de_santana, [mairi, ipira, ent_anguera, baixa_grande, anguera, feira_de_santana], [cidade_sol/"410"/"14:00"/[seg,ter,qua,qui,sab]]).

linha(irece, cafarnaum, [irece, joao_dourado, ipanema, lagoa_dos_borges, america_dourada, entronc_ba052/br122, faz_araguaia, cafarnaum], [cidade_sol/"407"/"19:30"/[dom]]).

linha(cafarnaum, irece, [cafarnaum, lagoa_dos_borges, joao_dourado, ipanema, faz_araguaia, entronc_ba052/br122, america_dourada, irece], [cidade_sol/"407"/"06:00"/[sab]]).

linha(irece, xique_xique, [irece, queimadas, central, rio_verde, ent_itaguacu, varzea_grnade, xique_xique], [cidade_sol/"405"/"12:30"/[seg]]).

linha(xique_xique, irece, [xique_xique, varzea_grnade, rio_verde, queimadas, ent_itaguacu, central, irece], [cidade_sol/"405"/"15:00"/[seg]]).

linha(itubera, gandu, [itubera, pirai_do_norte, gandu], [cidade_sol/"385R"/"06:15"/[seg,ter,qua,qui,sex,sab], cidade_sol/"385"/"11:40"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"385R"/"15:00"/[seg,ter,qua,qui,sex]]).

linha(gandu, itubera, [gandu, pirai_do_norte, itubera], [cidade_sol/"385r"/"06:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"385r"/"11:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"385"/"15:00"/[seg,ter,qua,qui]]).

linha(jequie, gandu, [jequie, jitauna, ipiau, ibirataia, algodao, gandu], [cidade_sol/"382x"/"16:00"/[seg,ter,qua,qui,sex,sab]]).

linha(gandu, jequie, [gandu, jitauna, ipiau, ibirataia, algodao, jequie], [cidade_sol/"382x"/"05:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, santa_ines, [jequie, baixao, pati, ent_jaguaquara, jaguaquara, itaquara, santa_ines], [cidade_sol/"363E"/"15:30"/[sab]]).

linha(santa_ines, jequie, [santa_ines, pati, jaguaquara, itaquara, ent_jaguaquara, baixao, jequie], [cidade_sol/"383e"/"05:35"/[sab]]).

linha(jequie, cravolandia, [jequie, baixao, ati, ent_jaguaquara, jaguaquara, itaquara, santa_ines, cravolandia], [cidade_sol/"363"/"15:30"/[seg,ter,qua,qui,sex]]).

linha(cravolandia, jequie, [cravolandia, santa_ines, jaguaquara, itaquara, ent_jaguaquara, baixao, ati, jequie], [cidade_sol/"363"/"05:20"/[seg,ter,qua,qui,sex]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, anguera, ipira, baixa_grande, macajuba, ruy_barbosa], [cidade_sol/"330.exe"/"16:00"/[seg,sex]]).

linha(ruy_barbosa, salvador, [ruy_barbosa, macajuba, ipira, feira_de_santana, baixa_grande, anguera, salvador], [cidade_sol/"330.exe"/"05:30"/[seg,sex]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, ent_anguera, ipira, baixa_grande, macajuba, ruy_barbosa], [cidade_sol/"330.car"/"16:00"/[qui]]).

linha(ruy_barbosa, salvador, [ruy_barbosa, macajuba, ipira, feira_de_santana, ent_anguera, baixa_grande, salvador], [cidade_sol/"330.car"/"05:30"/[qui]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, ent_anguera, anguera, ipira, baixa-grande, macajuba, ruy_barbosa], [cidade_sol/"330"/"15:00"/[ter,qua,sab,dom]]).

linha(ruy_barbosa, salvador, [ruy_barbosa, macajuba, ipira, feira_de_santana, ent_anguera, baixa-grande, anguera, salvador], [cidade_sol/"330"/"05:30"/[ter,qua,sab,dom]]).

linha(salvador, xique_xique, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, ent_piritiba, morro_do_chapeu, irece, central, xique_xique], [cidade_sol/"329a.esl"/"21:30"/[seg,ter,qua,qui,sex,dom]]).

linha(xique_xique, salvador, [xique_xique, morro_do_chapeu, irece, ipira, feira_de_santana, ent_piritiba, ent_mundo_novo, central, baixa_grande, salvador], [cidade_sol/"329a.esl"/"17:50"/[seg,ter,qua,qui,sex,dom]]).

linha(salvador, barra, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, irece, ent_sao_gabriel, sao_gabriel, central, xique_xique, barra], [cidade_sol/"329a"/"06:30"/[dom]]).

linha(barra, salvador, [barra, xique_xique, sao_gabriel, mundo_novo, morro_do_chapeu, irece, ipira, feira_de_santana, ent_sao_gabriel, ent_piritiba, ent_mundo_novo, central, baixa_grande, salvador], [cidade_sol/"329a"/"05:00"/[dom]]).

linha(salvador, xique_xique, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, irece, ent_sao_gabriel, sao_gabriel, central, xique_xique], [cidade_sol/"329.car"/"06:30"/[seg,ter,qua,qui,sex]]).

linha(xique_xique, salvador, [xique_xique, sao_gabriel, mundo_novo, morro_do_chapeu, irece, ipira, feira_de_santana, ent_sao_gabriel, ent_piritiba, ent_mundo_novo, central, baixa_grande, salvador], [cidade_sol/"329.car"/"07:20"/[seg,ter,qua,qui,sex]]).

linha(salvador, xique_xique, [salvador, feira_De_santana, ipira, baixa_grande, ent_mundo_novo, mundo_novo, ent_piritiba, morro_do_chapeu, irece, ent_sao_gabriel, sao_gabriel, central, xique_xique], [cidade_sol/"329"/"06:30"/[sab]]).

linha(xique_xique, salvador, [xique_xique, sao_gabriel, mundo_novo, morro_do_chapeu, irece, ipira, feira_De_santana, ent_sao_gabriel, ent_piritiba, ent_mundo_novo, central, baixa_grande, salvador], [cidade_sol/"329"/"07:20"/[sab]]).


linha(salvador, irece, [salvador, feira_de_santana, ent_mundo_novo, morro_do_chapeu, irece], [cidade_sol/"328.esl"/"12:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(irece, salvador, [irece, morro_do_chapeu, feira_de_santana, ent_mundo_novo, salvador], [cidade_sol/"328.esl"/"12:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, irece, [salvador, feira_de_santana, ipira, baixa_grande, ent_mundo_novo, ent_piritiba, morro_do_chapeu, irece], [cidade_sol/"328"/"10:00"/[sab, dom]]).

linha(irece, salvador, [irece, morro_do_chapeu, ipira, feira_de_santana, ent_piritiba, ent_mundo_novo, baixa_grande, salvador], [cidade_sol/"328"/"07:00"/[sab,dom]]).

linha(salvador, entronc_br324/br101, [salvador, ent_sao_goncalo_dos_campos, ent_conceicao_da_feira, ent_muritiba, ent_governador, ent_cruz_das_almas, cruz_das_almas, ent_sapeacu, ent_conceicao_do_almeida, santo_antonio_de_jesus, laje, mutuipe, jiquirica, ubaira, jenipapo, engenheiro_franca, entronc_br324/br101], [cidade_sol/"327a3"/"15:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(entronc_br324/br101, salvador, [entronc_br324/br101, ubaira, santo_antonio_de_jesus, mutuipe, laje, jiquirica, jenipapo, ent_sapeacu, ent_sao_goncalo_dos_campos, ent_muritiba, ent_governador, ent_cruz_das_almas, ent_conceicao_do_almeida, ent_conceicao_da_feira, engenheiro_franca, cruz_das_almas, salvador], [cidade_sol/"327a3"/"05:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, irara, [salvador, feira_de_santana, ent_sao_vicente, sao_vicente, santanopolis, ponto_eugenio, irara], [cidade_sol/"324"/"16:30"/[dom]]).

linha(irara, salvador, [irara, sao_vicente, santanopolis, ponto_eugenio, feira_de_santana, ent_sao_vicente, salvador], [cidade_sol/"324"/"05:45"/[seg]]).

linha(salvador, irara, [salvador, amelia_rodrigues, cocneiceicao_do_jacuipe, coracao_de_maria, irara], [cidade_sol/"309.exe"/"16:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(irara, salvador, [irara,coracao_de_maria, cocneiceicao_do_jacuipe, amelia_rodrigues, salvador], [cidade_sol/"309.exe"/"07:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, irara, [salvador, entronc_br324/ba093, menino_jesus/cova_de_defunto, ent_sao_sebastiao_do_passe, ent_santo_amaro, ent_alianca, amelia_rodrigues, posto_sao_luiz, conceicao_do_jacuipe, coracao_de_maria, irara], [cidade_sol/"309"/"06:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"09:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"10:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"18:00"/[seg,ter,qua,qui,sex,sab]]).

linha(irara, salvador, [irara, posto_sao_luiz, menino_jesus/cova_de_defunto, entronc_br324/ba093, ent_sao_sebastiao_do_passe, ent_santo_amaro, ent_alianca, coracao_de_maria, conceicao_do_jacuipe, amelia_rodrigues, salvador], [cidade_sol/"309"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"14:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"309"/"17:30"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, irara, [salvador, entronc_br324/ba093, aloginhas, aramari, ourcangas, irara], [cidade_sol/"306"/"06:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"306"/"15:00"/[seg,ter,qua,qui,sex,sab]]).

linha(irara, salvador, [irara, ourcangas, entronc_br324/ba093, aramari, aloginhas, salvador], [cidade_sol/"306"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"306"/"14:00"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, entronc_br324/ba093, [salvador, menino_jesus/cova_de_defunto, ent_sao_sebastiao_do_passe, ent_santo_amaro, ent_alianca, amelia_rodrigues, posto_sao_luiz, conceicao_do_jacuipe, coracao_de_maria, irara, agua_fria, topo, pataiba, entronc_br324/ba093], [cidade_sol/"305a"/"07:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"305a"/"14:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(entronc_br324/ba093, salvador, [entronc_br324/ba093, topo, posto_sao_luiz, pataiba, menino_jesus/cova_de_defunto, irara, ent_sao_sebastiao_do_passe, ent_santo_amaro, ent_alianca, coracao_de_maria, conceicao_do_jacuipe, amelia_rodrigues, agua_fria, salvador], [cidade_sol/"305a"/"06:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"305a"/"14:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(bom_despacho, santo_antonio_de_jesus, [bom_despacho, ent_itaparica, ent_cacha_pregos, cacha_pregos, ent_salinas_da_margarida, nazare, ent_muniz_ferreira, santo_antonio_de_jesus], [cidade_sol/"304"/"08:20"/[seg,ter,qua,qui,sex,sab], cidade_sol/"304"/"10:20"/[seg,ter,qua,qui,sex,sab], cidade_sol/"304"/"16:20"/[seg,ter,qua,qui,sex,sab], cidade_sol/"304"/"19:20"/[seg,ter,qua,qui,sex,sab]]).

linha(santo_antonio_de_jesus, bom_despacho, [santo_antonio_de_jesus, nazare, ent_salinas_da_margarida, ent_muniz_ferreira, ent_itaparica, ent_cacha_pregos, cacha_pregos, bom_despacho], [cidade_sol/"304"/"05:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"304"/"07:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"304"/"12:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"304"/"16:30"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, itaberaba, [salvador, feira_de_santana, ent_santo_estevao, km_50, ent_iacu, milagres, iacu, itaberaba], [cidade_sol/"296"/"11:00"/[sab]]).

linha(itaberaba, salvador, [itaberaba, milagres, km_50, iacu, feira_de_santana, ent_santo_estevao, ent_iacu, salvador], [cidade_sol/"296"/"08:40"/[dom]]).

linha(salvador, itaberaba, [salvador, feira_de_santana, ent_santo_estevao, itaberaba], [cidade_sol/"295.exe"/"11:00"/[dom]]).

linha(itaberaba, salvador, [itaberaba, feira_de_santana, ent_santo_estevao, salvador], [cidade_sol/"295.exe"/"08:45"/[dom]]).

linha(salvador, boa_vista_do_tupim, [salvador, feira_de_santana, ent_santo_estevao, km_50, argoim, itaberaba, ent_boa_vista_do_tupim, boa_vista_do_tupim], [cidade_sol/"295a2"/"07:30"/[ter]]).

linha(boa_vista_do_tupim, salvador, [boa_vista_do_tupim, km_50, itaberaba, feira_de_santana, ent_santo_estevao, ent_boa_vista_do_tupim, argoim, salvador], [cidade_sol/"295a2"/"06:30"/[qui]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, ent_santo_estevao, itaberaba, ruy_barbosa], [cidade_sol/"295a.exe"/"14:01"/[sex]]).

linha(ruy_barbosa, salvador, [ruy_barbosa, itaberaba, feira_de_santana, ent_santo_estevao, salvador], [cidade_sol/"295a.exe"/"23:41"/[dom]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, ent_santo_estevao, km_50, argoim, itaberaba, ent_zuca, ruy_barbosa], [cidade_sol/"295a"/"15:10"/[dom]]).

linha(ruy_barbosa, salvador, [ruy_barbosa, km_50, itaberaba, feira_de_santana, ent_zuca, ent_santo_estevao, argoim, salvador], [cidade_sol/"295a"/"15:10"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, itaberaba, [salvador, feira_de_santana, ent_santo_estevao, km_50, argoim, itaberaba], [cidade_sol/"295"/"11:00"/[sab]]).

linha(itaberaba, salvador, [itaberaba, km_50, feira_de_santana, ent_santo_estevao, argoim, salvador], [cidade_sol/"295"/"08:45"/[sab]]).

linha(salvador, ibicoara, [salvador, feira_de_santana, ent_santo_estevao, argoim, itaberaba, ent_ibiquera, ent_lajedinho, lajedinho, ent_andarai, andarai, mucege, ibicoara], [cidade_sol/"275a"/"20:30"/[sex]]).

linha(ibicoara, salvador, [ibicoara, mucege, lajedinho, itaberaba, feira_de_santana, ent_santo_estevao, ent_lajedinho, ent_ibiquera, ent_andarai, argoim, andarai, salvador], [cidade_sol/"275a"/"18:30"/[dom]]).

linha(itaberaba, mucege, [itaberaba, ent_ibiquera, ent_lajedinho, lajedinho, ent_andarai, andarai, mucege], [cidade_sol/"275r"/"13:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(mucege, itaberaba, [mucege, lajedinho, ent_lajedinho, ent_ibiquera, ent_andarai, andarai, itaberaba], [cidade_sol/"275R"/"04:30"/[seg,qua,qui,sex,sab,dom]]).

linha(salvador, mucuge, [salvador, feira_de_santana, ent_santo_estevao, ent_lajedinho, andarai, mucuge], [cidade_sol/"275.exe"/"09:31"/[sex]]).

linha(mucuge, salvador, [mucuge, feira_de_santana, ent_santo_estevao, ent_lajedinho, andarai, salvador], [cidade_sol/"275.exe"/"20:10"/[dom]]).

linha(salvador, mucuge, [salvador, feira_de_santana, ent_santo_estevao, argoim, itaberaba, ent_ibiquera, ent_lajedinho, lajedinho, ent_andarai, andarai, mucuge], [cidade_sol/"275"/"08:00"/[sex]]).

linha(mucuge, salvador, [mucuge, lajedinho, itaberaba, feira_de_santana, ent_santo_estevao, ent_lajedinho, ent_ibiquera, ent_andarai, argoim, andarai, salvador], [cidade_sol/"275"/"04:30"/[ter]]).

linha(irece, utinga, [irece, joao_dourado, ipanema, lagoa_dos_borges, america_dourada, ent_cafarnaum, morro_do_chapeu, faz_terra_santa, lagoa_nova, ent_duas_barras, catuaba, bonito, riachao_do_utinga, utinga], [cidade_sol/"272"/"14:30"/[seg,ter,qua,qui,sex,sab]]).

linha(utinga, irece, [utinga, riachao_do_utinga, morro_do_chapeu, lagoa_nova, lagoa_dos_borges, joao_dourado, ipanema, faz_terra_santa, ent_duas_barras, ent_cafarnaum, catuaba, bonito, america_dourada, irece], [cidade_sol/"272"/"05:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, olindina, [salvador, entronc_br324/ba093, ent_camacari, ent_dias_d_avila, ent_pojuca, catu, alagoinhas, inhambupe, olindina], [cidade_sol/"252e"/"16:30"/[te,rqua,qui,sex,sab]]).

linha(olindina, salvador, [olindina, inhambupe, entronc_br324/ba093, ent_pojuca, ent_dias_d_avila, ent_camacari, catu, alagoinhas, salvador], [cidade_sol/"252e"/"07:00"/[ter,qua,qui,sex,sab]]).

linha(salvador, lagoa_redonda, [salvador, catu, alagoinhas, inhambupe, olidina, itapicuru, lagoa_redonda], [cidade_sol/"252.exe"/"11:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(lagoa_redonda, salvador, [lagoa_redonda, olidina, itapicuru, inhambupe, catu, alagoinhas, salvador], [cidade_sol/"252.exe"/"12:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, lagoa_redonda, [salvador, entronc_br324/ba093, ent_camacari, ent_dias_d_avila, ent_pojuca, catu, alagoinhas, inhambupe, onlindina, itapicuru, lagoa_redonda], [cidade_sol/"252"/"05:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(lagoa_redonda, salvador, [lagoa_redonda, onlindina, itapicuru, inhambupe, entronc_br324/ba093, ent_pojuca, ent_dias_d_avila, ent_camacari, catu, alagoinhas, salvador], [cidade_sol/"252"/"05:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itabuna, pocoes, [itabuna, ibicarai, floresta_azul, ponto_do_lira, ent_santa_cruz_da_vitoria, santa_cruz_da_vitoria, ponto_do_asterio, itaia, ibicui, iguai, nova_canaa, pocoes], [cidade_sol/"135"/"16:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(pocoes, itabuna, [pocoes, santa_cruz_da_vitoria, ponto_do_lira, ponto_do_asterio, nova_canaa, itaia, iguai, ibicui, ibicarai, floresta_azul, ent_santa_cruz_da_vitoria, itabuna], [cidade_sol/"135"/"05:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(feira_de_santana, ipira, [feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira], [cidade_sol/"133"/"16:00"/[ter,qua,qui,sex,sab]]).

linha(ipira, feira_de_santana, [ipira, serra_preta, ent_serra_preta, ent_bravo, ent_anguera, bravo, anguera, feira_de_santana], [cidade_sol/"133"/"05:45"/[ter,qua,qui,sex,sab]]).

linha(salvador, santo_estevao, [salvador, feira_de_santana, santo_estevao], [cidade_sol/"130.car"/"10:00"/[dom]]).

linha(santo_estevao, salvador, [santo_estevao, feira_de_santana, salvador], [cidade_sol/"130.car"/"15:00"/[dom]]).

linha(salvador, santo_estevao, [salvador, feira_de_santana, santo_estevao], [cidade_sol/"130"/"07:30"/[sab]]).

linha(santo_estevao, salvador, [santo_estevao, feira_de_santana, salvador], [cidade_sol/"130"/"15:00"/[sab]]).

linha(salvador, piritiba, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, piritiba], [cidade_sol/"129.exe"/"10:16"/[qui]]).

linha(piritiba, salvador, [piritiba, serra_preta, mundo_novo, ipira, feira_de_santana, ent_serra_preta, ent_mundo_novo, ent_bravo, ent_anguera, baixa_grande, anguera, salvador], [cidade_sol/"129.exe"/"06:40"/[sex]]).

linha(salvador, piritiba, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira,baixa_grande, ent_mundo_novo, mundo_novo, piritiba], [cidade_sol/"129.car"/"10:16"/[dom]]).

linha(piritiba, salvador, [piritiba, serra_preta, mundo_novo, ipira, feira_de_santana, ent_serra_preta, ent_mundo_novo, ent_bravo, ent_anguera, bravo, baixa_grande, anguera,salvador], [cidade_sol/"129.car"/"06:40"/[dom]]).

linha(salvador, piritiba, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira, baixa_grande, ent_mundo_novo, mundo_novo, piritiba], [cidade_sol/"129.exe"/"10:17"/[qui]]).

linha(piritiba, salvador, [piritiba, serra_preta, mundo_novo, ipira, feira_de_santana, ent_serra_preta, ent_mundo_novo, ent_bravo, ent_anguera, bravo, baixa_grande, anguera, salvador], [cidade_sol/"129.exe"/"06:30"/[sex]]).

linha(jequie, dario_meira, [jequie, manoel_vitorino, ent_boa_nova, boa_nova, valentim, dario_meira], [cidade_sol/"120"/"15:00"/[seg,ter,qua,qui,sex,sab]]).

linha(dario_meira, jequie, [dario_meira, valentim, manoel_vitorino, ent_boa_nova, boa_nova, jequie], [cidade_sol/"120"/"05:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, ibitupa, [jequie, jitauna, ipiau, itagiba, acaraci, dario_meira, ibitupa], [cidade_sol/"118"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(ibitupa, jequie, [ibitupa, jitauna, itagiba, ipiau, dario_meira, acaraci, jequie], [cidade_sol/"118"/"05:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, itagi, [jequie, jitauna, itajuru, itagi], [cidade_sol/"117"/"08:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"117"/"12:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"117"/"18:00"/[seg,ter,qua,qui,sex,sab]]).

linha(itagi, jequie, [itagi, jitauna, itajuru, jequie], [cidade_sol/"117"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"117"/"10:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"117"/"14:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, apuarema, [jequie, ent_florestal, florestal, apuarema], [cidade_sol/"114ir.mic"/"07:10"/[seg,ter,qua,qui,sex,sab], cidade_sol/"114ir.mic"/"14:30"/[seg,ter,qua,qui,sex,sab]]).

linha(apuarema, jequie, [apuarema, florestal, ent_florestal, jequie], [cidade_sol/"114ir.mic"/"05:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"114ir.mic"/"08:40"/[seg,ter,qua,qui,sex,sab]]).

linha(gandu, jequie, [gandu, itamari, florestal, ent_florestal, apuarema, jequie], [cidade_sol/"114i"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"114i"/"09:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"114i"/"12:50"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"114i"/"17:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, aiquara, [jequie, jitauna, itajuru, aiquara], [cidade_sol/"113"/"11:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"113"/"17:00"/[seg,ter,qua,qui,sex,sab]]).

linha(aiquara, jequie, [aiquara, jitauna, itajuru, jequie], [cidade_sol/"113"/"06:20"/[seg,ter,qua,qui,sex,sab], cidade_sol/"113"/"15:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, campinho, [jequie, jitauna, ipiau, barra_do_rocha, ubata, orico, ubaitaba, faisqueira, ibiacu, paragem, km_20, marau, saquaira, campinho], [cidade_sol/"112x2"/"11:00"/[seg,ter,qua,qui,sex,sab]]).

linha(campinho, jequie, [campinho, ubata, ubaitaba, saquaira, paragem, orico, marau, km_20, jitauna, ipiau, ibiacu, faisqueira, barra_do_rocha, jequie], [cidade_sol/"112x2"/"05:00"/[seg,ter,qua,qui,sex,sab]]).


linha(jequie, itacare, [jequie, jitauna, ipiau, barra_do_rocha, ubata, orico, ubaitaba, pau_grande, taboquinhas, faz_capitao, itacare], [cidade_sol/"112x"/"14:00"/[seg,ter,qua,qui,sex,sab]]).

linha(itacare, jequie, [itacare, ubata, ubaitaba, taboquinhas, pau_grande, orico, jitauna, ipiau, faz_capitao, barra_do_rocha, jequie], [cidade_sol/"112x"/"05:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, ubata, [jequie, jitauna, ipiau, barra_do_rocha, ubata], [cidade_sol/"112"/"05:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"112"/"08:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"112"/"17:30"/[seg,ter,qua,qui,sex]]).

linha(ubata, jequie, [ubata, jitauna, ipiau, barra_do_rocha, jequie], [cidade_sol/"112"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"112"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"112"/"18:00"/[seg,ter,qua,qui,sex]]).

linha(vitoria_da_conquista, ipiau, [vitoria_da_conquista, planalto, pocoes, ent_boa_nova, boa_nova, valentim, dario_meira, itagiba, ipiau], [cidade_sol/"110"/"06:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(ipiau, vitoria_da_conquista, [ipiau, valentim, pocoes, planalto, itagiba, ent_boa_nova, dario_meira, boa_nova, vitoria_da_conquista], [cidade_sol/"110"/"06:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"110"/"12:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, vitoria_da_conquista, [jequie, manoel_vitorino, pocoes, planalto, vitoria_da_conquista], [cidade_sol/"109.exe"/"06:00"/[seg,ter,qua,qui,sex,sabe,dom], cidade_sol/"109.exe"/"08:00"/[seg,ter,qua,qui,sex,sabe,dom], cidade_sol/"109.exe"/"10:00"/[seg,ter,qua,qui,sex,sabe,dom], cidade_sol/"109.exe"/"11:00"/[seg,ter,qua,qui,sex,sabe,dom]]).

linha(vitoria_da_conquista, jequie, [vitoria_da_conquista, pocoes, planalto, manoel_vitorino, jequie], [cidade_sol/"109.exe"/"10:00"/[seg,ter,qua,qui,sex,sabe,dom], cidade_sol/"109.exe"/"12:00"/[seg,ter,qua,qui,sex,sabe,dom], cidade_sol/"109.exe"/"14:00"/[seg,ter,qua,qui,sex,sabe,dom], cidade_sol/"109.exe"/"16:00"/[seg,ter,qua,qui,sex,sabe,dom]]).

/* COMEÇO NO SITE FIZ EM 2 PCS E JUNTEI NO FINAL , MAS N IMPORTA A ORDEM*/

linha(valenca, ubata, [valenca, taperoa, nilo_pecanha, itubera, igrapiuna, camamu, acarai, orojo, craveiro, travessao, ubaitaba, orico, ubata], [cidade_sol/"003"/"05:00"/[seg,ter,quar,qui,sex,sab]]).

linha(ubata, valenca, [ubata, orico, ubaitaba, travessao, craveiro, orojo, acarai, camamu, igrapiuna, itubera, nilo_pecanha, taperoa, valenca], [cidade_sol/"003"/"16:20"/[seg,ter,quar,qui,sex,sab]]).

linha(bom_despacho, ubata, [bom_despacho, ent_itaparica, ent_cacha_pregos, ent_salinas_da_margarida, nazare, ent_jaguaripe, ent_camassandi, ent_guaibim, valenca, taperoa, nilo_pecanha, ibuera, igrapiuna, camamu, acarai, orojo, craveiro, travessao, ubaitaba, orico, ubata], [cidade_sol/"003"/"06:00"/[seg,ter,quar,qui,sex,sab,dom], cidade_sol/"003x"/"10:00"/[seg,ter,quar,qui,sex,sab,dom]]).

linha(ubata, bom_despacho, [ubata, orico, ubaitaba, travessao, craveiro, orojo, acarai, camamu, igrapiuna, nilo_pecanha, taperoa, valenca, ent_guaibim, ent_camassandi, ent_jaguaripe, ent_salinas_da_margarida, ent_cacha_pregos, ent_itaparica, bom_despacho], [cidade_sol/"003"/"06:00"/[seg,ter,quar,qui,sex,sab,dom], cidade_sol/"003x"/"10:00"/[seg,ter,quar,qui,sex,sab,dom]]).

linha(jequie, itagi, [jequie,entroc_BR330,tamarindo,itajuru,itagi], [cidade_sol/"015"/"15:00"/[seg,ter,quar,qui,sex,sab,dom]]).

linha(itagi, jequie, [itagi,itajuru,tamarindo,entroc_BR330,jequie], [cidade_sol/"015"/"15:00"/[seg,ter,quar,qui,sex,sab,dom]]).

linha(bom_despacho, conceicao_de_salinas, [bom_despacho, ent_cacha_pregos, ent_cacoes, cacoes, ent_muta, ent_encarnacao, encarnacao, conceicao_de_salinas], [cidade_sol/"021"/"19:20"/[seg,ter,quar,qui,sex,sab,dom]]).

linha(conceicao_de_salinas, bom_despacho, [conceicao_de_salinas, encarnacao, ent_encarnacao, ent_muta, cacoes, ent_cacoes, ent_cacha_pregos, bom_despacho], [cidade_sol/"021"/"7:20"/[seg,ter,quar,qui,sex,sab,dom]]).

linha(bom_despacho, jaguaripe, [bom_despacho, ent_cacha_pregos, ent_jiribatuba, jiribatuba, ent_sao_roque, nazare, aratuipe, maragojipinho, ent_jaguaripe, jaguaripe], [cidade_sol/"026"/"11:20"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"026"/"16:20"/[seg,ter,qua,qui,sex,sab]]).

linha(jaguaripe, bom_despacho, [jaguaripe, ent_jaguaripe, maragojipinho, aratuipe, nazare, ent_sao_roque, jiribatuba, ent_jiribatuba, ent_cacha_pregos, bom_despacho], [cidade_sol/"026"/"04:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"026"/"13:30"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, rumo, [salvador, feira_de_santana, km_50, argoim, itaberaba, iacu, joao_amaro, marcionilio, queimadinhas, bandeira_de_melo, itaete, rumo], [cidade_sol/"040a"/"07:30"/[seg,qua,qui,sex,sab,dom],cidade_sol/"040a"/"04:30"/[seg,ter,qua,sex,sab,dom]]).

linha(bom_despacho, engenheiro_pontes, [bom_despacho, ent_jiribatuba, nazare, muniz_ferreira, santo_antonio_de_jesus, ent_sao_miguel_das_matas, engenheiro_pontes], [cidade_sol/"49"/"14:20"/[sab],cidade_sol/"49"/"07:00"/[sab]]).

 linha(itabuna, vitoria_da_conquista, [itabuna, ibicarai, floresta_azul, ponto_do_lira, ent_santa_cruz_da_vitoria, santa_cruz_da_vitoria, ponto_do_asterio, itaia, ibicui, iguai, nova_canaa, pocoes, planalto, vitoria_da_conquista], [cidade_sol/"053"/"03:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053"/"10:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053"/"12:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053"/"07:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053"/"09:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053"/"11:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itabuna, vitoria_da_conquista, [itabuna, ibicarai, floresta_azul, santa_cruz_da_vitoria, itaia, ibicui, iguai, nova_canaa, pocoes, planalto, vitoria_da_conquista], [cidade_sol/"053.exe"/"08:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053.exe"/"14:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053.exe"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"053.exe"/"13:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(vitoria_da_conquista, pocoes, [vitoria_da_conquista, planalto, pocoes], [cidade_sol/"053r2.mic"/"10:30"/[seg], cidade_sol/"053r2.mic"/"06:00"/[seg]]).

linha(salvador, catu, [salvador, entronc_br324_ba093, ent_camacari, end_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, pojuca, catu], [cidade_sol/"058"/"08:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058"/"10:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058"/"12:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058"/"15:20"/[seg,ter,qua,qui,sex], cidade_sol/"058"/"15:00"/[dom], cidade_sol/"058"/"19:30"/[dom], cidade_sol/"058"/"06:50"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058"/"09:50"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058"/"12:20"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058"/"12:40"/[dom], cidade_sol/"058"/"17:00"/[dom]]).

linha(salvador, pojuca, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, pojuca], [cidade_sol/"058e"/"07:30"/[seg,ter,qua,qui,sex], cidade_sol/"058e"/"13:15"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058e"/"17:15"/[seg,ter,qua,qui,sex], cidade_sol/"058e"/"05:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"058e"/"09:00"/[seg,ter,qua,qui,sex], cidade_sol/"058e"/"15:00"/[seg,ter,qua,qui,sex]]).

linha(salvador, catu, [salvador, entronc_br324_ba0937, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu], [cidade_sol/"059"/"15:20"/[sab], cidade_sol/"059"/"06:00"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, alagoinhas, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas], [cidade_sol/"061"/"07:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"08:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"061"/"10:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"11:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"061"/"14:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"16:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"16:30"/[dom], cidade_sol/"061"/"19:10"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"04:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"05:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"061"/"05:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"07:20"/[dom], cidade_sol/"061"/"11:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"13:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"14:20"/[dom], cidade_sol/"061"/"14:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061"/"16:30"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, alagoinhas, [salvador, catu, alagoinhas], [cidade_sol/"061.exe"/"06:50"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061.exe"/"10:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061.exe"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"061.exe"/"14:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061.exe"/"17:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061.exe"/"20:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"061.exe"/"05:40"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061.exe"/"08:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"061.exe"/"12:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061.exe"/"15:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"061;exe"/"16:50"/[dom], cidade_sol/"061.exe"/"18:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, alagoinhas, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas], [cidade_sol/"062"/"20:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"062"/"19:40"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, alagoinhas, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas], [cidade_sol/"063"/"07:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"063"/"04:00"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, aramari, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas, aramari], [cidade_sol/"066"/"05:40"/[seg,ter,qua,qui,sex,sab], cidade_sol/"066"/"09:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"066"/"13:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"066"/"17:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"066"/"17:30"/[dom], cidade_sol/"066"/"05:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"066"/"09:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"066"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"066"/"17:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(salvador, inhabupe, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas, ent_inhabupe, riacho_da_guia, inhabupe], [cidade_sol/"067"/"18:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"067"/"05:30"/[seg,ter,qua,qui,sex,sab]]).

linha(salvador, satiro_dias, [salvador, entronc_br324_ba093, ent_camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas, ent_inhambupe, inhambupe, ent_satiro_dias, satiro_dias], [cidade_sol/"068"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], [cidade_sol/"068"/"05:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"068"/"13:40"/[dom]]]).

linha(salvador, catu, [salvador, entronc_br324_ba093, menino_jesus_cova_de_defunto, ent_sao_sebastiao_do_passe, sao_sebastiao_do_passe, banco_de_areia, rio_una, sao_sebastiao_do_passe,catu], [cidade_sol/"069"/"08:10"/[seg]]).

linha(salvador, pedrao, [salvador, entronc_br324_ba093, ent-camacari, ent_dias_d_avila, ent_mata_de_sao_joao, ent_pojuca, catu, pau_lavrado, ent_sitio_novo, alagoinhas, boa_uniao, pedrao], [cidade_sol/"070"/"10:00"/[dom], cidade_sol/"070"/"12:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"070"/"06:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"070"/"16:00"/[dom]]).

linha(itabuna, lagoa_redonda, [itabuna, ent_itajuipe, ubaitaba, ubata, ipiau, jitauna, provisao, jequie, milagres, feira_de_santana, alagoinhas, olinda, itapicuru, lagoa_redonda], [cidade_sol/"080i"/"23:30"/[dom], cidade_sol/"080i"/"22:00"/[seg]]).

linha(salvador, mairi, [salvador, feira_de_santana, ent_anguera, anguera, ipira, baixa_grande, mairi], [cidade_sol/"082"/"12:00"/[sab],cidade_sol/"082"/"07:00"/[sab]]).

linha(salvador, mairi, [salvador, feira_de_santana, ent_anguera, anguera, ipira, baixa_grande, mairi], [cidade_sol/"082.car"/"12:00"/[dom], cidade_sol/"082.car"/"07:00"/[dom]]).

linha(salvador, serrolandia, [salvador, feira_de_santana, ent_anguera, ipira, baixa_grande, mairi, angico, manguinha, varzea_do_poço, serrolandia], [cidade_sol/"082a"/"12:00"/[sex], cidade_sol/"082a"/"05:30"/[sex]]).

linha(salvador, serrolandia, [salvador, feira_de_santana, ent_anguera, anguera, ipira, baixa_grande, mairi, angico, manguinha, varzea_do_poco, serrolandia], [cidade_sol/"082a.car"/"12:00"/[qui], cidade_sol/"082a.car"/"12:00"/[qui]]).

linha(salvador, serrolandia, [salvador, feira_de_santana, anguera, ipira, baixa_grande, serrolandia], [cidade_sol/"082a.exe"/"12:00"/[seg,ter,qua], cidade_sol/"082a.exe"/"05:30"/[seg,ter,qua]]).

linha(salvador, ipira, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, ent_bravo, bravo, ipira], [cidade_sol/"082e"/"17:40"/[dom], cidade_sol/"082e"/"07:00"/[seg]]).

linha(salvador, ipira, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira], [cidade_sol/"082e.car"/"08:00"/[dom], cidade_sol/"082e.car"/"13:00"/[dom]]).

linha(salvador, ipira, [salvador, feira_de_santana, ent_anguera, anguera, ent_serra_preta, serra_preta, ent_bravo, bravo, ipira], [cidade_sol/"082e.exe"/"08:00"/[seg], cidade_sol/"082e.exe"/"13:00"/[seg]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, ent_anguera, ent_serra_preta, ent_bravo, ipira, santa_quiteria, santa_isabel, itaberaba, ruy_barbosa], [cidade_sol/"087"/"08:00"/[dom], cidade_sol/"087"/"13:30"/[dom]]).

linha(salvador, ruy_barbosa, [salvador, feira_de_santana, ipira, itaberaba, ruy_barbosa], [cidade_sol/"087.exe"/"16:01"/[sex], cidade_sol/"087.exe"/"14:31"/[dom]]).

linha(salvador, itaberaba, [salvador, feira_de_santana, ent_anguera, ent_serra_preta, ent_bravo, ipira, santa_quiteria, santa_isabel, itaberaba], [cidade_sol/"087e"/"08:00"/[sab], cidade_sol/"087e"/"14:00"/[sab]]).

linha(salvador, itaberaba, [salvador, feira_de_santana, ent_anguera, ent_serra_preta, ent_bravo, ipira, santa_quiteria, santa_isabel, itaberaba], [cidade_sol/"087e.car"/"09:00"/[ter], cidade_sol/"087e.car"/"09:00"/[seg]]).

linha(salvador, itaberaba, [salvador, feira_de_santana, ipira, santa_quiteria, itaberaba], [cidade_sol/"087e.exe"/"08:00"/[seg,ter,qua,qui], cidade_sol/"087e.exe"/"17:45"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"087e.exe"/"14:00"/[seg,ter,qua,qui,sex]]).

linha(valenca, camamu, [valenca, taperoa, nilo_pecanha, itubera, igrapiuna, camamu], [cidade_sol/"105"/"09:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"105"/"15:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"105"/"06:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"105"/"11:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"105"/"11:30"/[seg,ter,qua,qui,sex,sab]]).

linha(valenca, gandu, [valenca, ent_valença, moenda_seca, presidente_tancredo_neves, corte_de_pedra, burietá, teolandia, wenceslau_guimaraes, gandu], [cidade_sol/"106"/"05:45"/[seg,ter,qua,qui,sex,sab], cidade_sol/"106"/"12:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"106"/"08:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"106"/"16:20"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, valenca, [jequie, jitauna, ipiau, ibirataia, gandu, ent_wenceslau_guimaraes, teolandia, ent_valenca, valenca], [cidade_sol/"107"/"07:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"107"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(vitoria_da_conquista, valenca, [vitoria_da_conquista, planalto, pocoes, ent_cachoeira, manoel_vitorino, jequie, jitauna, ipiau, ibirataia, gandu, ent_wenceslau_guimaraes, teolandia, ent_valenca, valenca], [cidade_sol/"107x"/"06:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"107x"/"09:10"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, itabuna, [jequie, jitauna, ioiau, barra_do_rocha, ubata, entronc_br101_br330, ubaitaba, posto_santo_antonio, ent_itajuipe, itabuna], [cidade_sol/"108"/"06:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"08:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"16:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"06:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"08:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"10:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"13:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108"/"16:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, itabuna, [jequie, jitauna, ipiau, barra_do_rocha, ubata, ubaitaba, itabuna], [cidade_sol/"108.exe"/"07:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108.exe"/"12:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, ilheus, [jequie, jitauna, ipiau, barra_do_rocha, ubata, entronc_br101_br330, ubaitava, posto_santo_antonio, ent_itajuipe, itabuna, ilheus], [cidade_sol/"108a"/"18:15"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108a"/"18:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, ilheus, [jequie, jitauna, ipiau, barra_do_rocha, ubata, ubaitaba, itabunaa, ilheus], [cidade_sol/"108a.exe"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108a.exe"/"06:00"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(jequie, canavieiras, [jequie, jitauna, ipiau, barra_do_rocha, ubata, entronc_br101_br330, ubaitaba, posto_santo_antonio, ent_itajuipe, itabuna, olivenca, acuipe, rio_da_serra, una, ent_comandatuba, comandatuba, puxim_do_sul, entroncba001_ba570, canavieiras], [cidade_sol/"108x"/"04:30"/[seg,ter,qua,qui,sex,sab], cidade_sol/"108x"/"13:30"/[seg,ter,qua,qui,sex,sab]]).

linha(jequie, canavieiras, [jequie, jitauna, ipiau, barra_do_rocha, ubata, ubaitaba, ilivenca, acuipe, una, comandatuba, canavieiras], [cidade_sol/"108x.exe"/"14:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"108x.exe"/"06:00"/[seg,ter,qua,qui,sex,sab], cidade_sol/"108x.exe"/"13:30"/[dom]]).

linha(jequie, vitoria_da_conquista, [jequie, manoel_vitorino, ent_cachoeira, pocoes, planalto, posto_turbo, vitoria_da_conquista], [cidade_sol/"109"/"05:00"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"109"/"17:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"109"/"07:30"/[seg,ter,qua,qui,sex,sab,dom], cidade_sol/"109"/"18:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itamaraju, nova_vicosa, [itamaraju,teixeira_de_freitas, rancho_alegre, bela_vista, posto_da_mata,nova_vicosa], [aguia_branca/"002"/"11:30"/[sab]]).
linha(nova_vicosa, itamaraju, [nova_vicosa,posto_da_mata, bela_vista, rancho_alegre, teixeira_de_freitas,itamaraju], [aguia_branca/"002"/"05:30"/[dom]]).

linha(itabuna, feira_de_santana, [itabuna, ubaitaba, gandu, teolandia, santo_antonio_de_jesus, cruz_das_almas, conceicao_da_feira, tapera, feira_de_santana], [aguia_branca/"005"/"22:35"/[sex]]).
linha(feira_de_santana, itabuna, [feira_de_santana, tapera, conceicao_da_feira, cruz_das_almas, santo_antonio_de_jesus, teolandia, gandu, ubaitaba, itabuna], [aguia_branca/"005"/"23:10"/[sab]]).

linha(itamaraju, nova_vicosa, [itamaraju, teixeira_de_freitas, caravelas, nova_vicosa], [aguia_branca/"002"/"11:30"/[sab]]).
linha(nova_vicosa, itamaraju, [nova_vicosa, caravelas, teixeira_de_freitas, itamaraju], [aguia_branca/"002"/"05:30"/[dom]]).
linha(itabuna, feira_de_santana, [itabuna, ubaitaba, gandu, teolandia, valenca, santo_antonio_de_jesus, cruz_das_almas, conceicao_da_feira, sao_goncalo_dos_campos, feira_de_santana], [aguia_branca/"005"/"22:35"/[sex]]).
linha(feira_de_santana, itabuna, [feira_de_santana, sao_goncalo_dos_campos, conceicao_da_feira, cruz_das_almas, santo_antonio_de_jesus, valenca, teolandia, gandu, ubaitaba, itabuna], [aguia_branca/"005"/"23:10"/[sab]]).
linha(salvador, itanhem, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, camaca, eunapolis, itabela, itamaraju, teixeira_de_freitas, medeiros_neto, itanhem], [aguia_branca/"012"/"05:30"/[sab]]).
linha(itanhem, salvador, [itanhem, medeiros_neto, teixeira_de_freitas, itamaraju, itabela, eunapolis, camaca, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"012"/"13:20"/[dom]]).
linha(salvador, itanhem, [salvador, gandu, itabuna, camaca, eunapolis, itabela, itamaraju, teixeira_de_freitas, medeiros_neto, itanhem], [aguia_branca/"012.DCO"/"19:15"/[todoDia]]).
linha(itanhem, salvador, [itanhem, medeiros_neto, teixeira_de_freitas, itamaraju, itabela, eunapolis, camaca, itabuna, gandu, salvador], [aguia_branca/"012.DCO"/"14:00"/[todoDia]]).
linha(salvador, itanhem, [salvador, gandu, itabuna, camaca, eunapolis, itabela, itamaraju, teixeira_de_freitas, medeiros_neto, itanhem], [aguia_branca/"012.ESL"/"19:15"/[sex]]).
linha(itanhem, salvador, [itanhem, medeiros_neto, teixeira_de_freitas, itamaraju, itabela, eunapolis, camaca, itabuna, gandu, salvador], [aguia_branca/"012.ESL"/"14:20"/[dom]]).
linha(medeiros_neto, itanhem, [medeiros_neto, itanhem], [aguia_branca/"012.R"/"07:30"/[sex,sab,dom]]).
linha(itanhem, medeiros_neto, [itanhem, medeiros_neto], [aguia_branca/"012.R"/"20:30"/[sex,dom]]).
linha(feira_de_santana, mairi, [feira_de_santana, tanquinho, riachao_do_jacuipe, nova_fatima, gaviao, capim_grosso, mairi], [aguia_branca/"083"/"14:30"/[sex]]).
linha(mairi, feira_de_santana, [mairi, capim_grosso, gaviao, nova_fatima, riachao_do_jacuipe, tanquinho, feira_de_santana], [aguia_branca/"083"/"05:00"/[sab]]).
/* Linha 103 não tem */
linha(salvador, nova_vicosa, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, itabuna, camaca, mascote, itagimirim, eunapolis, itabela, itamaraju, teixeira_de_freitas, mucuri, nova_vicosa], [aguia_branca/"103A"/"05:30"/[ter]]).
linha(nova_vicosa, salvador, [nova_vicosa, mucuri, teixeira_de_freitas, itamaraju, itabela, eunapolis, itagimirim, mascote, camaca, itabuna, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"103A"/"12:30"/[qua]]).
linha(salvador, ubaitaba, [salvador, cruz_das_almas, santo_antonio_de_jesus, laje, wenceslau_guimaraes, gandu, ubaitaba], [aguia_branca/"115"/"09:40"/[qua]]).
linha(ubaitaba, salvador, [ubaitaba, gandu, wenceslau_guimaraes, laje, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"115"/"07:30"/[qui]]).
linha(salvador, ipiau, [salvador, cruz_das_almas, santo_antonio_de_jesus, laje, wenceslau_guimaraes, gandu, ubaitaba, ubata, barra_do_rocha, ipiau], [aguia_branca/"115A"/"22:13"/[seg,ter,qua,qui,sex,dom]]).
linha(ipiau, salvador, [ipiau, barra_do_rocha, ubata, ubaitaba, gandu, wenceslau_guimaraes, laje, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"115A"/"22:00"/[seg,ter,qua,qui,sex,dom]]).
linha(salvador, ipiau, [salvador, cruz_das_almas, santo_antonio_de_jesus, laje, wenceslau_guimaraes, gandu, ubaitaba, ubata, barra_do_rocha, ipiau], [aguia_branca/"115A.CAR"/"22:46"/[sex]]).
linha(ipiau, salvador, [ipiau, barra_do_rocha, ubata, ubaitaba, gandu, wenceslau_guimaraes, laje, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"115A.CAR"/"22:50"/[dom]]).
linha(salvador, ibirapitanga, [salvador, conceicao_da_feira, cachoeira, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, gandu, ibirapitanga], [aguia_branca/"123"/"09:40"/[seg,qui,sex,sab]]).
linha(ibirapitanga, salvador, [ibirapitanga, gandu, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, cachoeira, conceicao_da_feira, salvador], [aguia_branca/"123"/"08:00"/[qua,sex,sab,dom]]).
linha(itabuna, ibirapitanga, [itabuna, itajuipe, aurelino_leal, ubaitaba, ibirapitanga], [aguia_branca/"126"/"06:30"/[qua,sex,sab,dom]]).
linha(ibirapitanga, itabuna, [ibirapitanga, ubaitaba, aurelino_leal, itajuipe, itabuna], [aguia_branca/"126"/"16:35"/[seg,qui,sex,sab]]).
linha(salvador, floresta_azul, [salvador, feira_de_santana, jequie, ubaitaba, itabuna, ibicarai, floresta_azul], [aguia_branca/"189"/"08:30"/[sab]]).
linha(floresta_azul, salvador, [floresta_azul, ibicarai, itabuna, ubaitaba, jequie, feira_de_santana, salvador], [aguia_branca/"189"/"08:50"/[sex]]).
linha(salvador, itabuna, [salvador, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, gandu, ibirapitanga, itabuna], [aguia_branca/"192"/"13:40"/[ter]]).
linha(itabuna, salvador, [itabuna, ibirapitanga, gandu, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, salvador], [aguia_branca/"192"/"11:45"/[ter]]).
linha(salvador, itabuna, [salvador, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, gandu, ibirapitanga, ubaitaba, itabuna], [aguia_branca/"192.CAR"/"13:40"/[seg,qui,dom]]).
linha(itabuna, salvador, [itabuna, ubaitaba, ibirapitanga, gandu, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, salvador], [aguia_branca/"192.CAR"/"11:45"/[seg,qui,sex]]).
linha(salvador, itabuna, [salvador, santo_antonio_de_jesus, gandu, ubaitaba, itabuna], [aguia_branca/"192.DCO"/"22:12"/[todoDia]]).
linha(itabuna, salvador, [itabuna, ubaitaba, gandu, santo_antonio_de_jesus, salvador], [aguia_branca/"192.DCO"/"22:14"/[todoDia]]).
linha(salvador, itabuna, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna], [aguia_branca/"192.ESL"/"22:46"/[sex]]).
linha(itabuna, salvador, [itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"192.ESL"/"22:54"/[dom]]).
linha(salvador, itabuna, [salvador, gandu, ubaitaba, itabuna], [aguia_branca/"192.EXE"/"22:47"/[sex]]).
linha(salvador, ilheus, [salvador, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, wenceslau_guimaraes, gandu, ibirapitanga, ubaitaba, itabuna, ilheus], [aguia_branca/"192A"/"09:40"/[qua]]).
linha(ilheus, salvador, [ilheus, itabuna, ubaitaba, ibirapitanga, gandu, wenceslau_guimaraes, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, salvador], [aguia_branca/"192A"/"10:50"/[qua]]).
linha(salvador, ilheus, [salvador, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, ilheus], [aguia_branca/"192A.DCO"/"09:00"/[tododia], aguia_branca/"192A.DCO"/"22:14"/[todoDia]]).
linha(ilheus, salvador, [ilheus, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, salvador], [aguia_branca/"192A.DCO"/"08:30"/[tododia], aguia_branca/"192A.DCO"/"21:20"/[todoDia]]).
linha(salvador, ilheus, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, ilheus], [aguia_branca/"192A.ESL"/"12:45"/[todoDia]]).
linha(ilheus, salvador, [ilheus, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"192A.ESL"/"12:45"/[todoDia]]).
linha(salvador, itacare, [salvador, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, wenceslau_guimaraes, gandu, ibirapitanga, ubaitaba, itabuna, ilheus, urucuca, itacare], [aguia_branca/"192A2"/"09:40"/[dom]]).
linha(itacare, salvador, [itacare, urucuca, ilheus, itabuna, ubaitaba, ibirapitanga, gandu, wenceslau_guimaraes, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, salvador], [aguia_branca/"192A2"/"04:40"/[seg]]).
linha(salvador, itacare, [salvador, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, wenceslau_guimaraes, gandu, ibirapitanga, ubaitaba, itabuna, ilheus, urucuca, itacare], [aguia_branca/"192A2.EXE"/"22:45"/[sex]]).
linha(itacare, salvador, [itacare, urucuca, ilheus, itabuna, ubaitaba, ibirapitanga, gandu, wenceslau_guimaraes, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, salvador], [aguia_branca/"192A2.EXE"/"20:40"/[dom]]).
linha(feira_de_santana, itabuna, [feira_de_santana, sao_goncalo_dos_campos, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, presidente_tancredo_neves, teolandia, gandu, ibirapitanga, ubaitaba, itabuna], [aguia_branca/"216"/"23:10"/[ter,qua,qui,sex,dom]]).
linha(itabuna, feira_de_santana, [itabuna, ubaitaba, ibirapitanga, gandu, teolandia, presidente_tancredo_neves, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, sao_goncalo_dos_campos, feira_de_santana], [aguia_branca/"216"/"22:35"/[seg,ter,qua,qui,sab]]).
linha(feira_de_santana, itabuna, [feira_de_santana, san_goncalo_dos_campos, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, presidente_tancredo_neves, teolandia, gandu, ibirapitanga, ubaitaba, itabuna], [aguia_branca/"216.CAR"/"23:01"/[dom]]).
linha(itabuna, feira_de_santana, [itabuna, ubaitaba, ibirapitanga, gandu, teolandia, presidente_tancredo_neves, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, san_goncalo_dos_campos, feira_de_santana], [aguia_branca/"216.CAR"/"22:52"/[seg]]).
linha(feira_de_santana, ilheus, [feira_de_santana, sao_goncalo_dos_campos, cruz_das_almas, conceicao_do_almeida, santo_antonio_de_jesus, laje, presidente_tancredo_neves, teolandia, gandu, ibirapitanga, ubaitaba, itabuna, ilheus], [aguia_branca/"216A"/"09:00"/[seg,ter,qui,sex,sab,dom]]).
linha(ilheus, feira_de_santana, [ilheus, itabuna, ubaitaba, ibirapitanga, gandu, teolandia, presidente_tancredo_neves, laje, santo_antonio_de_jesus, conceicao_do_almeida, cruz_das_almas, sao_goncalo_dos_campos, feira_de_santana], [aguia_branca/"216A"/"07:00"/[seg,qua,qui,sex,sab,dom]]).
linha(salvador, camaca, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, camaca], [aguia_branca/"241"/"13:40"/[sex]]).
linha(camaca, salvador, [camaca, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"241"/"10:20"/[dom]]).
linha(salvador, coaraci, [salvador, conceicao_da_feira, cachoeira, cruz_das_almas, santo_antonio_de_jesus, laje, gandu, ubaitaba, itajuipe, coaraci], [aguia_branca/"242"/"22:11"/[sex]]).
linha(coaraci, salvador, [coaraci, itajuipe, ubaitaba, gandu, laje, santo_antonio_de_jesus, cruz_das_almas, cachoeira, conceicao_da_feira, salvador], [aguia_branca/"242"/"22:05"/[dom]]).
linha(itabuna, bom_despacho, [itabuna, ubaitaba, gandu, laje, santo_antonio_de_jesus, nazare, bom_despacho], [aguia_branca/"274"/"10:00"/[qui]]).
linha(bom_despacho, itabuna, [bom_despacho, nazare, santo_antonio_de_jesus, laje, gandu, ubaitaba, itabuna], [aguia_branca/"274"/"06:30"/[sex]]).
linha(salvador, itamaraju, [salvador, santo_antonio_de_jesus, gandu, itabuna, buerarema, arataca, itagimirim, eunapolis, itabela, itamaraju], [aguia_branca/"333"/"19:16"/[sab]]).
linha(itamaraju, salvador, [itamaraju, itabela, eunapolis, itagimirim, arataca, buerarema, itabuna, gandu, santo_antonio_de_jesus, salvador], [aguia_branca/"333"/"16:30"/[dom]]).
linha(valenca, ilheus, [valenca, presidente_tancredo_neves, teolandia, wenceslau_guimaraes, gandu, ubaitaba, itabuna, ilheus], [aguia_branca/"355"/"07:20"/[ter]]).
linha(ilheus, valenca, [ilheus, itabuna, ubaitaba, gandu, wenceslau_guimaraes, teolandia, presidente_tancredo_neves, valenca], [aguia_branca/"355"/"09:00"/[seg]]).
linha(salvador, caravelas, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, itabuna, camaca, mascote, itagimirim, eunapolis, itabela, itamaraju, prado, alcobaca, caravelas], [aguia_branca/"358"/"05:30"/[qua]]).
linha(caravelas, salvador, [caravelas, alcobaca, prado, itamaraju, itabela, eunapolis, itagimirim, mascote, camaca, itabuna, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"358"/"14:00"/[qui]]).
linha(itabuna, irecê, [itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, feira_de_santana, ipira, baixa_grande, mundo_novo, apiramuta, morro_do_chapeu, america_dourada, joao_dourado, irecê], [aguia_branca/"370"/"22:35"/[dom]]).
linha(irecê, itabuna, [irecê, joao_dourado, america_dourada, morro_do_chapeu, apiramuta, mundo_novo, baixa_grande, ipira, feira_de_santana, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna], [aguia_branca/"370"/"16:00"/[seg]]).
linha(itabuna, medeiros_neto, [itabuna, buerarema, sao_jose_da_vitoria, arataca, camaca, mascote, itagimirim, eunapolis, itabela, itamaraju, teixeira_de_freitas, medeiros_neto], [aguia_branca/"417"/"12:30"/[sex]]).
linha(medeiros_neto, itabuna, [medeiros_neto, teixeira_de_freitas, itamaraju, itabela, eunapolis, itagimirim, mascote, camaca, arataca, sao_jose_da_vitoria, buerarema, itabuna], [aguia_branca/"417"/"08:00"/[sab]]).
linha(salvador, teixeira_de_freitas, [salvador, cruz_das_almas, presidente_tancredo_neves, gandu, itabuna, camaca, eunapolis, itabela, itamaraju, teixeira_de_freitas], [aguia_branca/"421"/"05:30"/[dom]]).
linha(teixeira_de_freitas, salvador, [teixeira_de_freitas, itamaraju, itabela, eunapolis, camaca, itabuna, gandu, presidente_tancredo_neves, cruz_das_almas, salvador], [aguia_branca/"421"/"15:00"/[sab]]).
linha(salvador, teixeira_de_freitas, [salvador, cruz_das_almas, presidente_tancredo_neves, gandu, itabuna, camaca, eunapolis, itabela, itamaraju, teixeira_de_freitas], [aguia_branca/"421.CAR"/"05:30"/[seg,qui,sex]]).
linha(teixeira_de_freitas, salvador, [teixeira_de_freitas, itamaraju, itabela, eunapolis, camaca, itabuna, gandu, presidente_tancredo_neves, cruz_das_almas, salvador], [aguia_branca/"421.CAR"/"15:00"/[seg,ter,sex]]).
linha(salvador, teixeira_de_freitas, [salvador, itabuna, eunapolis, itamaraju, teixeira_de_freitas], [aguia_branca/"421.DCO"/"19:15"/[seg,ter,qua,qui,sex,dom]]).
linha(teixeira_de_freitas, salvador, [teixeira_de_freitas, itamaraju, eunapolis, itabuna, salvador], [aguia_branca/"421.DCO"/"16:00"/[seg,ter,qua,qui,sex,dom]]).
linha(salvador, teixeira_de_freitas, [salvador, itabuna, eunapolis, itamaraju, teixeira_de_freitas], [aguia_branca/"421.ESL"/"19:16"/[sex]]).
linha(teixeira_de_freitas, salvador, [teixeira_de_freitas, itamaraju, eunapolis, itabuna, salvador], [aguia_branca/"421.ESL"/"16:05"/[dom]]).
linha(itabuna, porto_seguro, [itabuna, buerarema, sao_jose_da_vitoria, arataca, camaca, mascote, belmonte, itapebi, itagimirim, eunapolis, porto_seguro], [aguia_branca/"457"/"23:00"/[sex]]).
/* 457 não possui horário nem dias de volta */
linha(feira_de_santana, gandu, [feira_de_santana, sao_goncalo_dos_campos, conceicao_da_feira, governador_mangabeira, cruz_das_almas, sapeacu, santo_antonio_de_jesus, laje, valenca, presidente_tancredo_neves, teolandia, wenceslau_guimaraes, gandu], [aguia_branca/"488"/"09:00"/[qua]]).
linha(gandu, feira_de_santana, [gandu, wenceslau_guimaraes, teolandia, presidente_tancredo_neves, valenca, laje, santo_antonio_de_jesus, sapeacu, cruz_das_almas, governador_mangabeira, conceicao_da_feira, sao_goncalo_dos_campos, feira_de_santana], [aguia_branca/"488"/"10:20"/[ter]]).
linha(salvador, valenca, [salvador, sao_goncalo_dos_campos, conceicao_da_feira, pov_cachoeira, cruz_das_almas, sapeacu, conceicao_do_almeida, santo_antonio_de_jesus, valenca], [aguia_branca/"511"/"15:00"/[sex]]).
linha(valenca, salvador, [valenca, santo_antonio_de_jesus, conceicao_do_almeida, sapeacu, cruz_das_almas, pov_cachoeira, conceicao_da_feira, sao_goncalo_dos_campos, salvador], [aguia_branca/"511"/"07:00"/[sab]]).
linha(itabuna, valenca, [itabuna, itajuipe, urucuca, ubaitaba, ibirapitanga, camamu, igrapiúna, itubera, nilo_pecanha, taperoa, valenca], [aguia_branca/"526"/"06:20"/[sex]]).
linha(valenca, itabuna, [valenca, taperoa, nilo_pecanha, itubera, igrapiúna, camamu, ibirapitanga, ubaitaba, urucuca, itajuipe, itabuna], [aguia_branca/"526"/"12:00"/[sex]]).
/* 536 não possui horário nem dias*/
/* 536A não possui horário nem dias*/
linha(ilheus, jaguaquara, [ilheus, itabuna, ubaitaba, gandu, teolandia, laje, mutuipe, jiquirica, ubaira, santa_inês, itaquara, jaguaquara], [aguia_branca/"536A2"/"10:00"/[dom]]).
linha(jaguaquara, ilheus, [jaguaquara, itaquara, santa_inês, ubaira, jiquirica, mutuipe, laje, teolandia, gandu, ubaitaba, itabuna, ilheus], [aguia_branca/"536A2"/"05:00"/[seg]]).
linha(salvador, itubera, [salvador, sao_goncalo_dos_campos, conceicao_da_feira, cruz_das_almas, sapeacu, conceicao_do_almeida, santo_antonio_de_jesus, valenca, taperoa, nilo_pecanha, itubera], [aguia_branca/"544"/"06:00"/[qui]]).
linha(itubera, salvador, [itubera, nilo_pecanha, taperoa, valenca, santo_antonio_de_jesus, conceicao_do_almeida, sapeacu, cruz_das_almas, conceicao_da_feira, sao_goncalo_dos_campos, salvador], [aguia_branca/"544"/"07:00"/[sex]]).
linha(salvador, camamu, [salvador, sao_goncalo_dos_campos, conceicao_da_feira, cruz_das_almas, sapeacu, conceicao_do_almeida, santo_antonio_de_jesus, valenca, taperoa, nilo_pecanha, itubera, igrapiúna, camamu], [aguia_branca/"544A"/"06:00"/[sab]]).
linha(camamu, salvador, [camamu, igrapiúna, itubera, nilo_pecanha, taperoa, valenca, santo_antonio_de_jesus, conceicao_do_almeida, sapeacu, cruz_das_almas, conceicao_da_feira, sao_goncalo_dos_campos, salvador], [aguia_branca/"544A"/"14:20"/[dom]]).
linha(salvador, canavieiras, [salvador, santo_antonio_de_jesus, wenceslau_guimaraes, gandu, ubaitaba, urucuca, ilheus, una, canavieiras], [aguia_branca/"551"/"22:15"/[ter]]).
linha(canavieiras, salvador, [canavieiras, una, ilheus, urucuca, ubaitaba, gandu, wenceslau_guimaraes, santo_antonio_de_jesus, salvador], [aguia_branca/"551"/"19:10"/[qua]]).
linha(salvador, canavieiras, [salvador, santo_antonio_de_jesus, gandu, ubaitaba, urucuca, ilheus, una, canavieiras], [aguia_branca/"551.ESL"/"22:15"/[seg,qua,qui,sex,sab,dom]]).
linha(canavieiras, salvador, [canavieiras, una, ilheus, urucuca, ubaitaba, gandu, santo_antonio_de_jesus, salvador], [aguia_branca/"551.ESL"/"19:10"/[seg,ter,qui,sex,sab,dom]]).
linha(salvador, porto_seguro, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, buerarema, arataca, itagimirim, eunapolis, porto_seguro], [aguia_branca/"557"/"20:00"/[sab]]).
linha(porto_seguro, salvador, [porto_seguro, eunapolis, itagimirim, arataca, buerarema, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"557"/"18:25"/[sab]]).
linha(salvador, porto_seguro, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, itagimirim, eunapolis, porto_seguro], [aguia_branca/"557.DCO"/"22:16"/[sex]]).
linha(porto_seguro, salvador, [porto_seguro, eunapolis, itagimirim, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"557.DCO"/"18:26"/[dom]]).
linha(salvador, porto_seguro, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, buerarema, arataca, itagimirim, eunapolis, porto_seguro], [aguia_branca/"557.ESL"/"20:00"/[seg,ter,qua,qui,sex]]).
linha(porto_seguro, salvador, [porto_seguro, eunapolis, itagimirim, arataca, buerarema, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"557.ESL"/"18:25"/[seg,ter,qua,qui,dom]]).
linha(salvador, porto_seguro, [salvador, itabuna, porto_seguro], [aguia_branca/"557.EXE"/"20:00"/[dom]]).
linha(porto_seguro, salvador, [porto_seguro, itabuna, salvador], [aguia_branca/"557.EXE"/"18:25"/[sex]]).
/* 557.LEI não possui horário nem dias*/
linha(gandu, ilheus, [gandu, ibirataia, ubaitaba, urucuca, itajuipe, itabuna, ilheus], [aguia_branca/"566"/"13:30"/[qua], aguia_branca/"566"/"07:40"/[sab]]).
linha(ilheus, gandu, [ilheus, itabuna, itajuipe, urucuca, ubaitaba, ibirataia, gandu], [aguia_branca/"566"/"07:00"/[ter], aguia_branca/"566"/"16:05"/[sex]]).
linha(salvador, itapetinga, [salvador, cruz_das_almas, santo_antonio_de_jesus, wenceslau_guimaraes, gandu, ubaitaba, itabuna, ibicarai, floresta_azul, santa_cruz_da_vitoria, itororo, itapetinga], [aguia_branca/"595"/"20:00"/[ter]]).
linha(itapetinga, salvador, [itapetinga, itororo, santa_cruz_da_vitoria, floresta_azul, ibicarai, itabuna, ubaitaba, gandu, wenceslau_guimaraes, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"595"/"19:20"/[qua]]).
linha(salvador, itapetinga, [salvador, cruz_das_almas, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, ibicarai, floresta_azul, santa_cruz_da_vitoria, itororo, itapetinga], [aguia_branca/"595.DCO"/"20:00"/[seg,qua,qui,sex,sab,dom]]).
linha(itapetinga, salvador, [itapetinga, itororo, santa_cruz_da_vitoria, floresta_azul, ibicarai, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, cruz_das_almas, salvador], [aguia_branca/"595.DCO"/"19:20"/[seg,ter,qui,sex,sab,dom]]).
linha(salvador, itapetinga, [salvador, itabuna, ibicarai, floresta_azul, itororo, itapetinga], [aguia_branca/"595.ESL"/"20:02"/[sex]]).
linha(itapetinga, salvador, [itapetinga, itororo, floresta_azul, ibicarai, itabuna, salvador], [aguia_branca/"595.ESL"/"20:00"/[dom]]).
linha(salvador, eunapolis, [salvador, santo_antonio_de_jesus, gandu, ubaitaba, itabuna, camaca, mascote, itagimirim, eunapolis], [aguia_branca/"612"/"20:50"/[sex]]).
linha(eunapolis, salvador, [eunapolis, itagimirim, mascote, camaca, itabuna, ubaitaba, gandu, santo_antonio_de_jesus, salvador], [aguia_branca/"612"/"19:10"/[dom]]).
linha(bom_despacho, itabuna, [bom_despacho, nazare, aratuipe, jaguaripe, valenca, taperoa, nilo_pecanha, itubera, igrapiúna, camamu, itacare, urucuca, ilheus, itabuna], [aguia_branca/"645I"/"08:30"/[todoDia], aguia_branca/"645I"/"13:30"/[todoDia]]).
linha(itabuna, bom_despacho, [itabuna, ilheus, urucuca, itacare, camamu, igrapiúna, itubera, nilo_pecanha, taperoa, valenca, jaguaripe, aratuipe, nazare, bom_despacho], [aguia_branca/"645I"/"07:00"/[todoDia], aguia_branca/"645I"/"14:00"/[todoDia]]).
linha(bom_despacho, itabuna, [bom_despacho, nazare, aratuipe, jaguaripe, valenca, taperoa, nilo_pecanha, itubera, igrapiúna, camamu, itacare, urucuca, ilheus, itabuna], [aguia_branca/"645I.CAR"/"09:00"/[seg]]).
linha(itabuna, bom_despacho, [itabuna, ilheus, urucuca, itacare, camamu, igrapiúna, itubera, nilo_pecanha, taperoa, valenca, jaguaripe, aratuipe, nazare, bom_despacho], [aguia_branca/"645I.CAR"/"06:50"/[dom]]).
linha(bom_despacho, itabuna, [bom_despacho, nazare, aratuipe, jaguaripe, valenca, taperoa, nilo_pecanha, itubera, igrapiúna, camamu, itacare, urucuca, ilheus, itabuna], [aguia_branca/"645I.EXE"/"09:00"/[seg]]).
linha(itabuna, bom_despacho, [itabuna, ilheus, urucuca, itacare, camamu, igrapiúna, itubera, nilo_pecanha, taperoa, valenca, jaguaripe, aratuipe, nazare, bom_despacho], [aguia_branca/"645I.EXE"/"06:50"/[dom]]).
linha(bom_despacho, porto_seguro, [bom_despacho, nazare, jaguaripe, valenca, taperoa, nilo_pecanha, itubera, camamu, ibirapitanga, ubaitaba, itabuna, buerarema, camaca, mascote, itagimirim, eunapolis, porto_seguro], [aguia_branca/"647"/"20:00"/[ter,sab]]).
linha(porto_seguro, bom_despacho, [porto_seguro, eunapolis, itagimirim, mascote, camaca, buerarema, itabuna, ubaitaba, ibirapitanga, camamu, itubera, nilo_pecanha, taperoa, valenca, jaguaripe, nazare, bom_despacho], [aguia_branca/"647"/"18:20"/[ter,sab]]).
linha(bom_despacho, porto_seguro, [bom_despacho, nazare, jaguaripe, valenca, taperoa, nilo_pecanha, itubera, camamu, ibirapitanga, ubaitaba, itabuna, buerarema, camaca, mascote, itagimirim, eunapolis, porto_seguro], [aguia_branca/"647.CAR"/"20:00"/[seg,qua,qui,sex,dom]]).
linha(porto_seguro, bom_despacho, [porto_seguro, eunapolis, itagimirim, mascote, camaca, buerarema, itabuna, ubaitaba, ibirapitanga, camamu, itubera, nilo_pecanha, taperoa, valenca, jaguaripe, nazare, bom_despacho], [aguia_branca/"647.CAR"/"18:20"/[seg,qua,qui,sex,dom]]).
linha(bom_despacho, porto_seguro, [bom_despacho, nazare, jaguaripe, valenca, taperoa, nilo_pecanha, itubera, camamu, ibirapitanga, ubaitaba, itabuna, buerarema, camaca, mascote, itagimirim, eunapolis, porto_seguro], [aguia_branca/"647.EXE"/"19:50"/[sex]]).
linha(porto_seguro, bom_despacho, [porto_seguro, eunapolis, itagimirim, mascote, camaca, buerarema, itabuna, ubaitaba, ibirapitanga, camamu, itubera, nilo_pecanha, taperoa, valenca, jaguaripe, nazare, bom_despacho], [aguia_branca/"647.EXE"/"19:12"/[dom]]).

linha(itajuipe, itabuna, [itajuipe, itabuna], [rota/"127.urb"/"5:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"127.urb"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"127.urb"/"20:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, ubata, [itabuna, itajuipe, coaraci, itapitanga, gongogi, ubata], [rota/"128"/"14:00"/[seg,ter,qua,qui,sex,sab]]).
linha(ubata, itabuna, [ubata, gongogi, itapitanga, coaraci, itajuipe, itabuna], [rota/"128"/"7:10"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, arataca, [itabuna, buerarema, sao_jose_da_vitoria, rio_branco, arataca], [rota/"134E"/"8:30"/[seg,ter,qua,qui,sex,sab], rota/"134E"/"17:00"/[seg,ter,qua,qui,sex,sab]]).
linha(arataca, itabuna, [arataca, rio_branco, sao_jose_da_vitoria, buerarema, itabuna], [rota/"134E"/"6:00"/[seg,ter,qua,qui,sex,sab], rota/"134E"/"12:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, buerarema, [itabuna, buerarema], [rota/"136.URB"/"4:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"136.URB"/"12:30"/[seg,ter,qua,qui,sex,sab], rota/"136.URB"/"20:20"/[dom]]).
linha(buerarema, itabuna, [buerarema, itabuna], [rota/"136.URB"/"5:20"/[seg,ter,qua,qui,sex,sab], rota/"136.URB"/"12:50"/[seg,ter,qua,qui,sex,sab], rota/"136.URB"/"15:40"/[dom]]).
linha(itabuna, sao_jose_da_vitoria, [itabuna, buerarema, sao_jose_da_vitoria], [rota/"137"/"10:30"/[seg]]).
linha(sao_jose_da_vitoria, itabuna, [sao_jose_da_vitoria, buerarema, itabuna], [rota/"137"/"11:30"/[seg]]).
linha(itabuna, barro_preto, [itabuna, ent_barro_preto, barro_preto], [rota/"139"/"15:00"/[sab]]).
linha(barro_preto, itabuna, [barro_preto, ent_barro_preto, itabuna], [rota/"139"/"5:00"/[sab]]).
linha(ilheus, vitoria_da_conquista, [ilheus, itabuna, ent_itape, ibicarai, floresta_azul, ent_santa_cruz_da_vitoria, ponto_do_asterio, firmino_alves, rio_do_meio, itororo, itapetinga, itambe, marcal, vitoria_da_conquista], [rota/"172"/"12:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(vitoria_da_conquista, ilheus, [vitoria_da_conquista, marcal, itambe, itapetinga, itororo, rio_do_meio, firmino_alves, ponto_do_asterio, ent_santa_cruz_da_vitoria, floresta_azul, ibicarai, ent_itape, itabuna, ilheus], [rota/"172"/"5:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itacare, vitoria_da_conquista, [itacare, ilheus, itabuna, ent_itape, ibicarai, floresta_azul, ent_santa_cruz_da_vitoria, ponto_do_asterio, firminho_alves, rio_do_meio, itororo, itapetinga, itambe, marcal, vitoria_da_conquista], [rota/"172A"/"16:00"/[seg,ter,qua]]).
linha(vitoria_da_conquista, itacare, [vitoria_da_conquista, marcal, itambe, itapetinga, itororo, rio_do_meio, firmino_alves, ponto_do_asterio, santa_cruz_da_vitoria, ent_santa_cruz_da_vitoria, floresta_azul, ibicarai, ent_itape, itabuna, ilheus, itacare], [rota/"172A"/"6:00"/[seg,ter,qua]]).
linha(itacare, vitoria_da_conquista, [itacare, itabuna, ibicarai, itororo, itapetinga, itambe, vitoria_da_conquista], [rota/"172A.EXE"/"16:00"/[qui,sex,sab,dom]]).
linha(vitoria_da_conquista, itacare, [vitoria_da_conquista, itambe, itapetinga, itororo, ibicarai, itabuna, itacare], [rota/"172A.EXE"/"6:00"/[qui,sex,sab,dom]]).
linha(ilheus, urucuca, [ilheus, ent_castelo_novo, urucuca], [rota/"173"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"173"/"16:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(urucuca, ilheus, [urucuca, ent_castelo_novo, ilheus], [rota/"173"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"173"/"17:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, itapetinga, [itabuna, ent_itape, ibicarai, floresta_azul, ent_santa_cruz_da_vitoria, santa_cruz_da_vitoria, ponto_do_asterio, firmino_alves, rio_do_meio, itororo, itapetinga], [rota/"174"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"174"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itapetinga, itabuna, [itapetinga, itororo, rio_do_meio, firmino_alves, ponto_do_asterio, santa_cruz_da_vitoria, ent_santa_cruz_da_vitoria, floresta_azul, ibicarai, ent_itape, itabuna], [rota/"174"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"174"/"6:00"/[seg,ter,qua,qui,sex,sab], rota/"174"/"11:20"/[dom]]).
linha(itabuna, ibicarai, [itabuna, ferradas, ent_itape, cajueiro, ibicarai], [rota/"175"/"14:30"/[seg,ter,qua,qui,sex,sab]]).
linha(ibicarai, itabuna, [ibicarai, cajueiro, ent_itape, ferradas, itabuna], [rota/"175"/"5:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, floresta_azul, [itabuna, ferradas, ent_itape, cajueiro, ibicarai, floresta_azul], [rota/"176"/"11:30"/[seg,ter,qua,qui,sex,sab],rota/"176"/"18:30"/[seg,ter,qua,qui,sex], rota/"176"/"20:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(floresta_azul, itabuna, [floresta_azul, ibicarai, cajueiro, ent_itape, ferradas, itabuna], [rota/"176"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"176"/"12:50"/[seg,ter,qua,qui,sex,sab], rota/"176"/"15:40"/[seg,ter,qua,qui,sex]]).
linha(itabuna, itape, [itabuna, ferradas, ent_itape, itape], [rota/"177.URB"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"9:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"12:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"14:15"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"16:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"18:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itape, itabuna, [itape, ent_itape, ferradas, itabuna], [rota/"177.URB"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"11:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"13:10"/[seg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"15:00"/[serg,ter,qua,qui,sex,sab,dom], rota/"177.URB"/"17:45"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, almadina, [itabuna, itajuipe, uniao_queimada, coaraci, sao_roque, almadina], [rota/"178"/"15:00"/[seg,ter,qua,qui,sex,sab]]).
linha(almadina, itabuna, [almadina, sao_roque, coaraci, uniao_queimada,itajuipe, itabuna], [rota/"178"/"18:30"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, barro_preto, [itabuna, ent_barro_preto, barro_preto], [rota/"179.URB"/"6:00"/[seg,ter,qua,qui,sex], rota/"179.URB"/"7:00"/[seg,ter,qua,qui,sex], rota/"179.URB"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"14:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"17:00"/[seg,ter,qua,qui,sex,sab], rota/"179.URB"/"19:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"22:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"10:00"/[seg,ter,qua,qui,sex], rota/"179.URB"/"11:00"/[seg,ter,qua,qui,sex], rota/"179.URB"/"15:00"/[seg,ter,qua,qui,sex], rota/"179.URB"/"18:30"/[seg,ter,qua,qui,sex]]).
linha(barro_preto, itabuna, [barro_preto, ent_barro_preto, itabuna], [rota/"179.URB"/"6:00"/[seg,ter,qua,qui,sex], rota/"179.URB"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"17:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"179.URB"/"21:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, coaraci, [itabuna, itajuipe, uniao_queimada, coaraci], [rota/"180"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"20:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"23:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(coaraci, itabuna, [coaraci, uniao_queimada, itajuipe, itabuna], [rota/"180"/"5:50"/[seg,ter,qua,qui,sex,sab], rota/"180"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"12:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"180"/"21:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, itapitanga, [itabuna, itajuipe, coaraci, itapitanga], [rota/"181"/"9:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"181"/"17:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itapitanga, itabuna, [itapitanga, coaraci, itajuipe, itabuna], [rota/"181"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"181"/"13:15"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(vitoria_da_conquista, itapetinga, [vitoria_da_conquista, ent_limeira, marcal, jose_jacinto, jussara, ent_itambe, itambe, mata_escura, ent_caatiba, itapetinga], [rota/"182"/"13:40"/[seg,ter,qua,qui,sex], rota/"182"/"17:45"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itapetinga, vitoria_da_conquista, [itapetinga, ent_caatiba, mata_escura,itambe, ent_itambe, jussara, jose_jacinto, marcal, ent_limeira, vitoria_da_conquista], [rota/"182"/"5:20"/[seg,ter,qua,qui,sex], rota/"182"/"6:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, vitoria_da_conquista, [itabuna, ent_itape, ibicarai, floresta_azul, ent_santa_cruz_da_vvitoria, ponto_do_asterio, firmino_alves, rio_do_meio, itororo, itapetinga, itambe, marcal, vitoria_da_conquista], [rota/"184"/"4:00"/[seg,ter,qua,qui,sex,sab], rota/"184"/"5:30"/[seg,ter,qua,qui,sex,sab,dom],rota/"184"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"184"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"184"/"16:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, mascote, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, vargito, pimenta, mascote], [rota/"190"/"15:30"/[seg,ter,qua,qui]]).
linha(mascote, itabuna, [mascote, pimenta, vargito, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"190"/"5:45"/[seg,ter,qua,qui]]).
linha(itabuna, camacan, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camacan], [rota/"191"/"15:30"/[sex]]).
linha(camacan, itabuna, [camacan, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"191"/"6:45"/[sex]]).
linha(itabuna, porto_seguro, [itabuna, buerarema, sao_jose_da_vitoria, prata,rio_branco, ent_camaca, camaca, rio_pardo, sao_joao_do_paraiso, coreia, ent_itapebi, itagimirim, mundo_novo, eunapolis, porto_seguro], [rota/"197"/"12:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(porto_seguro, itabuna, [porto_seguro, eunapolis, mundo_novo, itagimirim, ent_itapebi, coreia, sao_joao_do_paraiso, rio_pardo, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"197"/"5:00"/[seg,ter,qua,qui,sex,sab], rota/"197"/"5:30"/[dom]]).
linha(itabuna, porto_seguro, [itabuna, sao_jose_da_vitoria, camacan, sao_joao_do_paraiso, itagimirim, eunapolis, porto_seguro], [rota/"197.EXE"/"5:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"197.EXE"/"14:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(porto_seguro, itabuna, [porto_seguro, eunapolis, itagimirim, sao_joao_do_paraiso, camacan, sao_jose_da_vitoria, itabuna], [rota/"197.EXE"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"197.EXE"/"18:10"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ilheus, porto_seguro, [ilheus, itabuna, buerarema, sao_jose_da_vitoria,prata, rio_branco, ent_camaca, camaca, rio_pardo, sao_joao_do_paraiso, coreia, ent_itapebi, itagimirim, mundo_novo, eunapolis, porto_seguro], [rota/"197A2"/"18:00"/[sex,sab,dom]]).
linha(porto_seguro, ilheus, [porto_seguro, eunapolis, mundo_novo, itagimirim,ent_itapebi, coreia, sao_joao_do_paraiso, rio_pardo, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna, ilheus], [rota/"197A2"/"10:00"/[sex,sab,dom]]).
linha(ilheus, porto_seguro, [ilheus, itabuna, camaca, eunapolis, porto_seguro], [rota/"197A2.EXE"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"197A2.EXE"/"15:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"197A2.EXE"/"18:00"/[seg,ter,qua,qui]]).
linha(porto_seguro, ilheus, [porto_seguro, eunapolis, camaca, itabuna, ilheus], [rota/"197A2.EXE"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"197A2.EXE"/"10:00"/[seg,ter,qua,qui], rota/"197A2.EXE"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itacare, porto_seguro, [itacare, serra_grande, ilheus, itabuna, sao_jose_da_vitoria, prata, rio_branco, sao_joao_do_paraiso, itagimirim, eunapolis, porto_seguro], [rota/"197X.CAR"/"7:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(porto_seguro, itacare, [porto_seguro, eunapolis, itagimirim, sao_joao_do_paraiso, rio_branco, prata, sao_jose_da_vitoria, itabuna, ilheus, serra_grande, itacare], [rota/"197X.CAR"/"12:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(porto_seguro, jequie, [porto_seguro, eunapolis, itagimirim, sao_joao_do_paraiso, itabuna, ubaitaba, ubata, ipiau, jitauna, jequie], [rota/"197X2"/"22:00"/[sab,dom]]).
linha(jequie, porto_seguro, [jequie, jitauna, ipiau, ubata, ubaitaba, itabuna, sao_joao_do_paraiso, itagimirim, eunapolis, porto_seguro], [rota/"197X2"/"22:00"/[sab,dom]]).
linha(porto_seguro, jequie, [porto_seguro, eunapolis, itagimirim, itabuna, ubaitaba, ubata, ipiau, jequie], [rota/"197X2.EXE"/"22:00"/[seg,ter,qua,qui,sex]]).
linha(jequie, porto_seguro, [jequie, ipiau, ubata, ubaitaba, itabuna, itagimirim, eunapolis, porto_seguro], [rota/"197X2.EXE"/"22:00"/[seg,ter,qua,qui,sex]]).
linha(itabuna, pau_brasil, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, pedro_baio, pau_brasil], [rota/"199"/"7:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"199"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"199"/"17:45"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(pau_brasil, itabuna, [pau_brasil, pedro_baio, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"199"/"5:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"199"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"199"/"16:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, belmonte, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, rio_pardo, sao_joao_do_paraiso, coreia, itapebi, barrolandia, brejinhos, belmonte], [rota/"200"/"11:00"/[seg,ter,qua,qui,sex,sab]]).
linha(belmonte, itabuna, [belmonte, brejinhos, barrolandia, itapebi, coreia, sao_joao_do_paraiso, rio_pardo, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"200"/"5:45"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, canavieiras, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, santa_luzia, barreiro, canavieiras], [rota/"201"/"6:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"201"/"13:00"/[seg,ter,qua,qui,sex,sab]]).
linha(canavieiras, itabuna, [canavieiras, barreiro, santa_luzia, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"201"/"5:45"/[seg,ter,qua,qui,sex,sab], rota/"201"/"13:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(camacan, canavieiras, [camacan, santa_luzia, barreiro, canavieiras], [rota/"201R.MIC"/"6:45"/[seg,ter,qua,qui,sex,sab]]).
linha(canavieiras, camacan, [canavieiras, barreiro,santa_luzia, camacan], [rota/"201R.MIC"/"11:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, inema, [itabuna, itajuipe, uniao_queimada, pimenteira, inema], [rota/"203"/"10:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"203"/"17:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(inema, itabuna, [inema, pimenteira, uniao_queimada, itajuipe, itabuna], [rota/"203"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"203"/"14:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, itaju_do_colonia, [itabuna, ferradas, ent_itape, itape, estiva, bomfim, itaju_do_colonia], [rota/"205"/"15:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itaju_do_colonia, itabuna, [itaju_do_colonia, bomfim, estiva, itape, ent_itape, ferradas, itabuna], [rota/"205"/"5:45"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, itaju_do_colonia, [itabuna, ferradas, ent_itape, cajueiro,ibicarai, floresta_azul, santa_cruz_da_vitoria, itaju_do_colonia], [rota/"205I"/"7:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"205I"/"17:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itaju_do_colonia, itabuna, [itaju_do_colonia, santa_cruz_da_vitoria, floresta_azul, ibicarai, cajueiro, ent_itape, ferradas, itabuna], [rota/"205I"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"205I"/"12:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itapetinga, macarani, [itapetinga, ent_macarani, macarani], [rota/"209"/"5:50"/[seg], rota/"209"/"6:50"/[ter,qua,qui,sex,sab,dom], rota/"209"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"9:50"/[seg,ter,qua,qui,sex,sab], rota/"209"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"14:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"16:10"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(macarani, itapetinga, [macarani, ent_macarani, itapetinga], [rota/"209"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"10:55"/[seg,ter,qua,qui,sex,sab], rota/"209"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"209"/"17:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, sao_joao_do_paraiso, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, vargito, faz_palestina, sao_joao_do_paraiso], [rota/"215"/"6:30"/[qui]]).
linha(sao_joao_do_paraiso, itabuna, [sao_joao_do_paraiso, faz_palestina, vargito, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"215"/"9:30"/[qui]]).
linha(itabuna, urucua, [itabuna, ent_itajuipe, itajuipe, ent_urucuca, urucua], [rota/"217"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"19:10"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(urucua, itabuna, [urucua, ent_urucuca, itajuipe, ent_itajuipe, itabuna], [rota/"217"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"8:00"/[dom], rota/"217"/"10:30"/[seg,ter,qua,qui,sex,sab], rota/"217"/"13:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"217"/"18:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, jussari, [itabuna, buerarema, sao_jose_da_vitoria, itaingui, jussari], [rota/"218"/"14:00"/[seg,ter,qua,qui,sex,sab]]).
linha(jussari, itabuna, [jussari, itaingui, sao_jose_da_vitoria, buerarema, itabuna], [rota/"218"/"5:30"/[seg,ter,qua,qui,sex,sab]]).
linha(buerarema, sao_jose_da_vitoria, [buerarema, sao_jose_da_vitoria], [rota/"218R"/"13:50"/[seg,ter,qua,qui,sex,sab]]).
linha(sao_jose_da_vitoria, buerarema, [sao_jose_da_vitoria, buerarema], [rota/"218R"/"6:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, palmira, [itabuna, buerarema, sao_jose_da_vitoria, itatingui, jussari, palmira], [rota/"219"/"9:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"219"/"16:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(palmira, itabuna, [palmira, jussari, itatingui, sao_jose_da_vitoria, buerarema, itabuna], [rota/"219"/"5:45"/[seg,ter,qua,qui,sex,sab,dom], rota/"219"/"13:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, ubaitaba, [itabuna, ent_itajuipe, itajuipe, santa_cruz, cascata, ubaitaba], [rota/"220"/"17:25"/[sex]]).
linha(ubaitaba, itabuna, [ubaitaba, cascata, santa_cruz, itajuipe, ent_itajuipe, itabuna], [rota/"220"/"16:10"/[sex]]).
linha(ilheus, itacare, [ilheus, joia_do_atlantico, ponta_daa_tulha, ponta_do_ramo, serra_grande, fazenda_boa_sorte, itacare], [rota/"240"/"9:10"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itacare, ilheus, [itacare, fazenda_boa_sorte, serra_grande, ponta_do_ramo, ponta_daa_tulha, joia_do_atlantico, ilheus], [rota/"240"/"10:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, itacare, [itabuna, salobrinho, banco_da_vitoria, ilheus, joia_do_atlantico, ponta_da_tulha, ponta_do_ramo, serra_grande, fazenda_boa_sorte, itacare], [rota/"240X"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"9:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"10:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"19:00"/[ter,qua,qui,sex,sab,dom]]).
linha(itacare, itabuna, [itacare, fazenda_boa_sorte, serra_grande, ponta_do_ramo, ponta_da_tulha, joia_do_atlantico, ilheus, banco_da_vitoria, salobrinho, itabuna], [rota/"240X"/"5:15"/[ter,qua,qui,sex,sab,dom], rota/"240X"/"6:15"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"13:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"14:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"15:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"17:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X"/"19:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, itacare, [itabuna, ilheus, joia_do_atlantico, ponta_da_tulha, serra_grande, fazenda_boa_sorte, itacare], [rota/"240X.EXE"/"7:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X.EXE"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itacare, itabuna, [itacare, fazenda_boa_sorte, serra_grande, ponta_da_tulha, joia_do_atlantico, ilheus, itabuna], [rota/"240X.EXE"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"240X.EXE"/"18:20"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ilheus, ubaitaba, [ilheus, urucuca, aurelino_leal, ubaitaba], [rota/"244"/"5:50"/[seg,ter,qua,qui,sex,sab], rota/"244"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"244"/"12:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"244"/"18:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ubaitaba, ilheus, [ubaitaba, aurelino_leal, urucuca, ilheus], [rota/"244"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"244"/"9:40"/[seg,ter,qua,qui,sex,sab], rota/"244"/"13:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"244"/"17:10"/[seg,ter,qua,qui,sex,sab], rota/"244"/"18:00"/[dom]]).
linha(itabuna, olivenca, [itabuna, salobrinho, banco_da_vitoria, ilheus, ilheus_centro, olivenca], [rota/"246"/"5:30"/[dom], rota/"246"/"5:40"/[seg,ter,qua,qui,sex,sab]]).
linha(olivenca, itabuna, [olivenca, ilheus_centro, ilheus, banco_da_vitoria, salobrinho, itabuna], [rota/"246"/"19:30"/[dom], rota/"246"/"19:40"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, olivenca, [itabuna, salobrinho, banco_da_vitoria, ilheus, olivenca], [rota/"246.EXE"/"6:30"/[dom], rota/"246.EXE"/"6:35"/[seg,ter,qua,qui,sex,sab,dom], rota/"246.EXE"/"7:30"/[dom], rota/"246.EXE"/"7:35"/[seg,ter,qua,qui,sex,sab,dom], rota/"246.EXE"/"8:30"/[dom], rota/"246.EXE"/"8:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"9:30"/[dom], rota/"246.EXE"/"9:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"10:30"/[dom], rota/"246.EXE"/"10:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"11:30"/[dom], rota/"246.EXE"/"11:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"12:30"/[dom], rota/"246.EXE"/"12:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"13:30"/[dom], rota/"246.EXE"/"13:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"14:30"/[dom], rota/"246.EXE"/"14:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"15:30"/[dom], rota/"246.EXE"/"15:35"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"16:30"/[dom], rota/"246.EXE"/"16:35 "/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"17:30"/[dom], rota/"246.EXE"/"17:35"/[seg,ter,qua,qui,sex,sab]]).
linha(olivenca, itabuna, [olivenca, ilheus, banco_da_vitoria, salobrinho,itabuna], [rota/"246.EXE"/"7:20"/[dom], rota/"246.EXE"/"7:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"8:20"/[dom], rota/"246.EXE"/"8:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"9:20"/[dom], rota/"246.EXE"/"9:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"10:20"/[dom], rota/"246.EXE"/"10:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"11:20"/[dom], rota/"246.EXE"/"11:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"12:20"/[dom], rota/"246.EXE"/"12:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"13:20"/[dom], rota/"246.EXE"/"13:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"14:20"/[dom], rota/"246.EXE"/"14:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"15:20"/[dom], rota/"246.EXE"/"15:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"16:20"/[dom], rota/"246.EXE"/"16:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"17:20"/[dom], rota/"246.EXE"/"17:40"/[seg,ter,qua,qui,sex,sab], rota/"246.EXE"/"18:20"/[dom], rota/"246.EXE"/"18:40"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, ilheus, [itabuna, salobrinho, banco_da_vitoria, ilheus], [rota/"248"/"zerado"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ilheus, itabuna, [ilheus, banco_da_vitoria, salobrinho, itabuna], [rota/"248"/"zerado"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, ilheus, [itabuna, salobrinho, banco_da_vitoria, ilheus], [rota/"248.URBAR"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"6:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"7:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"8:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"9:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"10:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"11:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"12:20"/[seg,ter,qau,qui,sex,sab,dom], rota/"248.URBAR"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"13:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"14:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"14:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"15:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"16:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"17:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"18:200"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"19:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"19:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"20:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"20:45"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"21:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"22:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"23:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ilheus, itabuna, [lheus, banco_da_vitoria, salobrinho, itabuna], [rota/"248.URBAR"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"6:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"7:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"8:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"8:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"9:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"10:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"10:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"11:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"12:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"12:20"/[seg,ter,qau,qui,sex,sab,dom], rota/"248.URBAR"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"13:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"14:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"14:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"15:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"16:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"16:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"17:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"18:200"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"19:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"19:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"20:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"20:45"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"21:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"22:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248.URBAR"/"23:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, salobrinho, [itabuna, br_415, salobrinho], [rota/"248R.URB"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"5:45"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"6:15"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"7:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"8:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"9:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"10:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"11:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"12:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"13:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"14:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"15:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"16:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"17:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"18:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"19:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"19:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"20:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"21:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"21:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"22:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(salobrinho, itabuna, [salobrinho, br_415, itabuna], [rota/"248R.URB"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"5:45"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"6:15"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"7:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"8:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"9:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"9:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"10:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"11:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"11:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"12:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"13:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"13:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"14:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"15:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"16:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"17:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"15:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"17:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"18:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"19:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"19:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"20:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"21:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"21:40"/[seg,ter,qua,qui,sex,sab,dom], rota/"248R.URB"/"22:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itapetinga, potiragua, [itapetinga, entronc_ba130/ba670, itororo, ent_palmares, ponto_da_venda, faz_palmeiras, ponto_da_balsa, potiragua], [rota/"277"/"11:30"/[seg,ter,qua,qui,sex,sab]]).
linha(potiragua, itapetinga, [potiragua, ponto_da_balsa, faz_palmeiras, ponto_da_venda, ent_palmares, itororo, entronc_ba130/ba670, itapetinga], [rota/"277"/"5:50"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, ibirataia, [itabuna, ent_itajuipe, itajuipe, ubaitaba, ent_ibirapitanga, ibirapitanga, ent_ibirataia, ibirataia], [rota/"380"/"14:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ibirataia, itabuna, [ibirataia, ent_ibirataia, ibirapitanga, ent_ibirapitanga, ubaitaba, itajuipe, ent_itajuipe, itabuna], [rota/"380"/"5:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itapetinga, potiragua, [itapetinga, ent_macarani, maiquinique, pau_sangue, itarantim, lourival_maxixe, potiragua], [rota/"390"/"14:20"/[dom]]).
linha(potiragua, itapetinga, [potiragua, lourival_maxixe, itarantim, pau_sangue, maiquinique, ent_macarani, itapetinga], [rota/"390"/"9:20"/[dom]]).
linha(itabuna, itabela, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, vargito, rio_pardo, sao_joao_do_paraiso, teixeira_do_progresso, itagimirim, mundo_novo, eunapolis, itabela], [rota/"418"/"6:30"/[ter]]).
linha(itabela, itabuna, [itabela, eunapolis, mundo_novo, itagimirim, teixeira_do_progresso, sao_joao_do_paraiso, rio_pardo, vargito, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"418"/"13:30"/[ter]]).
linha(itabuna, teixeira_de_freitas, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, varguti, sao_joao_do_paraiso, teixeira_do_progresso, itagimirim, eunapolis, itabela, itamaraju, teixeira_de_freitas], [rota/"419"/"6:00"/[ter,qua]]).
linha(teixeira_de_freitas, itabuna, [teixeira_de_freitas, itamaraju, itabela, eunapolis, itagimirim, teixeira_do_progresso, sao_joao_do_paraiso, varguti, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"419"/"22:50"/[ter,qua]]).
linha(ilheus, teixeira_de_freitas, [ilheus, itabuna, camaca, sao_joao_do_paraiso, itagimirim, eunapolis, itabela, itamaraju, teixeira_de_freitas], [rota/"419A2.EXE"/"22:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(teixeira_de_freitas, ilheus, [teixeira_de_freitas, itamaraju, itabela, eunapolis, itagimirim, sao_joao_do_paraiso, camaca, itabuna, ilheus], [rota/"419A2.EXE"/"8:15"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, guaratinga, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, vargito, sao_joao_do_paraiso, teixeira_do_progresso, itagimirim, mundo_novo, eunapolis, itabela, guaratinga], [rota/"420"/"6:30"/[qua]]).
linha(guaratinga, itabuna, [guaratinga, itabela, eunapolis, mundo_novo, itagimirim, teixeira_do_progresso, sao_joao_do_paraiso, vargito, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"420"/"13:30"/[qua]]).
linha(itabuna, itaimbe, [itabuna, buerarema, sao_jose_da_vitoria, prata, rio_branco, ent_camaca, camaca, vargito, rio_pardo, sao_joao_do_paraiso, teixeira_do_progresso, itaimbe], [rota/"438"/"15:30"/[sab,dom]]).
linha(itaimbe, itabuna, [itaimbe, teixeira_do_progresso, sao_joao_do_paraiso, rio_pardo, vargito, camaca, ent_camaca, rio_branco, prata, sao_jose_da_vitoria, buerarema, itabuna], [rota/"438"/"5:15"/[sab], rota/"438"/"5:30"/[dom]]).
linha(itabuna, serra_grande, [itabuna, ent_itajuipe, itajuipe, ent_urucuca, urucuca, serra_grande], [rota/"452"/"12:00"/[dom]]).
linha(serra_grande, itabuna, [serra_grande, urucuca, ent_urucuca, itajuipe, ent_itajuipe, itabuna], [rota/"452"/"6:30"/[dom]]).
linha(itapetinga, camacan, [itapetinga, tres_lagoas, firmino_alves, ent_santa_cruz_da_vitoria, santa_cruz_da_vitoria, palmira, jacareci, camacan], [rota/"453"/"14:00"/[segter,qua,qui,sex,sab]]).
linha(camacan, itapetinga, [camacan, jacareci, palmira, santa_cruz_da_vitoria, ent_santa_cruz_da_vitoria, firmino_alves, tres_lagoas, itapetinga], [rota/"453"/"6:00"/[seg,ter,qua,qui,sex,sab]]).
linha(ilheus, almadina, [ilheus, ilheus, itabuna, itajuipe, coaraci, sao_roque, almadina], [rota/"456"/"7:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"456"/"11:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"456"/"14:00"/[dom], rota/"456"/"17:30"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(almadina, ilheus, [almadina, sao_roque, coaraci, itajuipe, itabuna,ilheus, ilheus], [rota/"456"/"6:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"456"/"10:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"456"/"14:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"456"/"18:30"/[dom]]).
linha(ilheus, banco_central, [ilheus, ent_castelo_novo, urucuca, posto_santo_antonio, banco_central], [rota/"468"/"8:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"468"/"15:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(banco_central, ilheus, [banco_central, posto_santo_antonio, urucuca, ent_castelo_novo, ilheus], [rota/"468"/"5:30"/[seg,ter,qua,qui,sex,sab,dom], rota/"468"/"11:40"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(itabuna, almadina, [itabuna, ferradas, ent_itape, cajueiro, ibicarai, floresta_azul, almadina], [rota/"476"/"15:30"/[seg,ter,qua,qui,sex,sab]]).
linha(almadina, itabuna, [almadina, floresta_azul, ibicarai, cajueiro, ent_itape, ferradas, itabuna], [rota/"476"/"5:00"/[seg,ter,qua,qui,sex,sab]]).
linha(vitoria_da_conquista, potiragua, [vitoria_da_conquista, marcal, faz_jose_jacinto, faz_jussara, itambe, mata_escura, ent_caatiba, itapetinga, ent_macarani, maiquinique, faz_pau_sangue, itarantim, lourival_maxixe, potiragua], [rota/"ent limeira"/"12:30"/[seg,ter,qua,qui,sex,sab], rota/"ent limeira"/"15:30"/[seg,ter,qua,qui,sex,sab], rota/"ent limeira"/"15:45"/[dom]]).
linha(potiragua, vitoria_da_conquista, [potiragua, lourival_maxixe, itarantim, faz_pau_sangue, maiquinique, ent_macarani, itapetinga, ent_caatiba, mata_escura, itambe, faz_jussara, faz_jose_jacinto, marcal, vitoria_da_conquista], [rota/"ent limeira"/"5:20"/[seg,ter,qua,qui,sex,sab,dom], rota/"ent limeira"/"9:20"/[seg,ter,qua,qui,sex,sab]]).
linha(camacan, macarani, [camacan, vargito, faz_palestina, paraiso, teixeira_do_progresso, itaimbe, gurupa_mirim, ent_angelim, ent_nova_america, portiragua, itarantim, faz_pau_sangue, maiquinique, macarani], [rota/"489"/"12:00"/[sab]]).
linha(macarani, camacan, [macarani, maiquinique, faz_pau_sangue, itarantim, portiragua, ent_nova_america, ent_angelim, gurupa_mirim, itaimbe, teixeira_do_progresso, paraiso, faz_palestina, vargito, camacan], [rota/"489"/"6:00"/[sab]]).
linha(vitoria_da_conquista, macarani, [vitoria_da_conquista, ent_limeira,marcal, faz_jose_jacinto, faz_jussara, ent_itambe, itambe, mata_escura, ent_caatiba, itapetinga, macarani], [rota/"577"/"16:00"/[seg,ter,qua,qui,sex,sab]]).
linha(itabuna, serra_grande, [itabuna, ilheus, ponta_da_tulha, ponta_do_ramo, serra_grande], [rota/"621"/"19:00"/[seg]]).
linha(serra_grande, itabuna, [serra_grande, ponta_do_ramo, ponta_da_tulha, ilheus, itabuna], [rota/"621"/"5:45"/[seg]]).
linha(itabuna, ipiau, [itabuna, itajuipe, coaraci, itapitanga, ent_poco_central, gongogi, ubata, ipiau], [rota/"622"/"6:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(ipiau, itabuna, [ipiau, ubata, gongogi, ent_poco_central, itapitanga, coaraci, itajuipe, itabuna], [rota/"622"/"14:30"/[seg,ter,qua,qui,sex,sab,dom]]).

linha(itabuna, itajuipe, [itabuna, itajuipe], [rota/"127.urb"/"5:00"/[seg,ter,qua,qui,sex,sab,dom], rota/"127.urb"/"5:30"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"5:50"/[seg,ter,qua,qui,sex,sab],rota/"127.urb"/"6:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"7:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"7:45"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"8:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"8:45"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"9:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"9:45"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"10:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"10:45"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"11:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"11:45"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"12:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"12:45"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"13:15"/[seg,ter,qua,qui,sex,sab], rota/"127.urb"/"13:45"/[seg,ter,qua,qui,sex], rota/"127.urb"/"14:15"/[seg,ter,qua,qui,sex], rota/"127.urb"/"14:45"/[seg,ter,qua,qui,s,rota/"127.urb"/"15:15"/[seg,ter,qua,qui,sex], rota/"127.urb"/"15:45"/[seg,ter,qua,qui,sex], rota/"127.urb"/"16:15"/[seg,ter,qua,qui,sex], rota/"127.urb"/"16:45"/[seg,ter,qua,qui,sex], rota/"127.urb"/"17:15"/[seg,ter,qua,qui,sex], rota/"127.urb"/"17:45"/[seg,ter,qua,qui,sex], rota/"127.urb"/"18:15"/[seg,ter,qua,qui,sex], rota/"127.urb"/"18:45"/[seg,ter,qua,qui,sex], rota/"127.urb"/"19:15"/[seg,ter,qua,qui,sex], rota/"127.urb"/"19:45"/[seg,ter,qua,qui,sex], rota/"127.urb"/"20:20"/[seg,ter,qua,qui,sex], rota/"127.urb"/"13:40"/[sab], rota/"127.urb"/"14:20"/[sab], rota/"127.urb"/"15:00"/[sab], rota/"127.urb"/"15:40"/[sab], rota/"127.urb"/"16:20"/[sab], rota/"127.urb"/"17:00"/[sab], rota/"127.urb"/"17:40"/[sab], rota/"127.urb"/"18:20"/[sab], rota/"127.urb"/"19:00"/[sab], rota/"127.urb"/"19:40"/[sab], rota/"127.urb"/"20:20"/[sab], rota/"127.urb"/"5:40"/[dom], rota/"127.urb"/"6:20"/[dom], rota/"127.urb"/"7:00"/[dom], rota/"127.urb"/"7:40"/[dom], rota/"127.urb"/"8:20"/[dom], rota/"127.urb"/"9:00"/[dom], rota/"127.urb"/"9:40"/[dom], rota/"127.urb"/"10:20"/[dom], rota/"127.urb"/"11:00"/[dom], rota/"127.urb"/"11:40"/[dom], rota/"127.urb"/"12:20"/[dom], rota/"127.urb"/"13:00"/[dom], rota/"127.urb"/"13:40"/[dom], rota/"127.urb"/"14:20"/[dom], rota/"127.urb"/"15:00"/[dom], rota/"127.urb"/"15:40"/[dom], rota/"127.urb"/"16:20"/[dom], rota/"127.urb"/"17:00"/[dom], rota/"127.urb"/"17:40"/[dom], rota/"127.urb"/"18:20"/[dom], rota/"127.urb"/"19:00"/[dom], rota/"127.urb"/"19:40"/[dom], rota/"127.urb"/"20:20"/[dom], rota/"127.urb"/"20:40"/[dom], rota/"127.urb"/"21:00"/[dom]]]).

linha(itabuna, marau, [itabuna, salobrinho, ilheus, joia_do_atlantico, ponta_da_tulha, ponta_do_ramo, serra_grande, fazenda_boa_sorte, itacare, caubi, marau], [rota/"124I"/"12:00"/[seg,ter,qua,qui,sex,sab,dom]]).
linha(marau, itabuna, [marau, caubi, itacare, fazenda_boa_sorte, serra_grande, ponta_do_ramo, ponta_da_tulha, joia_do_atlantico, ilheus, salobrinho, itabuna], [rota/"124I"/"6:15"/[seg,ter,qua,qui,sex,sab,dom]]).






