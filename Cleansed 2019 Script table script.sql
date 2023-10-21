-- Cleansed 2019 data TABLE -- 
SELECT  [Order number]
       ,[Client ID]
       ,[Product code]
       ,cast([Date of delivery] AS Date) AS [Delivery Date] -- fetching day, month AND year only 
       ,[Delivery amount]
FROM [practice].[dbo].[2019_Data]
WHERE [Order number] IS NOT NULL                            -- Eleminate the NULL values
AND [Client ID] IS NOT NULL
AND [Product code] IS NOT NULL
ORDER BY [Date of delivery] 