SELECT
	To_Date("DateStart",'YYYY/MM/DD') as "Date"
    ,SUM("Spend") as "Spend"
    ,SUM("Impressions") as "Impressions"
    ,NVL(SUM("ActionsOffsiteConversion.fbPixelPurchase28dayClick"),0) + NVL(SUM("ActionsOffsiteConversion.fbPixelPurchase1dayView"),0) as "Sales"
    ,"CampaignName" as "Platform"
    ,SUM("CLicks") as "Clicks"
    ,"CampaignName" as "Site"
FROM rachel_zoe_age_gender_etl
GROUP BY "Date", "Platform", "Site"



SELECT	
	To_Date("date",'YYYY/MM/DD') as "Date"
    ,SUM("dbm cost usd") as "Spend"
    ,SUM("Impressions") as "Impressions"
    ,SUM("total conversions + cross-environment") as "Sales"
    ,"Activity" as "Platform"
    ,SUM("CLicks") as "Clicks"
    ,"site (dcm)" as "Site"
FROM copy_of_rachel_zoe_x_device_recurring_10_31_17

WHERE "Activity" = 'Zoe_Order Confirmation_Sale_1.27.17' AND "site (dcm)" = 'Google'

GROUP BY "Date" , "Platform",  "Site"



SELECT
	To_Date("date",'YYYY/MM/DD') as "Date"
     ,SUM("dbm cost usd") as "Spend"
     ,SUM("Impressions") as "Impressions"
    ,SUM("total revenue") as "Sales"
    ,"Activity" as "Platform"
    ,SUM("CLicks") as "Clicks"
    ,"site (dcm)" as "Site"
FROM copy_of_rachel_zoe_x_device_recurring_10_31_17

WHERE "site (dcm)" = 'Google'

GROUP BY "Date" , "Platform",  "Site"



SELECT
	To_Date("date",'YYYY/MM/DD') as "Date"
    ,SUM("dbm cost usd") as "Spend"
    ,SUM("Impressions")as "Impressions"
    ,SUM("total conversions + cross-environment") as "Sales"
    ,"Activity" as "Platform"
    ,SUM("CLicks") as "Clicks"
    ,"site (dcm)"  as "Site"
FROM copy_of_rachel_zoe_x_device_recurring_10_31_17 

WHERE "Activity" = 'Zoe_Order Confirmation_Sale_1.27.17' AND "site (dcm)" = 'Google Display Network'

GROUP BY "Date", "Platform", "Site"


SELECT 
	To_Date("date",'YYYY/MM/DD') as "Date"
    ,SUM("cost") AS "Spend"
    ,SUM("impressions") as "Impressions"
    , SUM("viewthroughconversions") as "Sales"
    ,"AdGroupName" as "Platform"
    ,SUM("CLicks") as "Clicks"
    ,"AdGroupName" as "Site"
FROM adwords_keyword_performance_recurring_03_01_17
WHERE "AccountDescriptiveName" = 'The Zoe Report Box of Style'
GROUP BY "Date", "Platform", "Site"


select * from transform_data_dcm_dbm_sales
union all
select * from transform_data_dcm_dbm_else

select * from transform_data_aw_final
union all
SELECT * from transform_data_dcm_final

select * from transform_data_aw_dcm
union all 
select * from transform_data_fb