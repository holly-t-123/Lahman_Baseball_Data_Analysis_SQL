--Question 8.Using the attendance figures from the homegames table, 
--find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). 
--Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

SELECT park_name,
       team,
       ROUND((AVG(attendance)/games),0) AS avg_attendance
FROM homegames INNER JOIN parks
               USING (park)       
WHERE year= '2016'
AND games >'10'
GROUP BY park_name,team,games
ORDER BY avg_attendance DESC
LIMIT 5

SELECT park_name,
       team,
       ROUND((AVG(attendance)/games),0) AS avg_attendance
FROM homegames INNER JOIN parks
USING (park)
WHERE year= '2016'
AND games >'10'
GROUP BY park_name,team,games
ORDER BY avg_attendance ASC
LIMIT 5