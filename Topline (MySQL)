SELECT
	`DateStart` as 'Date'
    ,SUM(`Spend`) as 'Spend'
    ,SUM(`Impressions`) as 'Impressions'
    ,ifnull(SUM(`ActionsOffsiteConversion.fbPixelPurchase28dayClick`),0) + ifnull(SUM(`ActionsOffsiteConversion.fbPixelPurchase1dayView`),0) as 'Sales'
    ,SUM(`CLicks`) as 'Clicks'
    ,`AccountName` as 'Platform'
    ,`AccountName` as 'Site'
FROM rachel_zoe_placement_device_etl
GROUP BY (`Date`)

SELECT
	`date` as 'Date'
    ,SUM(`revenue (adv currency)`) as 'Spend'
    ,SUM(`impressions`) as 'Impressions'
    ,SUM(`total conversions`) as 'Sales'
    ,`advertiser` as 'Platform'
    ,SUM(`CLicks`) as 'Clicks'
    ,`advertiser` as 'Site'    
FROM rachel_zoe_dbm_recurring_02_10_17
GROUP BY (`Date`)

SELECT 
	`date` AS 'Date'
    ,SUM(`cost`) AS 'Spend'
    ,SUM(`impressions`) as 'Impressions'
    ,SUM(`Conversions`) as 'Sales'
    ,`AdGroupName` as 'Platform'
    ,SUM(`CLicks`) as 'Clicks'
    ,`AdGroupName` as 'Site'
FROM adwords_keyword_performance_recurring_03_01_17
WHERE `AccountDescriptiveName` = "The Zoe Report Box of Style"
GROUP BY `date`;

select
	`date` as 'Date'
    ,SUM(`Total Conversions Cross Environment`) as 'Sales'
    ,`Activity` as 'Platform'
    ,SUM(`Total Revenue`) as 'Spend'
    ,SUM(`Total Revenue`) as 'Impressions'
    ,SUM(`CLicks`) as 'Clicks'
    ,`SITE(DCM)` as 'Site'
FROM rachel_zoe_x_device_recurring_2_10_17

WHERE `Activity` = 'Zoe_Order Confirmation_Sale_1.27.17' AND `SITE(DCM)` = 'Google'

GROUP BY (`Date`)


select
	`date` as 'Date'
    ,SUM(`Total Conversions Cross Environment`) as 'Sales'
    ,`Activity` as 'Platform'
    ,SUM(`Dbm Cost (usd)`) as 'Spend'
    ,SUM(`Impressions`) as 'Impressions'
    ,SUM(`CLicks`) as 'Clicks'
    ,`SITE(DCM)` as 'Site'
FROM rachel_zoe_x_device_recurring_2_10_17

WHERE `Activity` = 'Zoe_Order Confirmation_Sale_1.27.17' AND `SITE(DCM)` = 'Google Display Network'

GROUP BY (`Date`)


SELECT
	 b.`Spend`
    ,b.`Impressions`
    ,b.`Sales`
	,b.`Date`
    ,b.`Platform`
    ,b.`Clicks`
    ,b.`Site`
FROM transform_data_1_fb a

RIGHT JOIN transform_data_2_dbm b

ON a.`Date` = b.`Date`


union


SELECT 
	 a.`Spend`
    ,a.`Impressions`
    ,a.`Sales`
	,a.`Date`
    ,a.`Platform`
    ,a.`Clicks`
    ,a.`Site`
FROM transform_data_1_fb a

LEFT JOIN transform_data_2_dbm b

ON a.`Date` = b.`Date`

SELECT
	 b.`Spend`
    ,b.`Impressions`
    ,b.`Sales`
	,b.`Date`
    ,b.`Platform`
    ,b.`Clicks`
    ,b.`Site`
FROM transform_data_1 a

RIGHT JOIN transform_data_3_aw b

ON a.`Date` = b.`Date`

union

SELECT 
	 a.`Spend`
    ,a.`Impressions`
    ,a.`Sales`
	,a.`Date`
    ,a.`Platform`
    ,a.`Clicks`
    ,a.`Site`
FROM transform_data_1 a

LEFT JOIN transform_data_3_aw b

ON a.`Date` = b.`Date`

SELECT
	 b.`Spend`
    ,b.`Impressions`
    ,b.`Sales`
	,b.`Date`
    ,b.`Platform`
    ,b.`Clicks`
    ,b.`Site`
FROM transform_data_2 a

RIGHT JOIN transform_data_3_dcm_dbm b

ON a.`Date` = b.`Date`

union

SELECT 
	 a.`Spend`
    ,a.`Impressions`
    ,a.`Sales`
	,a.`Date`
    ,a.`Platform`
    ,a.`Clicks`
    ,a.`Site`
FROM transform_data_2 a

LEFT JOIN transform_data_3_dcm_dbm b

ON a.`Date` = b.`Date`

SELECT
	 b.`Spend`
    ,b.`Impressions`
    ,b.`Sales`
	,b.`Date`
    ,b.`Platform`
    ,b.`Clicks`
    ,b.`Site`
FROM transform_data_3 a

RIGHT JOIN transform_data_4_dcm_aw b

ON a.`Date` = b.`Date`

union

SELECT 
	 a.`Spend`
    ,a.`Impressions`
    ,a.`Sales`
	,a.`Date`
    ,a.`Platform`
    ,a.`Clicks`
    ,a.`Site`
FROM transform_data_3 a

LEFT JOIN transform_data_4_dcm_aw b

ON a.`Date` = b.`Date`
