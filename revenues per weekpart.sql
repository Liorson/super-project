--displaying the new columm under the name weekdays and summing the revenues for the
-- months October-November.
select sum(q2.Revenue)sum_revenue, q2.weekday
from
--creating a new columm thats represents monday-thusday=middle_week and
--friday-sanday=end_week,adding all the columms from the two tables i united in the inner query.
    (select case
            when q.[Day of Week] in ( 'Monday','Tuesday',
			'Wednesday','Thursday','Friday') then 'middle_week'
	        else 'end_week'
	        end weekday,q.*
			from
--lines 15-19 were to fully combine the two tables so I used that in the 'union all' function,
--didn't use the join command because there was no shared primary key that I can use to join them.
            (select *
             from [Analiza].[dbo].[data_auto_November]n
             union all
             select *
             from [Analiza].[dbo].[data_auto_October]o)q)q2
group by q2.weekday
--grouping all the subquery by weekday columm

















































































































