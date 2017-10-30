#Delete dates

DELETE FROM etl_pcln_floodlight_recursive_june_1st_2017_test
WHERE "date" IN (SELECT "Date" FROM pcln_2017_floodlight_report_recurring_app_install)


#Clean Dataset

delete from pcln_2017_floodlight_report_recurring_app_install 
where "date" LIKE '---'


#Union/ETL
SELECT 
"activity",
"campaign",
"campaign id",
"click-through conversions",
"creative",
"Date" :: Date,
"days since attributed interaction",
"placement",
"platform type",
"site (dcm)",
"total conversions",
"total revenue",
"view-through conversions",
REGEXP_REPLACE(REGEXP_REPLACE("placement",'[ ].*'),'[_].*') AS "placement_join"
FROM pcln_2017_floodlight_report_recurring_app_install

UNION ALL

SELECT
"activity",
"campaign",
"campaign id",
"click-through conversions",
"creative",
"Date" :: Date,
"days since attributed interaction",
"placement",
"platform type",
"site (dcm)",
"total conversions",
"total revenue",
"view-through conversions",
REGEXP_REPLACE(REGEXP_REPLACE("placement",'[ ].*'),'[_].*') AS "placement_join"
FROM etl_pcln_floodlight_recursive_june_1st_2017_test


#Creative Transforms 

SELECT
"activity",
"campaign",
"campaign id",
"click-through conversions",
CASE WHEN "creative" = 'Arnold Endless Airplane' THEN 'Arnold_Express_Deals_R1'
WHEN "creative" = 'Arnold Split Ticketing' THEN 'Arnold_Split_Ticketing_R1' ELSE "creative" END AS "creative",
"Date" :: Date,
"days since attributed interaction",
"placement",
"platform type",
"site (dcm)",
"total conversions",
"total revenue",
"view-through conversions",
"placement_join"
FROM combine_hist_and_new



#Audience Join

SELECT a.*, b.*
FROM transform_data_1 a
LEFT JOIN priceline_dbm_audience_lookup_googlesheet b
ON a."placement_join" = b."Code"



#Creative Join

SELECT a.*, b.*
FROM add_audience_lookup a
LEFT JOIN priceline_creative_lookup_googlesheet b
ON a."Creative" = b."DCM Creative"
