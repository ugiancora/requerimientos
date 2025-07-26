select a.*
  from 
  		(
		select a.pac_id,a.nif2,a.fecha2 as fecha_vdi,a01.epsa_resultado,a01.fecha2 as ingreso_epsa
		  from biancora.cubo_salud_sexual_y_reproductiva as a
		  left join (
					select pac_id,epsa_resultado,fecha2,row_number() over (partition by pac_id order by fecha2 desc) rownum 
					  from biancora.cubo_salud_sexual_y_reproductiva 
					 where protocolo_prenatal_ingreso=1 and epsa_resultado is not null
		  			) as a01 on a01.pac_id=a.pac_id
		 where a.vdi_visita_domiciliaria=1 
		   and a.fecha2>='20250101'
		   and a.pac_id in 	(
		   					select distinct pac_id 
		   					  from biancora.cubo_salud_sexual_y_reproductiva 
		   					 where fecha2>='20240101' and (protocolo_prenatal_ingreso=1 or protocolo_prenatal_control=1)    
		   					)
		) as a where (fecha_vdi - ingreso_epsa)<=365
order by 2,3;