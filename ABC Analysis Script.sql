-- ABC Analysis for total years --
WITH t1 AS
(
	SELECT  *
	FROM [2020_data]
	UNION
	-- combine the two data tabels 
	SELECT  *
	FROM [2019_Data]
) , t2 AS
(
	SELECT  t1.[product code]
	       ,COUNT(t1.[order number])                                     AS Num_of_orders
	       ,SUM(t1.[delivery amount])                                    AS Amount
	       ,DENSE_RANK() over ( ORDER BY SUM(t1.[delivery amount]) Desc) AS rnk		-- ranking result for latter classefication 
	FROM t1
	GROUP BY  [product code]
)
SELECT  [Product code] AS Product
       ,Num_of_orders
       ,Amount
       ,CASE WHEN t2.rnk IN ( SELECT top 20 percent rnk FROM t2 ) THEN 'A'			-- USING Empirical Pareto Low class A 20% of the Efforts 
             WHEN t2.rnk IN ( SELECT top 50 percent rnk FROM t2 ORDER BY rnk DEsc) THEN 'C'
             WHEN t2.rnk not IN ( SELECT top 20 percent rnk FROM t2 ) AND t2.rnk not IN ( SELECT top 50 percent rnk FROM t2 ORDER BY rnk DEsc) THEN 'B' END AS Class
FROM t2
ORDER BY Amount DESC , rnk;


-- ABC Analysis for 2 years WITH monthes
-- we can classify products WITH year AND months of purchased
WITH t1 AS
(
	SELECT  *
	FROM [2020_data]
	UNION
	SELECT  *
	FROM [2019_Data]
) , t2 AS
(
	SELECT  t1.[Product code]                               AS Product
	       ,COUNT(t1.[Order number])                        AS Num_of_order  --the number of order fo each product 
	       ,SUM(t1.[Delivery amount] )as Amount                              -- revenue of the products 
	       ,Year(t1.[date of delivery])                     AS Year          -- fetching the year 
	       ,left(Datename(month ,t1.[date of delivery]) ,3) AS Month		 -- fetching the Month WITH the first 3 letters
	FROM t1
	GROUP BY  t1.[Product code]
	         ,[date of delivery]
) , t3 AS
(
	SELECT  *
	       ,Ntile(3) over (order by num_of_order DESC ,amount DESC) AS Class -- catgorizing produxts INTo 3 classes abone thier orders AND revenue 
	FROM t2
)
SELECT  Product
	   ,Year
       ,Month
       ,Num_of_order
       ,Amount
       ,CASE WHEN class = 1 THEN 'A'
             WHEN class = 2 THEN 'B'
             WHEN class = 3 THEN 'C' END AS Class
FROM t3
order by Class;