-- Task 3: Route Optimization Insights

-- Average transit time (in hours) across all shipments
SELECT 
    Route_ID,
    AVG(TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date)) AS Avg_Transit_Time
FROM dhl_shipments
GROUP BY Route_ID;

-- Average delay (in hours) per route.
SELECT 
    Route_ID,
    AVG(Delay_Hours) AS Avg_Delay
FROM dhl_shipments
GROUP BY Route_ID;


-- Distance-to-time efficiency ratio = Distance_KM / Avg_Transit_Time_Hours
SELECT 
    r.Route_ID,
    r.Distance_KM,
    r.Avg_Transit_Time_Hours,
    (r.Distance_KM / r.Avg_Transit_Time_Hours) AS Efficiency_Ratio
FROM dhl_routes r;

-- Identify 3 routes with the worst efficiency ratio (lowest distance-to-time)

SELECT 
    Route_ID,
    (Distance_KM / Avg_Transit_Time_Hours) AS Efficiency_Ratio
FROM dhl_routes
ORDER BY Efficiency_Ratio ASC
LIMIT 3;

-- Find routes with >20% of shipments delayed beyond expected transit time.
SELECT 
    s.Route_ID,
    COUNT(*) AS Total_Shipments,
    SUM(
        CASE 
            WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date) 
                 > r.Avg_Transit_Time_Hours 
            THEN 1 ELSE 0 
        END
    ) AS Delayed_Shipments,
    
    (SUM(
        CASE 
            WHEN TIMESTAMPDIFF(HOUR, s.Pickup_Date, s.Delivery_Date) 
                 > r.Avg_Transit_Time_Hours 
            THEN 1 ELSE 0 
        END
    ) * 100.0 / COUNT(*)) AS Delay_Percentage

FROM dhl_shipments s
JOIN dhl_routes r ON s.Route_ID = r.Route_ID
GROUP BY s.Route_ID
HAVING Delay_Percentage > 20;

-- Recommend potential routes or hub pairs for optimization.
-- From above results, you recommend:
-- Routes with:
--     Low efficiency ratio
--     High delay percentage
-- These routes need:
--      Better route planning
--      Better warehouse handling
--      More delivery agents




















































