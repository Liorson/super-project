-- summarizing the revenues and the costs, calculating the profits and displaying the advertisers.
select sum(q.Revenue)sum_revenue,
       sum(q.Cost) as sum_cost,
	   sum(q.Revenue)- sum(q.Cost) as sum_profit,
           q.Advertiser
from
-- lines 9-13 were to fully combine the two tables so I used that in the 'union all' function,
--didn't use the join command because there was no shared primary key that I can use to join them.       
	   (select *
             from [Analiza].[dbo].[data_auto_November]n
             union all
             select *
             from [Analiza].[dbo].[data_auto_October]o)q
-- grouping all the caulculatings under grop by clause per advertiser, 
-- and ordering the results by the profits.
group by q.Advertiser
order by sum_profit desc
