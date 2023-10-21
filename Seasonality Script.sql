-- Income by month AND finding seasonality --
SELECT  month
       ,SUM(num_of_orders) AS total_order -- grouping the monthes AND calculating the total revenue AND total ored per month 
       ,SUM(amount)        AS total_amount_per_month
       ,count (*)          AS num_of_customer
FROM
(
	SELECT  [client id]
	       ,COUNT( [order number] )as num_of_orders -- calculating the orders number per month for each customer 
	       ,SUM([Delivery amount])                       AS amount -- calculating the revenue number per month for each customer 
	       ,left(datename(month,([date of delivery])),3) AS month -- fetching the month of purchase for each customer 
	FROM
	(
		SELECT  *
		FROM [2020_data]
		UNION
		SELECT  *
		FROM [2019_Data]
	)m
	GROUP BY  [client id]
	         ,[date of delivery]
)x
GROUP BY  month
ORDER BY total_order DESC
         ,total_amount_per_month desc
         ,num_of_customer desc /*
FROM the analysis above we found that thier is seasonality IN the begining AND middel of the year which show a great number of purchases , revenue , AND customers/clients */