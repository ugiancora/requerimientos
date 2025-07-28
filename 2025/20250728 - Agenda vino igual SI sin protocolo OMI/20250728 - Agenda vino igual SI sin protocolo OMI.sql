select count(*)
  from
  		(
	select (coalesce(AGENDADO,'')||'-'||COALESCE(ASISTENCIA,'')||'-'||COALESCE(PROTOCOLO,'')) as ESTADO,*  
	  from	(
			select distinct 
					case 
						when a.cit_id is not null and a.pac_id is null 					then 'Con agenda sin agendamiento'
						when a.cit_id is not null and a.pac_id is not null				then 'Con agenda agendado'
						when a.cit_id is NULL				then 'Sin agenda'
						end as agendado
					,case 
						when a.cit_id is not null and a.vino 							then 'Asiste'
						when a.cit_id is not null and a.vino is false					then 'No asiste'
						when a.vino is null												then 'Sin control de asistencia'
						end as asistencia
					,case 
						when prp_id is not null then 'Con Protocolo'
						when prp_id is null 	then 'Sin Protocolo'
					end PROTOCOLO
					,case when a02.centro is null then a01.centro else a02.centro end as centro,a02.nombre_completo profesional_clinico,a.* 
			  from omicolors_staging.ugi_hcc_contactos as a 
			  left join omicolors_staging.stk_personas as a01 on a01.pac_id=a.pac_id and a01.pac_id is not null
			  left join omicolors_staging.stk_personas as a02 on a02.per_id=a.con_per_id and a02.pac_id is not null
			 where a.fecha_contacto2 between '20250101' and '20250726' 
			   and (a.medico or enfermera or nutricionista or kinesiologo or terapeuta_ocupacional or matrona or odontologo or psicologa or trabajador_social)
			   and vino and prp_id is null
			) as A order by 1 
	) as a;