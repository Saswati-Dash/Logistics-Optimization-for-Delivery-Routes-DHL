-- Task 6: Shipment Tracking Analytics

-- For each shipment, display the latest status (Delivered, In Transit, or Returned) along with the latest Delivery_Date.
SELECT 
    Shipment_ID,
    Delivery_Status,
    Delivery_Date
FROM dhl_shipments;

-- Identify routes where the majority of shipments are still “In Transit” or “Returned”
SELECT 
    Route_ID,
    COUNT(*) AS Total_Shipments,
    
    COUNT(CASE 
            WHEN Delivery_Status IN ('In Transit', 'Returned') 
          THEN 1 
         END) AS Problem_Shipments
         
FROM dhl_shipments
GROUP BY Route_ID
HAVING (Problem_Shipments * 100 / Total_Shipments) > 50;


-- Find the most frequent delay reasons (if available in delay-related columns or flags).

SELECT 
    Delay_Reason,
    COUNT(*) AS Frequency
FROM dhl_shipments
GROUP BY Delay_Reason
ORDER BY Frequency DESC;

-- Identify orders with exceptionally high delay (>120 hours) to investigate potential bottlenecks.
SELECT 
    Shipment_ID,
    Order_ID,
    Route_ID,
    Delay_Hours
FROM dhl_shipments
WHERE Delay_Hours > 120;


























































