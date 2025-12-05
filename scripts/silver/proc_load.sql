INSERT INTO silver.crm_cust_info(
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date)
SELECT 
[cst_id],
[cst_key],
TRIM([cst_firstname])as [cst_firstname],
TRIM([cst_lastname])as [cst_lastname],
CASE WHEN cst_marital_status='S' THEN 'SINGLE'
	 WHEN [cst_marital_status]='M' THEN 'MARRIED'
	 ELSE 'N/A'
END AS [cst_marital_status],
CASE WHEN [cst_gndr]='M' THEN 'MALE'
	 WHEN [cst_gndr]='F' THEN 'FEMALE'
	 ELSE 'N/A'
END AS [cst_gndr],
[cst_create_date]
FROM
(select 
*,
ROW_NUMBER() over (partition by cst_id order by cst_create_date desc) as flag_LAST
from [bronze].[crm_cust_info]
WHERE cst_id is not null
)t where flag_LAST=1

 
