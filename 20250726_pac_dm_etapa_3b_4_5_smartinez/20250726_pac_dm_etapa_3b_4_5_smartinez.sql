with etapa_erc as 	(
					select pac_id,fecha::Date as fecha,etapa_erc 
							,row_number() over (partition by pac_id order by fecha desc) rownum
					  from biancora.cubo_cronicos where etapa_erc is not null
					)
,pacientes_dm as 	(
					select distinct pac_id from biancora.cubo_cronicos where dm=1
					)
,pac_con_etapa as	(
					select  a.pac_id,a01.fecha,
						case 
								when a01.etapa_erc in ('Etapa G1 / >= 90','Etapa G2 / 60 a 89','Etapa 2 VFG 60-89 Daño renal bajo/leve VFG')	then '02.Etapa G1 y G2 - > 60'
								when a01.etapa_erc = 'Etapa G3a / 45 a 59'	then '03.Etapa G3a - > 45 a 59'
								when a01.etapa_erc = 'Etapa G3b / 30 a 44'	then '04.Etapa G3b - > 30 a 44'	
								when a01.etapa_erc = 'Etapa G4 / 15 a 29'	then '05.Etapa G4 - > 15 a 29'
								when a01.etapa_erc = 'Etapa G5 / < 15'		then '06.Etapa G5 - < 15'
							else a01.etapa_erc end etapa_erc,a01.etapa_erc etapa_erc2
					  from pacientes_dm as a
					  left join etapa_erc as a01 on a01.pac_id=a.pac_id and a01.rownum=1
					)
select a01.nombre_completo,a01.documento as run,a01.centro,a.* 
 from pac_con_etapa as a 
 left join omicolors_staging.stk_personas as a01 on a01.pac_id=a.pac_id
where etapa_erc in 
('04.Etapa G3b - > 30 a 44'
,'05.Etapa G4 - > 15 a 29'
,'06.Etapa G5 - < 15'
,'Etapa 3 VFG 30-59 Daño renal bajo/moderada VFG')
  and  a.pac_id in (select pac_id from rem_p.remp04_pbc_listado('20250725'))
  