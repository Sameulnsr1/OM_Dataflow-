/* Delete Misc. Rows */

delete from domo_rachel_zoe_x_device_recurring_2_10_17 where `C2` = ' '


delete from transform_data_1 where `Date` = 'Date' 
OR `Date` = '' 
OR `Date` = 'Report Fields'
OR `Date` = 'Date/Time Generated'
OR `Date` = 'Report Time Zone' 
OR `Date` = 'Account ID' 
OR `Date` = 'Date Range' 
OR `Date` = 'Advertiser' 
OR `Date` = 'MRC Accredited Metrics'
OR `Date` = 'Floodlight Configuration'
OR `Date` = 'Grand Total:'


/* Change Column Names */

select 
`domo_rachel_zoe_x_device_recurring_2_10_17` as `Date`
,`C1` as `Advertiser`
,`C2` as `Campaign`
,`C3` as `Site_(DCM)`
,`C4` as `Placement`
,`C5` as `Activity`
,`C6` as `Total_Conversions`
,`C7` as `Total_Conversions_Cross_Environment`
,`C8` as `Total_Revenue`
,`C9` as `Total_Revenue_Cross_Environment`
,`C10` as `Click_Through_Conversions`
,`C11` as `Click_Through_Conversions_Cross_Environment`
,`C12` as `Click_through_Revenue`
,`C13` as `Click_through_Revenue_Cross_Environment`
,`C14` as `View_through_Conversions`
,`C15` as `View_through_Conversions_Cross_Environment`
,`C16` as `View_through_Revenue`
,`C17` as `View_through_Revenue_Cross_Environment`
,`C18` as `Impressions`
,`C19` as `DBM_Cost_(Account Currency)`
,`C20` as `DBM_Cost_USD`
,`C21` as `Clicks`

from domo_rachel_zoe_x_device_recurring_2_10_17




/* Tranform Column Types */

Select
	 `Advertiser` as 'Advertiser'
	,`Campaign` as 'Campaign'
	,`Site_(DCM)` as 'Site(DCM)'
	,`Placement` as 'Placement'
	,`Activity` as 'Activity'
	,CAST(`Date` as date) as 'Date'
	,CAST(`Total_Conversions` as decimal) as 'Total Conversions'
	,CAST(`Total_Conversions_Cross_Environment` as decimal) as 'Total Conversions Cross Environment'
	,CAST(`Total_Revenue` as decimal) as 'Total Revenue'
	,CAST(`Total_Revenue_Cross_Environment` as decimal) as 'Total Revenue Cross Environment'
	,CAST(`Click_Through_Conversions` as decimal) as 'Click Through Conversions'
	,CAST(`Click_through_Revenue` as decimal) as 'Click Through Revenue'
	,CAST(`Click_through_Revenue_Cross_Environment` as decimal) as 'Click Through Revenue Cross Environment'
	,CAST(`View_through_Conversions` as decimal)  as 'View Through'
	,CAST(`View_through_Conversions_Cross_Environment` as decimal) 'View Through Conversions Cross Environment'
	,CAST(`View_through_Revenue` as decimal) as 'View Through Revenue'
	,CAST(`View_through_Revenue_Cross_Environment` as decimal) as 'View Through Revenue Cross Environment'
	,CAST(`Impressions` as decimal) as 'Impressions'
	,CAST(`DBM_Cost_(Account Currency)`as decimal) as 'DBM Cost (Account Currency)'
	,CAST(`DBM_Cost_USD`as decimal) as 'Dbm Cost (USD)'
    ,CAST(`CLicks` as decimal) as 'Clicks'
From transform_data_1
