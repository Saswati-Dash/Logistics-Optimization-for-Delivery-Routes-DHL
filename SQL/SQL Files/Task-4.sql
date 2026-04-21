-- Task 4: Warehouse Performance

-- Find the top 3 warehouses with the highest average delay in shipments dispatched.
SELECT 
    Warehouse_ID,
    AVG(Delay_Hours) AS Avg_Delay
FROM dhl_shipments
GROUP BY Warehouse_ID
ORDER BY Avg_Delay DESC
LIMIT 3;


-- Calculate total shipments vs delayed shipments for each warehouse
SELECT 
    Warehouse_ID,
    COUNT(*) AS Total_Shipments,
    COUNT(CASE WHEN Delay_Hours > 0 THEN 1 END) AS Delayed_Shipments
FROM dhl_shipments
GROUP BY Warehouse_ID;

-- Use CTEs to identify warehouses where average delay exceeds the global average delay.
WITH Warehouse_Avg AS (
    SELECT 
        Warehouse_ID,
        AVG(Delay_Hours) AS Avg_Delay
    FROM dhl_shipments
    GROUP BY Warehouse_ID
),
Global_Avg AS (
    SELECT AVG(Delay_Hours) AS Global_Delay
    FROM dhl_shipments
)

SELECT w.Warehouse_ID, w.Avg_Delay
FROM Warehouse_Avg w, Global_Avg g
WHERE w.Avg_Delay > g.Global_Delay;

-- Rank all warehouses based on on-time delivery percentage
SELECT 
    Warehouse_ID,
    (COUNT(CASE WHEN Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) 
    AS On_Time_Percentage,
    
    RANK() OVER (
        ORDER BY 
        (COUNT(CASE WHEN Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) DESC
    ) AS Warehouse_Rank

FROM dhl_shipments
GROUP BY Warehouse_ID;






































































