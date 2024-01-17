/*Jobs Reviewed Over Time:
Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
Throughput Analysis:
Objective: Calculate the 7-day rolling average of throughput (number of events per second).
Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.
Language Share Analysis:
Objective: Calculate the percentage share of each language in the last 30 days.
Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.
Duplicate Rows Detection:
Objective: Identify duplicate rows in the data.
Your Task: Write an SQL query to display duplicate rows from the job_data table.*/


/*Objective: Calculate the number of jobs reviewed per hour for each day in November 2020.
Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.*/

USE project3;

SELECT * FROM job_data;

SELECT   ds, count(job_id) AS 'jobs_per_day', ROUND(SUM(time_spent)/3600,2) AS 'hours_spent'
FROM  job_data
WHERE ds between '2020-11-01' AND '2020-11-30'
GROUP BY ds
ORDER BY ds;

/*Objective: Calculate the 7-day rolling average of throughput (number of events per second).
Your Task: Write an SQL query to calculate the 7-day rolling average of throughput. Additionally, explain whether you prefer using the daily metric or the 7-day rolling average for throughput, and why.*/

SELECT ds, ROUND(COUNT(event)/SUM(time_spent),4) AS throughput
FROM job_data        
GROUP BY ds
ORDER BY ds;

SELECT
    ds, AVG(throughput) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM (
    SELECT ds, ROUND(COUNT(event)/SUM(time_spent),4) AS throughput
    FROM job_data        
    GROUP BY ds
    ORDER BY ds
) AS events_each_day_per_sec;

/*Objective: Calculate the percentage share of each language in the last 30 days.
Your Task: Write an SQL query to calculate the percentage share of each language over the last 30 days.*/

SELECT * FROM job_data
ORDER BY language;

SELECT language, SUM(COUNT(DISTINCT(language))) OVER() AS 'lang_count'
FROM job_data;

SELECT language, 
COUNT(language) *100 / (SELECT SUM(COUNT(language)) OVER() AS 'lang_count' FROM job_data) AS 'percentage'
FROM job_data
WHERE ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY language;

SELECT language, 
COUNT(language) *100 / (SELECT SUM(COUNT(DISTINCT(language))) OVER() AS 'lang_count' FROM job_data) AS 'percentage'
FROM job_data
WHERE ds BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY language;

/*Objective: Identify duplicate rows in the data.
Your Task: Write an SQL query to display duplicate rows from the job_data table.*/

SELECT * FROM job_data
ORDER BY ds;

SELECT * , ROW_NUMBER() OVER ( PARTITION BY job_id, actor_id ORDER By ds ) AS rank_num  
FROM job_data;



