create database Project;
use Project;

-- Task 1: Data Cleaning & Preparation

-- Identify and delete duplicate Order_ID or Shipment_ID records.

select * from  dhl_orders;
-- Check duplicates in Orders
SELECT Order_ID, COUNT(*) AS duplicate_count
FROM dhl_orders
GROUP BY Order_ID
HAVING COUNT(*) > 1;

select * from  dhl_shipments;

-- Check duplicates in Shipments
SELECT Shipment_ID, COUNT(*) AS duplicate_count
FROM dhl_shipments
GROUP BY Shipment_ID
HAVING COUNT(*) > 1;

-- Replace null or missing Delay_Hours values in the Shipments Table with the average delay for that Route_ID
-- See NULL values
SELECT Shipment_ID, Route_ID, Delay_Hours
FROM dhl_shipments
WHERE Delay_Hours IS NULL;

-- Here their is no null or missing value

-- Convert all date columns (Order_Date, Pickup_Date, Delivery_Date) into YYYY-MM-DD HH:MM:SS format using SQL date functions.
-- Orders
DESCRIBE dhl_orders;
SELECT Order_Date FROM dhl_orders LIMIT 5; -- See the real date format in record

ALTER TABLE dhl_orders
MODIFY Order_Date DATETIME; -- only to change the data format  

-- Shipment
describe dhl_shipments;
SELECT Pickup_Date, Delivery_Date FROM dhl_shipments LIMIT 5;

ALTER TABLE dhl_shipments
MODIFY Pickup_Date DATETIME,
MODIFY Delivery_Date DATETIME;

SELECT  Expected_Delivery_Date FROM dhl_shipments LIMIT 5;

ALTER TABLE dhl_shipments
MODIFY Expected_Delivery_Date DATETIME;

-- Ensure that no Delivery_Date occurs before Pickup_Date (flag such records).
SELECT Shipment_ID, Pickup_Date, Delivery_Date
FROM dhl_shipments
WHERE Delivery_Date < Pickup_Date;

-- no such records

-- Validate referential integrity between Orders, Routes, Warehouses, and Shipments.
SELECT s.Shipment_ID
FROM dhl_shipments s
LEFT JOIN dhl_orders o
ON s.Order_ID = o.Order_ID
WHERE o.Order_ID IS NULL;

SELECT s.Shipment_ID
FROM dhl_shipments s
LEFT JOIN dhl_routes r
ON s.Route_ID = r.Route_ID
WHERE r.Route_ID IS NULL;

SELECT s.Shipment_ID
FROM dhl_shipments s
LEFT JOIN dhl_warehouses w
ON s.Warehouse_ID = w.Warehouse_ID
WHERE w.Warehouse_ID IS NULL;

SELECT s.Shipment_ID
FROM dhl_shipments s
LEFT JOIN dhl_delivery_agents a
ON s.Agent_ID = a.Agent_ID
WHERE a.Agent_ID IS NULL;
























