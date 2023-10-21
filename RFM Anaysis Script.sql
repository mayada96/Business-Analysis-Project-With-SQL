-- RFM Anaysis -- 
declare @following_date date = '2020-12-25'
;

WITH base AS
(
	SELECT	[client id]																		-- number of orders each customer\client order 
			,DATEDIFF(day ,MAX([Date of delivery]) ,@following_date) AS reacency_test		-- reacency the diffrence BETWEEN today's date AND the most reasent purchase date 
			,COUNT([order number]) AS Frequency_test										-- Frequency number of orders per customer 
			,SUM([delivery amount]) AS Monetry_test											-- Montery the amount each client spend per year AND month 
	FROM (
	SELECT  *
	FROM [2020_data]
	UNION
	SELECT  *
	FROM [2019_data])x
	GROUP BY  [client id])
	         ,rfm AS (
	SELECT  *
			,NTILE(5)over (order by reacency_test Desc) AS R			-- grouping the result to 5 groups
			,NTILE(5)over (order by Frequency_test ) AS F 
			,NTILE(5)over (order by Monetry_test ) AS M					-- reacency, Frequency test, Monetry tests WITH 5 being the dedecated customers
	FROM base)
	SELECT  [Client ID]   AS Clients
	       ,CONCAT(R,F,M) AS RFM_Score
	       ,cast((cast(R as float)+F+M)/3 as decimal (16,2)) as Avg_RFM_score
	FROM rfm
	ORDER BY RFM_Score DESC;

/* Know from the RFM Anaysisi we can use it to group customers into 5 groups
 calculating the number of customers in ezch group
 the total revenue for each group 
 the avg_revenue for each group*/

declare @following_date date = '2020-12-25'
;

WITH base AS
(
	SELECT	[client id]																		-- number of orders each customer\client order
			,DATEDIFF(day,MAX([Date of delivery]),@following_date) AS reacency_test			-- reacency the diffrence BETWEEN today's date AND the most reasent purchase date 
			,COUNT([order number]) AS Frequency_test										-- Frequency number of orders per customer 
			,SUM([delivery amount]) AS Monetry_test											-- Montery the amount each client spend per year AND month 
	FROM (
	SELECT  *
	FROM [2020_data]
	UNION
	SELECT  *
	FROM [2019_data])x
	GROUP BY  [client id])
	         ,rfm AS (
	SELECT  *
	       ,NTILE(5)over (order by reacency_test Desc) AS R
	       ,NTILE(5)over (order by Frequency_test )    AS F
	       ,NTILE(5)over (order by Monetry_test )      AS M
	FROM base)
	SELECT  (R + f+ M)/3                                    AS RFM_Group
	       ,COUNT(rfm.[client id])                          AS Number_of_customer_per_group
	       ,cast (SUM(base.Monetry_test) AS decimal (12,2)) AS Avg_Amount_per_group
	FROM rfm
	JOIN base
	ON rfm.[Client ID] = base.[Client ID]
	GROUP BY  (R + f+ M)/3
	ORDER BY (R + f+ M)/3 DESC;