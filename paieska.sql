DECLARE @find VARCHAR(500);   
DECLARE @find1 VARCHAR(500);   
DECLARE @find2 VARCHAR(500);   
DECLARE @find3 VARCHAR(500);   
DECLARE @find4 VARCHAR(500);   
DECLARE @find5 VARCHAR(500);   

SET @find = 'per'; 
SET @find1  = '%'+@find1+'%'; 

--SET @find2  = CONCAT(@find, '%'); 

--SET @find = 'Man' + '%'; 

SELECT
dbo.t_stock.f_id,
dbo.t_stock.f_name,
g2.f_name as grupes2lygio_pav,
dbo.t_stock.f_imgurl AS product_url







FROM
dbo.t_stock
LEFT JOIN dbo.t_stockgroup AS g1 ON g1.f_id = dbo.t_stock.f_groupid
LEFT JOIN dbo.t_stockgroup as g2 ON g2.f_id = g1.f_parentid

WHERE
dbo.t_stock.f_catalog_item = '1'
and 


(dbo.t_stock.f_name LIKE '%'+@find+'%' or g2.f_name LIKE '%'+@find+'%')
ORDER BY CASE 
						 WHEN dbo.t_stock.f_name = @find THEN 0  								 -- kai pilnas zodis         					 :  PER
					   WHEN dbo.t_stock.f_name LIKE @find+'%' THEN 1    			 -- kai prasideda pirmas zodis         :  PER%
						 WHEN dbo.t_stock.f_name LIKE  '% '+ @find+'%' THEN 2    -- kai prasideda bet koks zodis       :  % PER%
             WHEN dbo.t_stock.f_name LIKE '%'+@find+'%' THEN 3       -- kai fragmentas bet kur  			     :  %PER%
             WHEN dbo.t_stock.f_name LIKE '%'+@find THEN 4           -- kai zodzio galas							 	   :  %PER
						 WHEN g2.f_name LIKE '%'+@find+'%' THEN 5                -- prekės grupėj(II) yra fragementas  :  %PER%
             ELSE 6
         END, dbo.t_stock.f_name ASC, g2.f_name asc

