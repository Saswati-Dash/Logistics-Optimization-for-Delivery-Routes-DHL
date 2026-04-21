-- Task 5: Delivery Agent Performance

-- Rank delivery agents (per route) by on-time delivery percentage

SELECT 
    s.Route_ID,
    s.Agent_ID,
    
    (COUNT(CASE WHEN s.Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) 
    AS On_Time_Percentage,

    RANK() OVER (
        PARTITION BY s.Route_ID
        ORDER BY 
        (COUNT(CASE WHEN s.Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) DESC
    ) AS Agent_Rank

FROM dhl_shipments s
GROUP BY s.Route_ID, s.Agent_ID;


-- Find agents whose on-time % is below 85%.
SELECT *
FROM (
    SELECT 
        s.Agent_ID,
        (COUNT(CASE WHEN s.Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) 
        AS On_Time_Percentage
    FROM dhl_shipments s
    GROUP BY s.Agent_ID
) AS Agent_Performance
WHERE On_Time_Percentage < 85;

-- Compare the average rating and experience (in years) of the top 5 vs bottom 5 agents using subqueries.

-- Step 1 — Create agent performance
SELECT 
    Agent_ID,
    (COUNT(CASE WHEN Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) 
    AS On_Time_Percentage
FROM dhl_shipments
GROUP BY Agent_ID;

-- Step 2 — Compare Top 5 vs Bottom 5
SELECT 
    'Top 5 Agents' AS Category,
    AVG(a.Avg_Rating) AS Avg_Rating,
    AVG(a.Experience_Years) AS Avg_Experience
FROM dhl_delivery_agents a
JOIN (
        SELECT Agent_ID
        FROM dhl_shipments
        GROUP BY Agent_ID
        ORDER BY (COUNT(CASE WHEN Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) DESC
        LIMIT 5
     ) t
ON a.Agent_ID = t.Agent_ID

UNION

SELECT 
    'Bottom 5 Agents' AS Category,
    AVG(a.Avg_Rating),
    AVG(a.Experience_Years)
FROM dhl_delivery_agents a
JOIN (
        SELECT Agent_ID
        FROM dhl_shipments
        GROUP BY Agent_ID
        ORDER BY (COUNT(CASE WHEN Delay_Hours = 0 THEN 1 END) * 100.0 / COUNT(*)) ASC
        LIMIT 5
     ) b
ON a.Agent_ID = b.Agent_ID;


-- Suggest training or workload balancing strategies for low-performing agents based on insights.
-- ->  Agents with low on-time % should receive additional training, route reassignment, or workload balancing. 
-- ->  Experienced and highly rated agents can be assigned to high-delay routes to improve performance.







































































