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

