--  Delivery Delay Analysis 

-- Calculate delivery delay (in hours) for each shipment using Delivery_Date – Pickup_Date

select * from dhl_shipments;
SELECT 
    Shipment_ID,
    Pickup_Date,
    Delivery_Date,
    TIMESTAMPDIFF(HOUR, Pickup_Date, Delivery_Date) AS Calculated_Delay_Hours
FROM dhl_shipments;



-- Find the Top 10 delayed routes based on average delay hours.

SELECT 
    Route_ID,
    AVG(Delay_Hours) AS Avg_Route_Delay
FROM dhl_shipments
GROUP BY Route_ID
ORDER BY Avg_Route_Delay DESC
LIMIT 10;

-- Use SQL window functions to rank shipments by delay within each Warehouse_ID
SELECT 
    Shipment_ID,
    Warehouse_ID,
    Delay_Hours,
    RANK() OVER (
        PARTITION BY Warehouse_ID 
        ORDER BY Delay_Hours DESC
    ) AS Delay_Rank
FROM dhl_shipments;

-- Identify the average delay per Delivery_Type (Express / Standard) to compare service-level efficiency.

SELECT 
    o.Delivery_Type,
    AVG(s.Delay_Hours) AS Avg_Delay
FROM dhl_shipments s
JOIN dhl_orders o
ON s.Order_ID = o.Order_ID
GROUP BY o.Delivery_Type;
































