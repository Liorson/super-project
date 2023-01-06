select sum(q2.Revenue)sum_revenue, q2.weekday
from
    (select case
            when q.[Day of Week] in ( 'Monday','Tuesday',
			'Wednesday','Thursday','Friday') then 'middle_week'
	        else 'end_week'
	        end weekday,q.*
       from
            (select *
             from [Analiza].[dbo].[data_auto_November]n
             union all
             select *
             from [Analiza].[dbo].[data_auto_October]o)q)q2
group by q2.weekday
