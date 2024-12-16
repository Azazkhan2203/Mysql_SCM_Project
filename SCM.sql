SELECT * FROM scm_project.scm;
-- 1. Retrieve all companies with high supply chain agility
SELECT Company_Name, Supply_Chain_Agility
FROM scm_project.scm
WHERE Supply_Chain_Agility = 'High';

-- 2. Find companies with an operational efficiency score above 85.
SELECT Company_Name, Operational_Efficiency_Score
FROM scm_project.scm
WHERE Operational_Efficiency_Score > 85;

-- 3. List companies with inventory turnover ratios below 6.
SELECT Company_Name, Inventory_Turnover_Ratio
FROM scm_project.scm
WHERE Inventory_Turnover_Ratio < 6;

-- 4. Get the average lead time across all companies.
SELECT AVG(LeadTime_Days) AS Average_Lead_Time
FROM scm_project.scm;

-- 5. Find companies using "Blockchain" technology.
SELECT Company_Name, Technology_Utilized
FROM scm_project.scm
WHERE Technology_Utilized LIKE '%Blockchain%';

-- 6. Rank companies by their revenue growth rate.
SELECT Company_Name, Revenue_Growth_Rate_out_of_15
FROM scm_project.scm
ORDER BY Revenue_Growth_Rate_out_of_15 DESC

-- 7. Count companies with sustainability practices marked as "Advanced".
SELECT COUNT(*) AS Advanced_Sustainability_Count
FROM scm_project.scm
WHERE Sustainability_Practices = 'Advanced';

-- 8. Identify companies with supply chain risk above 10%.
SELECT Company_Name, Supply_Chain_Risk_Percentage
FROM scm_project.scm
WHERE Supply_Chain_Risk_Percentage > 10;

-- 9. Retrieve companies with high supplier collaboration levels.
SELECT Company_Name, Supplier_Collaboration_Level
FROM scm_project.scm
WHERE Supplier_Collaboration_Level = 'High';

-- 10. Find the maximum order fulfillment rate across all companies.
SELECT MAX(Order_Fulfillment_Rate_Percentage) AS Max_Order_Fulfillment_Rate
FROM scm_project.scm;

-- 11. List companies with transportation cost efficiency below 70%.
SELECT Company_Name, Transportation_Cost_Efficiency_Percentage
FROM scm_project.scm
WHERE Transportation_Cost_Efficiency_Percentage < 88;

-- 12. Retrieve companies with low customer satisfaction (below 85%).
SELECT Company_Name, Customer_Satisfaction_Percentage
FROM scm_project.scm
WHERE Customer_Satisfaction_Percentage < 90;

-- 13. Calculate the average environmental impact score.
SELECT AVG(Environmental_Impact_Score) AS Avg_Environmental_Impact
FROM scm_project.scm;

-- 14. Find companies with a high supply chain resilience score.
SELECT Company_Name, Supply_Chain_Resilience_Score
FROM scm_project.scm
WHERE Supply_Chain_Resilience_Score > 85;

-- 15. Retrieve the supplier count for companies with high complexity index.
SELECT Company_Name, Supplier_Count
FROM scm_project.scm
WHERE Supply_Chain_Complexity_Index = 'High';

-- 16. List companies whose cost of goods sold (COGS) exceeds $500B.
SELECT Company_Name, Cost_of_Goods_Sold_COGS
FROM scm_project.scm
WHERE CAST(REPLACE(Cost_of_Goods_Sold_COGS, '$', '') AS FLOAT) > 500;

-- 17. Find companies with lead time variability exceeding 10 days.
SELECT Company_Name, Supplier_Lead_Time_Variability_DAYS
FROM scm_project.scm
WHERE Supplier_Lead_Time_Variability_DAYS > 4;

-- 18. Get companies with inventory accuracy below 90%.
SELECT Company_Name, Inventory_Accuracy_Percentage
FROM scm_project.scm
WHERE Inventory_Accuracy_Percentage < 97;

-- 19. Count companies with medium supply chain integration levels.
SELECT COUNT(*) AS Medium_Integration_Companies
FROM scm_project.scm
WHERE Supply_Chain_Integration_Level = 'Medium';

-- 20. Rank companies based on their supplier relationship score.
SELECT Company_Name, Supplier_Relationship_Score
FROM scm_project.scm
ORDER BY Supplier_Relationship_Score DESC;

-- 21. Find companies using both ERP and AI technologies.
SELECT Company_Name, Technology_Utilized
FROM scm_project.scm
WHERE Technology_Utilized LIKE '%ERP%' AND Technology_Utilized LIKE '%AI%';

-- 22. Retrieve companies with supply chain risk below 5%.
SELECT Company_Name, Supply_Chain_Risk_Percentage
FROM scm_project.scm
WHERE Supply_Chain_Risk_Percentage < 5;

-- 23. Find companies with supply chain practices labeled as "Agile SCM".
SELECT Company_Name, SCM_Practices
FROM scm_project.scm
WHERE SCM_Practices = 'Agile SCM';

-- 24. Calculate the total number of suppliers across all companies.
SELECT SUM(Supplier_Count) AS Total_Suppliers
FROM scm_project.scm;

-- 25. Get companies with resilience and efficiency scores both above 85.
SELECT Company_Name, Supply_Chain_Resilience_Score, Operational_Efficiency_Score
FROM scm_project.scm
WHERE Supply_Chain_Resilience_Score > 85 AND Operational_Efficiency_Score > 85;

