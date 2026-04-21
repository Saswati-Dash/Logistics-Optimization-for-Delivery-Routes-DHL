-- Task 7: Advanced KPI Reporting 

-- Average Delivery Delay per Source_Country.

SELECT 
    r.Source_Country,
    AVG(s.Delay_Hours) AS Avg_Delay_Hours
FROM dhl_shipments s
JOIN dhl_routes r 
    ON s.Route_ID = r.Route_ID
GROUP BY r.Source_Country;

-- On-Time Delivery % = (Total On-Time Deliveries / Total Deliveries) * 100
SELECT 
    (COUNT(CASE WHEN Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) 
    AS On_Time_Delivery_Percentage
FROM dhl_shipments;

-- Average Delay (in hours) per Route_ID.

SELECT 
    Route_ID,
    AVG(Delay_Hours) AS Avg_Delay_Hours
FROM dhl_shipments
GROUP BY Route_ID;

-- Warehouse Utilization % = (Shipments_Handled / Capacity_per_day) * 100.
SELECT 
    w.Warehouse_ID,
    COUNT(s.Shipment_ID) AS Shipments_Handled,
    w.Capacity_per_day,
    
    (COUNT(s.Shipment_ID) * 100.0 / w.Capacity_per_day) 
    AS Warehouse_Utilization_Percentage

FROM dhl_shipments s
JOIN dhl_warehouses w 
    ON s.Warehouse_ID = w.Warehouse_ID
GROUP BY w.Warehouse_ID, w.Capacity_per_day;
























