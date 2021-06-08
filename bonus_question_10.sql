--BONUS QUESTION 10
/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major leagues. 
Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.
*/

WITH tn_schools AS (SELECT DISTINCT schoolname, schoolid 
					FROM schools 
					WHERE schoolstate = 'TN'
					)

SELECT 	schoolname, 
		COUNT(playerid) AS major_league_players, 
		AVG(salary)::numeric::money AS avg_salary,
		COUNT(wswin) AS world_series_wins
FROM collegeplaying AS cp
LEFT JOIN tn_schools AS tns
USING(schoolid)
LEFT JOIN salaries AS s
USING(playerid)
LEFT JOIN teams AS t
USING(teamid)
WHERE schoolname IN (SELECT schoolname
				   FROM tn_schools)
AND (s.yearid = t.yearid OR s.yearid IS NULL)
GROUP BY schoolname
ORDER BY avg_salary ASC