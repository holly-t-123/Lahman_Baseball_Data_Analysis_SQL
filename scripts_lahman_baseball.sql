--#1
SELECT MAX(yearid), MIN(yearid)
FROM teams;

--#2

--#3

--#4

--#5
/*5a. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. 
5b.Do the same for home runs per game. 
5c.Do you see any trends?*/
SELECT (yearid/10)*10 AS decade,
		ROUND((SUM(so)::decimal/SUM(g)::decimal),2) AS avg_so_game,
		ROUND((SUM(hr)::decimal/SUM(g)::decimal),2) AS avg_hr_game
FROM batting
WHERE (yearid/10)*10 >= 1920
GROUP BY decade;

SELECT *
FROM batting
WHERE yearid Between 1870 AND 1879;

--#6

--#7
--7a. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
--7b. What is the smallest number of wins for a team that did win the world series? 
--7c. Doing this will probably result in an unusually small number of wins for a world series champion – 
--	determine why this is the case. Then redo your query, excluding the problem year. 
--7d. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
--7e. What percentage of the time?

SELECT *
FROM teams
WHERE yearid >= '1970';

--7a.
SELECT name AS Team_name,
		yearid AS Year,
		W AS Wins,
		WSWin AS World_Series_Win
FROM teams
WHERE yearid >= '1970'
AND WSWin = 'N'
GROUP BY name, yearid, w, wswin
ORDER BY w DESC
LIMIT 5;
		
--7b. 
SELECT name AS Team_name,
		yearid AS Year,
		W AS Wins,
		WSWin AS World_Series_Win
FROM teams
WHERE yearid >= '1970'
AND WSWin = 'Y'
GROUP BY name, yearid, w, wswin
ORDER BY w
LIMIT 5;

--7c.
SELECT name AS Team_name,
		yearid AS Year,
		W AS Wins,
		WSWin AS World_Series_Win
FROM teams
WHERE yearid BETWEEN '1970' AND '1980' OR yearid BETWEEN '1982' AND '2016'
AND WSWin = 'Y'
GROUP BY name, yearid, w, wswin
ORDER BY w
LIMIT 5;

