-- products IN both 2019 AND 2020
-- comparing products that are IN both years AND finding the most inceased IN revenue 
SELECT  *
       ,( tot_amount_of_2020- tot_amount_of_2019) AS Diffrence -- subtracting 2020 amount FROM 2019 amounts to find the diffrence for each product 
FROM
(
	SELECT  [product code] AS Product
	       ,SUM(amount_of_19)as Tot_amount_of_2019 -- dilevery amount for 2019 
	       ,SUM(amount_of_20)as Tot_amount_of_2020 -- dilevery amount for 2020 
	FROM
	(
		SELECT  [2019_Data].[Product code]
		       ,[2019_Data].[Delivery amount]as amount_of_19
		       ,year([2019_Data].[Date of delivery])as dilevery_date_19
		       ,[2020_Data].[Delivery amount]as amount_of_20
		       ,year([2020_Data].[Date of delivery]) AS dilevery_date_20
		FROM [2019_Data]
		JOIN [2020_Data]						  -- combining both 2020 AND 2021 to feach the total amounts
		ON [2019_Data].[Product code] = [2020_Data].[Product code]
	)x  
	GROUP BY  [product code]
)m
ORDER BY Diffrence;