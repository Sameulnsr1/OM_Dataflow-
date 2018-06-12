/*imp_transform: Select Statements for the Impressions Report (Aggregate) */

SELECT 
COUNT("EVENT SUB-TYPE") as "Impressions",
SUM("DBM Media Cost (USD)") as "DBM Media Cost",
SUM("DBM Revenue (USD)") as "DBM Revenue",
SUM("DBM Total Media Cost (USD)") as "DBM Total Media",
SUM("DBM CPM Fee 1 (USD)") as "DBM CPM Fee 1",
SUM("DBM Media Fee 1 (USD)") as "DBM Media Fee 1",
SUM("DBM Billable Cost (USD)") as "DBM Billable Cost", 
"Campaign ID" :: varchar, 
"Placement ID" :: varchar, 
"Operating System ID" :: varchar,
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') :: Date as "Date" 
FROM dtf_2_0_impressions_raw
WHERE "Advertiser ID" = 5399022 and "Campaign ID" IN (10904256, 10926167)
GROUP BY "Date", "Campaign ID", "Placement ID", "Operating System ID"



/* act_transform: Select Statements for the Acivities Report (Aggregate)*/

SELECT 
COUNT("EVENT SUB-TYPE") as "Visits 1D", 
"Campaign ID" :: varchar as "cid", 
"Placement ID" :: varchar as "pid", 
"Operating System ID" :: varchar, 
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') as "Date_act" 
FROM dtf_2_0_activity_raw
WHERE "Advertiser ID" = 5399022 and "Campaign ID" IN (10904256, 10926167) and "Activity ID" = 3170805 and (("Event Time"/1000000)-("Interaction Time"/1000000)) < 86401 and "Conversion ID" IN (1,2)
Group BY "cid", "pid", "Date_act", "Operating System ID"


/* merge1_transform: Join aggregated activities report on aggregated impressions report for a 1 day RR*/

SELECT a.*, b."Visits 1D"
FROM imp_transform a
LEFT JOIN act_transform b
ON a."Placement ID" = b."pid" AND a."Date" = b."Date_act" AND a."Campaign ID" = b."cid" and a."Operating System ID" = b."Operating System ID"




/* act7_transform: Aggreage Activities report based on a 7 day RR (change what Event Time - Interaction Time is less than)*/

SELECT 
COUNT("EVENT SUB-TYPE") as "Visits 7D", 
"Campaign ID" :: varchar as "cid", 
"Placement ID" :: varchar as "pid", 
"Operating System ID" :: varchar,
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') as "Date_act" 
FROM dtf_2_0_activity_raw
WHERE "Advertiser ID" = 5399022 and "Campaign ID" IN (10904256, 10926167) and "Activity ID" = 3170805 and (("Event Time"/1000000)-("Interaction Time"/1000000)) < 604801 and "Conversion ID" IN (1,2)
Group BY "cid", "pid", "Date_act", "Operating System ID"

/* ios_appinstalls_data: App Install Campaign (Change Activity ID Column*/

SELECT 
COUNT("EVENT SUB-TYPE") as "App Installs - iOS 1D", 
"Campaign ID" :: varchar as "cid", 
"Placement ID" :: varchar as "pid", 
"Operating System ID" :: varchar, 
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') as "Date_act" 
FROM dtf_2_0_activity_raw
WHERE "Advertiser ID" = 5399022 and "Campaign ID" IN (10904256, 10926167) and "Activity ID" = 6094757 and "Conversion ID" IN (1,2)
Group BY "cid", "pid", "Date_act", "Operating System ID"


/* merge2_transform: Add 7 day calculation within the merge1_transform that has combined impressions and activites report*/

SELECT a.*, b."Visits 7D"
FROM merge1_transform a
LEFT JOIN act7_transform b
ON a."Placement ID" = b."pid" AND a."Date" = b."Date_act" AND a."Campaign ID" = b."cid" and a."Operating System ID" = b."Operating System ID"


/* merge3_transform: Add new campaign within the above */

SELECT a.*, b."App Installs - iOS 1D"
FROM merge2_transform a
LEFT JOIN ios_appinstalls_data b
ON a."Placement ID" = b."pid" AND a."Date" = b."Date_act" AND a."Campaign ID" = b."cid" and a."Operating System ID" = b."Operating System ID"


/* android_appinstalls_data:*/

SELECT 
COUNT("EVENT SUB-TYPE") as "App Installs - Android 1D", 
"Campaign ID" :: varchar as "cid", 
"Placement ID" :: varchar as "pid", 
"Operating System ID" :: varchar, 
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') as "Date_act" 
FROM dtf_2_0_activity_raw
WHERE "Advertiser ID" = 5399022 and "Campaign ID" IN (10904256, 10926167) and "Activity ID" = 6089102 and "Conversion ID" IN (1,2)
Group BY "cid", "pid", "Date_act", "Operating System ID"


/*merge4_transform*/

SELECT a.*, b."App Installs - Android 1D"
FROM merge3_transform a
LEFT JOIN android_appinstalls_data b
ON a."Placement ID" = b."pid" AND a."Date" = b."Date_act" AND a."Campaign ID" = b."cid" and a."Operating System ID" = b."Operating System ID"


/*pid_lookup_transform*/

Select a.*, b."Placement"
FROM merge4_transform a
LEFT JOIN dtf_pcln_placementlookup b 
ON a."Placement ID" = b."Placement ID"

/*regexp_transform*/

Select *, REGEXP_REPLACE(REGEXP_REPLACE("placement",'[ ].*'),'[_].*') AS "placement_join"
FROM pid_lookup_transform


/*Audience Lookup and Final Transformation*/

SELECT 
a."impressions",
a."campaign id",
a."placement id",
a."date",
a."visits 1d",
a."placement", 
a."visits 7d",
a."Operating System ID",
a."DBM Media Cost",
a."DBM Revenue",
a."DBM Total Media",
a."DBM CPM Fee 1",
a."DBM Media Fee 1",
a."DBM Billable Cost", 
a."App Installs - iOS 1D",
a."App Installs - Android 1D",
b.*
FROM regexp_transform a
LEFT JOIN priceline_dbm_audience_lookup_googlesheet b
ON a."placement_join" = b."code"
