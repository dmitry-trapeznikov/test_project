SELECT
kbt.kbt_code,
substr(kbt.kbt_code,1, 1) AS class_type,
CASE
	WHEN substr(kbt.kbt_code,2, 2) = 'LT' THEN 'Невозвратный'
	else 'Возвратный'
END AS fare_type,
CASE
	WHEN kbt.kbt_code LIKE '%WSP%' THEN 'Субсидируемый'
	else 'Несубсидируемый'
END AS subsidy_type,
CASE
	WHEN kbt.kbt_code LIKE '%UOW%' THEN 'СпецТариф'
	WHEN kbt.kbt_code LIKE '%UTOW%' THEN 'СпецТариф'
	WHEN kbt.kbt_code LIKE '%JOWID%' THEN 'СпецТариф'
	WHEN kbt.kbt_code LIKE '%JTOWID%' THEN 'СпецТариф'
	else 'Нет'
END AS special_fare,
class_type.class_code,
class_type.class_name
FROM SOFI_NORDSTAR.KBT_ID kbt
JOIN SOFI_NORDSTAR.CLASS_RES_ID class ON class.ID = kbt.CLASS_RES_ID
JOIN 
(
SELECT 
ID,
CODE AS  class_code,
NAME AS class_name
FROM SOFI_NORDSTAR.C_OBJECTS
WHERE dic_id = 104249
) class_type  ON  class_type.ID = class.CLASS_ID
--тест sqls 01--