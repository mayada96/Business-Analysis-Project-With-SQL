-- new products IN 2020 --
-- finding the new products for 2020 by amount AND date
SELECT  [2020_data].[Order number]
       ,[2020_data].[Client ID]
       ,[Product code]                   AS Novelties
       ,cast([date of delivery] AS date) AS Date -- fetching only date no need for hours 
       ,[Delivery amount]                AS Amount
FROM [2020_data]
WHERE [Product code] not IN ( SELECT [2020_data].[Product code] 
							  FROM [practice].[dbo].[2020_Data] JOIN [2019_Data] t2 ON [2020_data].[Product code] = t2.[Product code] -- combining the tow data tables to get the joiend products 
							  GROUP BY [2020_data].[Product code] );

-- FROM the anaysis abouve we can calculate the revenue those new products brought to the company
SELECT  sum (Amount) AS Total_Novelties_revenue -- the total revenue puchased by new customer IN 2020 
FROM
(
	SELECT  [2020_data].[Order number]
	       ,[2020_data].[Client ID]
	       ,[Product code]                   AS Novelties
	       ,cast([date of delivery] AS date) AS Date -- fetching only date no need for hours 
	       ,[Delivery amount]                AS Amount
	FROM [2020_data]
	WHERE [Product code] not IN ( SELECT [2020_data].[Product code] -- combining the tow data tables to get the joiend products 
								  FROM [practice].[dbo].[2020_Data] JOIN [2019_Data] t2 ON [2020_data].[Product code] = t2.[Product code] 
								  GROUP BY [2020_data].[Product code] )
)x;