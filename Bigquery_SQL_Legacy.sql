#!GBQ - Impressions
SELECT
  DATE(TIMESTAMP((Event_Time/1000000)- 14400)) AS Date,
  Campaign_ID,
  Placement_ID,
  DBM_Insertion_Order_ID,
  SUM(DBM_Media_Cost_Advertiser_Currency) AS DBM_Media_Cost_Advertiser_Currency,
  SUM(DBM_Total_Media_Cost_Advertiser_Currency) AS DBM_Total_Media_Cost_Advertiser_Currency,
  SUM(DBM_CPM_Fee_1_Advertiser_Currency) AS DBM_CPM_Fee_1_Advertiser_Currency,
  COUNT(Event_Type) AS Impressions
FROM
  [sn-1992:test_pcln_dcm.p_impression_5199053]
WHERE
  Advertiser_ID = '5399022'
GROUP BY
  1,
  2,
  3,
  4

#!GBQ - Clicks
SELECT
  DATE(TIMESTAMP((Event_Time/1000000)- 14400)) AS Date,
  Campaign_ID,
  Placement_ID,
  COUNT(Event_Type) AS Clicks
FROM
  [sn-1992:test_pcln_dcm.p_click_5199053]
WHERE
  Advertiser_ID = '5399022'
GROUP BY
  1, 
  2,
  3

#!GBQ - Visits 1D
  SELECT
  DATE(TIMESTAMP((Event_Time/1000000)- 14400)) AS Date,
  Campaign_ID,
  Placement_ID,
 DBM_Insertion_Order_ID,
  COUNT(Event_Type) AS Clicks
FROM
  [sn-1992:test_pcln_dcm.p_click_5199053]
WHERE
  Advertiser_ID = '5399022'
GROUP BY
  1, 
  2,
  3,
  4


#!GBQ - PCLN Placement Match Table
SELECT Placement_ID, Placement, COUNT(Placement_ID) as Count 
FROM [sn-1992:test_pcln_dcm.p_match_table_placements_5199053]
GROuP BY 1, 2"