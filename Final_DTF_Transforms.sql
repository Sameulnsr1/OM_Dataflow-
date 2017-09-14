/* Act_1_Transform */
SELECT 
NULL :: INT as "Impressions",
NULL :: INT as "DBM Media Cost",
NULL :: INT as "DBM Revenue",
NULL :: INT as "DBM Total Media",
NULL :: INT as "DBM CPM Fee 1",
NULL :: INT as "DBM Media Fee 1",
NULL :: INT as "DBM Billable Cost",
"Activity ID" :: varchar as "Activity ID"
COUNT("Activity ID") as "1 Day", 
"Campaign ID" :: varchar as "cid", 
"Placement ID" :: varchar as "pid", 
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') as "Date_act" 
FROM dtf_2_0_activity_raw
WHERE "Advertiser ID" = 5399022 and "Conversion ID" in (1,2)
Group BY "cid", "pid", "Date_act", "Activity ID"



/* imp_transform */
SELECT 
COUNT("EVENT SUB-TYPE") as "Impressions",
SUM("DBM Media Cost (USD)") as "DBM Media Cost",
SUM("DBM Revenue (USD)") as "DBM Revenue",
SUM("DBM Total Media Cost (USD)") as "DBM Total Media",
SUM("DBM CPM Fee 1 (USD)") as "DBM CPM Fee 1",
SUM("DBM Media Fee 1 (USD)") as "DBM Media Fee 1",
SUM("DBM Billable Cost (USD)") as "DBM Billable Cost", 
NULL:: varchar as "Activity ID",
NUll :: INT as "1 day",
"Campaign ID" :: varchar, 
"Placement ID" :: varchar, 
Trunc(timestamp 'epoch' + (("Event Time"/1000000)-14400) * interval '1 second') :: Date as "Date"
FROM dtf_2_0_impressions_raw
WHERE "Advertiser ID" = 5399022
GROUP BY "Date", "Campaign ID", "Placement ID"


/* Click Transform */ 