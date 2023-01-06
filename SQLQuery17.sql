select sum(q.Revenue)sum_revenue,
       sum(q.Cost) as sum_cost,
	   sum(q.Revenue)- sum(q.Cost) as sum_profit,
           q.Advertiser
from
            (select *
             from [Analiza].[dbo].[data_auto_November]n
             union all
             select *
             from [Analiza].[dbo].[data_auto_October]o)q
group by q.Advertiser
order by sum_profit desc