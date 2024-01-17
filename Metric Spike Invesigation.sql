/*Weekly User Engagement:
Objective: Measure the activeness of users on a weekly basis.
Your Task: Write an SQL query to calculate the weekly user engagement.
User Growth Analysis:
Objective: Analyze the growth of users over time for a product.
Your Task: Write an SQL query to calculate the user growth for the product.
Weekly Retention Analysis:
Objective: Analyze the retention of users on a weekly basis after signing up for a product.
Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.
Weekly Engagement Per Device:
Objective: Measure the activeness of users on a weekly basis per device.
Your Task: Write an SQL query to calculate the weekly engagement per device.
Email Engagement Analysis:
Objective: Analyze how users are engaging with the email service.
Your Task: Write an SQL query to calculate the email engagement metrics.*/

USE project3;


/*Objective: Measure the activeness of users on a weekly basis.
Your Task: Write an SQL query to calculate the weekly user engagement.*/

SELECT * FROM users;
SELECT DATE_FORMAT(activated_at, '%Y-%u') AS 'week', COUNT(DISTINCT user_id) AS 'users_engagement'
FROM  users
GROUP BY week
ORDER BY week;


/*Objective: Analyze the growth of users over time for a product.
Your Task: Write an SQL query to calculate the user growth for the product.*/

SELECT * FROM events;

SELECT user_id, DATE_FORMAT(occured_at, '%Y-%u') AS 'week', COUNT(DISTINCT(user_id)) AS users_count
FROM events
GROUP BY week
ORDER BY week;

SELECT  week, device, COUNT(DISTINCT(user_id)) AS 'users_count',
COUNT(DISTINCT(user_id)) - LAG(COUNT(DISTINCT(user_id)),1)  OVER(PARTITION BY device ORDER BY week) AS 'Growth'   
FROM(
 SELECT  user_id , device, DATE_FORMAT(occured_at, '%Y-%u') AS 'week'  
 FROM events 
 GROUP BY week,device
 ORDER BY week,device) a
 GROUP BY week ; 
 
 


/*Objective: Analyze the retention of users on a weekly basis after signing up for a product.
Your Task: Write an SQL query to calculate the weekly retention of users based on their sign-up cohort.*/

SELECT * FROM events;

SELECT device, DATE_FORMAT(occured_at, '%Y-%u') AS 'week', 
COUNT(DISTINCT user_id) as 'users_engaged'
FROM events
WHERE event_type="signup_flow" AND event_name="complete_signup" 
GROUP BY week
ORDER BY week;


/*Objective: Measure the activeness of users on a weekly basis per device.
Your Task: Write an SQL query to calculate the weekly engagement per device.*/

SELECT device, DATE_FORMAT(occured_at, '%Y-%u') AS 'week', COUNT(DISTINCT(user_id)) AS users_count
FROM events
GROUP BY week, device
ORDER BY week, device;




/*Objective: Analyze how users are engaging with the email service.
Your Task: Write an SQL query to calculate the email engagement metrics.*/

SELECT * FROM email_events;

SELECT action , COUNT(action) AS 'engagement', engagement_month
FROM 
 (
    SELECT * , DATE_FORMAT(occured_at, '%Y-%m') AS 'engagement_month'
    FROM email_events
 )b
 GROUP BY action , engagement_month
 ORDER BY engagement_month;
 

