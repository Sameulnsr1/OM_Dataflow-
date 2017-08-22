/* Delete Extra Data */

delete from rachel_zoe_dbm_90_day where 
date like '' or 
date like'%Report Time:%'or
date like'%Date Range:%' or
date like'%Group By:%' or
date like'%Filter by Advertiser%' or
date like'%Filter by Partner%' or
date is null



/*Select Distinct Date*/
Select TO_DATE ("date", 'YYYY/MM/DD') as "Date"
,"advertiser"
,"advertiser id"
,"advertiser status"
,"advertiser integration code"
,"insertion order"
,"insertion order id"
,"app/url id"
,"app/url excluded"
,"time to conversion (minutes)"
,"creative type"
,"ad position"
,"exchange"
,"exchange id"
,ISNULL(CONVERT(varchar(10),"dma code"),'') as "dma code"
,"dma name"
,"browser"
,"_batch_last_run_" from rachel_zoe_dbm_recurring_02_10_17
Where date not in (Select distinct(date) from transform_data_1)
