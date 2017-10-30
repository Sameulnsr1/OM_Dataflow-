#Filter FLooodlight

SELECT
"activity" AS "activity",
"agency" AS "Agency",
"audience name" AS "Audience Name",
"campaign id" AS "Campaign_ID",
"campaign" AS "Campaign",
"click-through conversions" AS "Click-through Conversions",
NULL:: DECIMAL AS "click_rate",
NULL:: INT AS "clicks",
"code" AS "Code",
"creative length" AS "Creative Length",
"creative name" AS "Creative Name",
"creative vertical" AS "Creative Vertical",
"creative" AS "Creative",
"data type" AS "Data Type",
"date":: DATE AS "conversion_date",
"days since attributed interaction":: VARCHAR AS "Days Since Attributed Interaction",
"dcm creative" AS "DCM Creative",
"fb ad" AS "FB Ad",
NULL:: INT AS "impressions",
"placement" AS "Placement",
REGEXP_REPLACE(REGEXP_REPLACE("placement",'[ ].*'),'[_].*') AS "placement_join",
"platform type" AS "Platform_Type",
"site (dcm)" AS "Site__DCM_",
"tactic" AS "Tactic",
"test bucket" AS "Test Bucket",
"total conversions" AS "Total_Conversions",
"total revenue" AS "Conversion_Value",
"view-through conversions" AS "View-through Conversions",
NULL:: INT AS "active_view__eligible_impressions",
NULL:: INT AS "active_view__measurable_impressions",
NULL:: INT AS "active_view__viewable_impressions",
DATE(DATEADD(days,("days since attributed interaction":: INT *-1), "date":: DATE)):: DATE as "Date"
FROM etl_pcln_floodlight_recursive_june_1st_2017_test
WHERE "activity" IN ('Air Retail and NYOP Search Results Page','Vacation Package Search Results','Confirmation Page Counter Standard','Hotel Retail, Express Deals or NYOP Search Results','OceanMedia_Site Visit_Unique_Counter','Product Search (All Products)_Standard','Product Search (All Products)_Unique','Rental Car Retail or NYOP Search Results','App Installs - Android','App Installs - iOS')

#Filter Impressions

SELECT 
'Impression' AS  "activity",
"agency",
"audience name",
"campaign_id",
"campaign",
NULL:: INT AS "click-through conversions",
"click_rate",
"clicks",
"code",
"creative length",
"creative name",
"creative vertical",
"creative",
"data type",
"date":: DATE AS "conversion_date",
'0' AS "days since attributed interaction",
"dcm creative",
"fb ad",
"impressions",
"placement",
"placement_join",
"platform_type",
"site__dcm_",
"tactic",
"test bucket",
"total_conversions",
NULL:: INT AS "Conversion_Value",
NULL:: INT AS "view-through conversions",
"active_view__eligible_impressions",
"active_view__measurable_impressions",
"active_view__viewable_impressions",
"Date":: DATE AS "Date"
FROM pcln_impressions_recursive_june_1st_2017
WHERE "campaign" <> 'Grand Total:'


#Combine

SELECT *
FROM filter_floodlight

UNION ALL

SELECT *
FROM impressions

#Select Columns

SELECT 
"activity",
"agency",
"audience name",
"campaign_id",
"campaign",
"click-through conversions",
"click_rate",
"clicks",
"code",
"creative length",
"creative name",
"creative vertical",
"creative",
"data type",
NVL("days since attributed interaction",'0') AS "days since attributed interaction",
"dcm creative",
NVL("impressions",0) as "impressions",
"placement",
"platform_type",
"site__dcm_",
"tactic",
"test bucket",
"total_conversions",
"conversion_value",
"view-through conversions",
"active_view__eligible_impressions",
"active_view__measurable_impressions",
"active_view__viewable_impressions",
"date"
FROM combine