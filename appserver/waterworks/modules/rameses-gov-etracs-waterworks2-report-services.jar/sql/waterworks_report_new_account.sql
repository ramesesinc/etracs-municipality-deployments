[getReport]
SELECT 
	acct.acctno, a.acctname, a.address_text, a.classificationid, acct.dtstarted, 
	wm.serialno as meter_serialno, wm.brand as meter_brand, wms.title as meter_size, 
	z.barangay_objid, z.barangay_name, z.code as block_code, z.description as block_description, 
	z.areaid as sector_objid, z.schedulegroupid, 
	case 
		when wm.state = 'DISCONNECTED' then wm.state else acct.state 
	end as state, 
	case 
		when a.classificationid='BULK' then a.classificationid 
		else substring(a.classificationid,1,3) 
	end as classcode 
FROM waterworks_account acct   
  INNER JOIN waterworks_account_info a ON acct.acctinfoid = a.objid
  INNER JOIN waterworks_subarea z ON z.objid = a.subareaid  	
 
	LEFT JOIN waterworks_meter wm on wm.objid = a.meterid 
	LEFT JOIN waterworks_metersize wms on wms.objid = wm.sizeid 
where acct.dtstarted >= $P{startdate} 
	and acct.dtstarted <  $P{enddate} 
	${filters} 
order by acct.dtstarted, a.acctname 