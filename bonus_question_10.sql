--BONUS QUESTION 10
/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major leagues. 
Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.
hall of fame?
currently playing?

*/

WITH tn_schools AS (SELECT DISTINCT schoolname, schoolid 
					FROM schools 
					WHERE schoolstate = 'TN'
					),
tn_players AS (	SELECT DISTINCT playerid,schoolid 
				FROM collegeplaying 
				WHERE schoolid IN (SELECT schoolid 
				   					FROM tn_schools)
			   ORDER BY playerid
				),
				
tn_players_salary AS (SELECT playerid, AVG(salary)::numeric::money AS avg_salary 
					  FROM salaries 
					  WHERE playerid IN (SELECT playerid 
										 FROM tn_players
										)
					  GROUP BY playerid
					  )
					  
SELECT schoolname, 
		COUNT(tnp.playerid), 
		COALESCE(AVG(avg_salary::numeric)::money::text,'no data')
FROM tn_schools AS tns
FULL JOIN tn_players AS tnp
USING(schoolid)
FULL JOIN tn_players_salary AS tnps
USING(playerid)
GROUP BY schoolname



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


--check maryville college salary data
--check on league 

SELECT * FROM collegeplaying FULL JOIN salaries USING(playerid) WHERE schoolid = 'uniontn'





WITH max_wins AS (SELECT yearid,
		MAX(w) AS w
FROM teams
WHERE yearid >= '1970'
GROUP BY yearid),

max_wins_team AS (SELECT name, yearid
FROM max_wins LEFT JOIN teams USING(yearid)
WHERE teams.w = max_wins.w),

wswinners AS (	SELECT yearid, name, wswin
				FROM teams
				WHERE yearid >= '1970'
				AND wswin = 'Y'
			  )
			  
SELECT * FROM wswinners FULL JOIN max_wins_team USING(yearid) WHERE wswinners.name = max_wins_team.name

