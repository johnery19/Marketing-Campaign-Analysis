

1. How does the conversion rate vary by different channels (e.g., Facebook, Instagram)?
SELECT channel,
ROUND(AVG(Conversions / Impressions * 100),2) AS Coversion_Rate
FROM  dbo.Marketing_Campaign_Analysis
GROUP BY channel;

2. Which device type (Desktop, Mobile, Tablet) shows the highest click-through rate (CTR)?
SELECT device,
CAST(AVG(CAST(REPLACE(CTR, '%', '') AS DECIMAL(10, 4))) AS DECIMAL(10, 4)) AS Avg_CTR
FROM dbo.Marketing_Campaign_Analysis
GROUP BY device
ORDER BY Avg_CTR;

3. What is the relationship between impressions and conversion rate?
SELECT 
ROUND (Impressions,2) AS Impressions,
ROUND((Conversions / Impressions * 100),2) AS Coversion_Rate
FROM  dbo.Marketing_Campaign_Analysis;


4. How does the daily average cost per click (CPC) influence total conversions?
SELECT 
Daily_Average_CPC,
SUM(Conversions) AS Conversions
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Daily_Average_CPC;


5. Which city/location yields the highest total conversion value?
SELECT TOP 1 City_Location,
SUM(Conversions) AS Total_Conversions
FROM dbo.Marketing_Campaign_Analysis
GROUP BY City_Location;

6. What is the impact of ad type (e.g., Collection) on engagement metrics like likes, shares, and comments?
SELECT Ad,
AVG(Likes_Reactions) AS Like_reactions,
AVG(Shares) AS Shares,
AVG(Comments) AS Comments
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Ad;
SELECT *
FROM dbo.Marketing_Campaign_Analysis
7. How do different campaigns (e.g., Spring, Summer) compare in terms of ROI?
SELECT Campaign,
(SUM(Total_conversion_value_GBP) / SUM(Spend_GBP))AS ROI
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Campaign;
8. What is the correlation between ad spend and conversion value across different campaigns?
SELECT Campaign,
Spend_GBP,  
Total_conversion_value_GBP
FROM dbo.Marketing_Campaign_Analysis
9. How do conversion rates change over time within a specific campaign?

WITH conversion_rate AS (
    SELECT 
        Date,
        (SUM(Conversions) / SUM(Impressions) * 100) AS conversion_rate
    FROM dbo.Marketing_Campaign_Analysis
    WHERE Campaign = 'Spring'
    GROUP BY Date
)
SELECT *
FROM conversion_rate
ORDER BY Date;

10. What are the top-performing locations in terms of CTR?
SELECT TOP 1 City_location,
CAST(AVG(CAST(REPLACE(CTR,'%','') AS FLOAT )) AS FLOAT) AS Avg_CTR
FROM dbo.Marketing_Campaign_Analysis
GROUP BY City_location

11. How does the number of shares correlate with total conversions?
SELECT Shares,
SUM(Conversions) AS Conversions
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Shares;
12. What is the impact of comments on the overall success of a campaign?
SELECT Campaign,
AVG(Comments) AS comments
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Campaign;
13. Which campaign had the highest average daily spend?
SELECT TOP 1 Campaign,
AVG(Spend_GBP) AS avg_daily_spend
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Campaign;


14. How do likes (reactions) influence the conversion rate?
SELECT Likes_Reactions,
ROUND((SUM(Conversions) / SUM(Impressions) * 100),2) AS conversion_rate
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Likes_Reactions 
ORDER BY conversion_rate DESC;
15. What is the geographic distribution of high-converting ads?
SELECT City_Location, Ad, 
SUM(Conversions) AS total_conversion
FROM dbo.Marketing_Campaign_Analysis
GROUP BY City_Location, Ad
ORDER BY total_conversion DESC;
16. How does the frequency of clicks relate to the conversion value?
SELECT Clicks,
SUM(Total_Conversion_value_GBP)AS Total_conversion
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Clicks
ORDER BY Total_conversion DESC;

17. What is the relationship between the spend and total conversion value for each campaign?

SELECT Campaign,
SUM(Spend_GBP) AS Total_GBP,
SUM(Total_Conversion_value_GBP) AS Total_Conversion_value_GBP
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Campaign;


18. How do seasonal trends affect campaign performance metrics?
SELECT Campaign, 
CAST(AVG(CAST(REPLACE(CTR,'%','') AS FLOAT )) AS FLOAT) AS Avg_CTR, 
AVG(Conversions) AS AverageConversions,
AVG(Total_Conversion_value_GBP) AS AverageConversionValue
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Campaign;

19. Which ad achieved the highest conversion value per spend?
SELECT Ad, 
SUM(Total_Conversion_value_GBP)/ SUM(Spend_GBP) AS Conversion_Value_per_spend
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Ad
20. How does the number of impressions affect the daily average CPC?
SELECT Impressions,
Daily_average_CPC
FROM dbo.Marketing_Campaign_Analysis
21. What are the trends in user engagement (likes, shares, comments) over time?
WITH trends AS (
SELECT 
DATENAME(MONTH,Date) AS month_name,
AVG(Likes_Reactions) AS Likes,
AVG(Shares) AS Shares,
AVG(comments)AS comments
FROM dbo.Marketing_Campaign_Analysis
GROUP BY DATENAME(MONTH,Date)
) 
SELECT *
FROM trends;

22. How do different campaigns perform across various locations in terms of CPC?
SELECT City_Location,
AVG(Daily_Average_CPC)AS Avg_Daily_Average_CPC
FROM dbo.Marketing_Campaign_Analysis
GROUP BY City_Location;
23. What is the distribution of conversion values across different device types?
SELECT device,
AVG(Total_Conversion_value_GBP) AS Conversion_value
FROM dbo.Marketing_Campaign_Analysis
GROUP BY device
25. Which combination of channel and device yields the highest engagement metrics?
SELECT Channel, Device, 
AVG(Likes_Reactions) AS Likes,
AVG(Shares) AS Shares,
AVG(comments)AS comments
FROM dbo.Marketing_Campaign_Analysis
GROUP BY Channel, Device
ORDER BY Likes DESC, Shares DESC, comments DESC;
