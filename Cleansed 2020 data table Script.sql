-- Cleansed 2020 Data TABLE -- 
SELECT  [Order number]
       ,[Client ID]
       ,[Product code]
       ,cast([Date of delivery] AS Date)as [Delivery Date] -- fetching day, month AND year only no need for time 
       ,[Delivery amount]
FROM [practice].[dbo].[2020_Data]
WHERE [Order number] IS NOT NULL
AND [Client ID] IS NOT NULL
AND [Product code] IS NOT NULL
ORDER BY [Date of delivery];