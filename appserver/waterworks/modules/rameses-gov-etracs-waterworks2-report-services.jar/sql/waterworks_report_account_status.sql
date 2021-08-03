[getReport]
select 
	barangay_objid, barangay_name, 
	sum(res_active) as res_active, sum(com_active) as com_active, 
	sum(ind_active) as ind_active, sum(bulk_active) as bulk_active,
	sum(res_inactive) as res_inactive, sum(com_inactive) as com_inactive, 
	sum(ind_inactive) as ind_inactive, sum(bulk_inactive) as bulk_inactive, 
	sum(gov_active) as gov_active, sum(gov_inactive) as gov_inactive 
from ( 
	select 
		sa.barangay_objid, sa.barangay_name, 
		case 
			when wa.classificationid='RESIDENTIAL' and acct.state = 'ACTIVE' and ifnull(acct.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as res_active, 
		case 
			when wa.classificationid='COMMERCIAL' and acct.state = 'ACTIVE' and ifnull(acct.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as com_active, 
		case 
			when wa.classificationid='INDUSTRIAL' and acct.state = 'ACTIVE' and ifnull(acct.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as ind_active, 
		case 
			when wa.classificationid='BULK' and acct.state = 'ACTIVE' and ifnull(acct.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as bulk_active, 
		case 
			when wa.classificationid='GOVERNMENT' and acct.state = 'ACTIVE' and ifnull(acct.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as gov_active, 
		case 
			when wa.classificationid='RESIDENTIAL' and ifnull(acct.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='RESIDENTIAL' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as res_inactive,  
		case 
			when wa.classificationid='COMMERCIAL' and ifnull(acct.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='COMMERCIAL' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as com_inactive,  
		case 
			when wa.classificationid='INDUSTRIAL' and ifnull(acct.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='INDUSTRIAL' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as ind_inactive,  
		case 
			when wa.classificationid='BULK' and ifnull(acct.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='BULK' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as bulk_inactive, 
		case 
			when wa.classificationid='GOVERNMENT' and ifnull(acct.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='GOVERNMENT' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as gov_inactive  
	from waterworks_account acct  
		INNER JOIN waterworks_account_info wa ON acct.acctinfoid = wa.objid 
		INNER JOIN waterworks_subarea sa ON sa.objid = wa.subareaid 
		left join waterworks_meter wm on wm.objid = wa.meterid 
)t1 
where barangay_objid is not null ${filters} 
group by barangay_objid, barangay_name 
order by barangay_name 
