--#5
/*5a. Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. 
5b.Do the same for home runs per game. 
5c.Do you see any trends?*/
SELECT (b.yearid/10)*10 AS decade,
		ROUND((SUM(b.so+bp.so)::decimal/SUM(b.g+bp.g)::decimal),2) AS avg_so_game,
		ROUND((SUM(b.hr+bp.hr)::decimal/SUM(b.g+bp.g)::decimal),2) AS avg_hr_game
FROM batting AS b
FULL JOIN battingpost AS bp
ON b.yearid = bp.yearid
WHERE (b.yearid/10)*10 >= 1920
GROUP BY decade;