/* 26. Identify companies where the supply chain risk is high (above 10%) but the operational efficiency is also high (above 80),
and calculate the average inventory turnover ratio for these companies.*/
SELECT AVG(Inventory_Turnover_Ratio) AS Avg_Inventory_Turnover
FROM scm_project.scm
WHERE Supply_Chain_Risk_Percentage > 10 AND Operational_Efficiency_Score > 80;

/* 27. For each type of supply chain practice, calculate the total number of suppliers and the average lead time, 
sorted by the highest total number of suppliers. */
SELECT SCM_Practices, 
       SUM(Supplier_Count) AS Total_Suppliers, 
       AVG(LeadTime_Days) AS Avg_Lead_Time
FROM scm_project.scm
GROUP BY SCM_Practices
ORDER BY Total_Suppliers DESC;

/* 28. Find the top 3 companies with the highest revenue growth rate and their corresponding sustainability practices 
and environmental impact scores. */
SELECT Company_Name, 
       Revenue_Growth_Rate_out_of_15, 
       Sustainability_Practices, 
       Environmental_Impact_Score
FROM scm_project.scm
ORDER BY Revenue_Growth_Rate_out_of_15 DESC
LIMIT 3;

/* 29. Identify companies with above-average order fulfillment rates and below-average supply chain risk, 
grouped by their supply chain agility. */
WITH Averages AS (
    SELECT AVG(Order_Fulfillment_Rate_Percentage) AS Avg_Order_Fulfillment,
           AVG(Supply_Chain_Risk_Percentage) AS Avg_Supply_Chain_Risk
    FROM scm_project.scm)
SELECT Supply_Chain_Agility, 
       COUNT(Company_Name) AS Company_Count
FROM scm_project.scm, Averages
WHERE Order_Fulfillment_Rate_Percentage> Avg_Order_Fulfillment 
  AND Supply_Chain_Risk_Percentage < Avg_Supply_Chain_Risk
GROUP BY Supply_Chain_Agility;

/* 30. Determine the percentage of companies using blockchain technology whose inventory turnover ratio is above 7.*/
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM scm_project.scm WHERE Technology_Utilized LIKE '%Blockchain%')) AS Percentage
FROM scm_project.scm
WHERE Technology_Utilized LIKE '%Blockchain%' AND Inventory_Turnover_Ratio > 7;

/* 31. Find the company with the most consistent supplier lead time (lowest variability) and its respective operational
 efficiency score and cost of goods sold. */
 SELECT Company_Name, 
       Supplier_Lead_Time_Variability_DAYS, 
       Operational_Efficiency_Score, 
       Cost_of_Goods_Sold_COGS
FROM scm_project.scm
ORDER BY Supplier_Lead_Time_Variability_DAYS ASC
LIMIT 1;

/* 32. Calculate the total revenue growth rate for companies with advanced sustainability practices 
and medium supply chain integration levels.*/
SELECT SUM(Revenue_Growth_Rate_out_of_15) AS Total_Revenue_Growth
FROM scm_project.scm
WHERE Sustainability_Practices = 'Advanced' 
  AND Supply_Chain_Integration_Level = 'Medium';
  
  /* 33. Group companies by their supply chain complexity index and calculate the average customer satisfaction and 
  transportation cost efficiency for each group.*/
  SELECT Supply_Chain_Complexity_Index, 
       AVG(Customer_Satisfaction_Percentage) AS Avg_Customer_Satisfaction, 
       AVG(Transportation_Cost_Efficiency_Percentage) AS Avg_Transportation_Efficiency
FROM scm_project.scm
GROUP BY Supply_Chain_Complexity_Index;

/* 34. Find companies with a combination of the following criteria:
Revenue growth rate greater than 10.
Environmental impact score below 75.
High supplier collaboration level.*/
SELECT Company_Name, 
       Revenue_Growth_Rate_out_of_15, 
       Environmental_Impact_Score, 
       Supplier_Collaboration_Level
FROM scm_project.scm
WHERE Revenue_Growth_Rate_out_of_15 > 10 
  AND Environmental_Impact_Score < 75 
  AND Supplier_Collaboration_Level = 'High';
  
  /* 35. Calculate the total operational efficiency score for companies with both high supply chain 
  agility and high supply chain integration levels, grouped by SCM practices.*/
  SELECT SCM_Practices, 
       SUM(Operational_Efficiency_Score) AS Total_Operational_Efficiency
FROM scm_project.scm
WHERE Supply_Chain_Agility = 'High' 
  AND Supply_Chain_Integration_Level = 'High'
GROUP BY SCM_Practices;

/* 36. Determine which companies have an above-average supply chain resilience score and a below-average 
cost of goods sold (COGS).*/
WITH Averages AS (
    SELECT AVG(Supply_Chain_Resilience_Score) AS Avg_Resilience,
           AVG(CAST(REPLACE(Cost_of_Goods_Sold_COGS, '$', '') AS FLOAT)) AS Avg_COGS
    FROM scm_project.scm
)
SELECT Company_Name, 
       Supply_Chain_Resilience_Score, 
       Cost_of_Goods_Sold_COGS
FROM scm_project.scm, Averages
WHERE Supply_Chain_Resilience_Score > Avg_Resilience 
  AND CAST(REPLACE(Cost_of_Goods_Sold_COGS, '$', '') AS FLOAT) < Avg_COGS;
  
  /* 37. Identify the top 3 companies with the best balance between customer satisfaction and order fulfillment rates.*/
  SELECT Company_Name, 
       (Customer_Satisfaction_Percentage + Order_Fulfillment_Rate_Percentage) / 2 AS Satisfaction_Fulfillment_Balance
FROM scm_project.scm
ORDER BY Satisfaction_Fulfillment_Balance DESC
LIMIT 3;




  






























--









