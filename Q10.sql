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
tn_players AS (	SELECT DISTINCT playerid, schoolid 
				FROM collegeplaying 
				WHERE schoolid IN (SELECT schoolid 
				   					FROM tn_schools)
			   ORDER BY playerid
				),
								
tn_players_salary AS (SELECT playerid, 
					  AVG(salary)::numeric::money AS avg_salary 
					  FROM salaries 
					  WHERE playerid IN (SELECT playerid 
										 FROM tn_players
										)
					  GROUP BY playerid
					  ),

tn_players_awards AS (	SELECT playerid, awardid
				  		FROM awardsplayers
				  		WHERE playerid IN (SELECT playerid FROM tn_players)
					  )
					  
SELECT schoolname AS school, 
		COUNT(DISTINCT tnp.playerid) AS num_players, 
		COALESCE(AVG(avg_salary::numeric)::money::text,'no data') AS avg_player_salary,
		COUNT(awardid) AS num_player_awards
FROM tn_schools AS tns
FULL JOIN tn_players AS tnp
USING(schoolid)
FULL JOIN tn_players_salary AS tnps
USING(playerid)
FULL JOIN tn_players_awards
USING(playerid)
GROUP BY schoolname
ORDER BY num_players DESC


-- SELECT DISTINCT playerid FROM collegeplaying WHERE schoolid = 'tennessee'
-- SELECT AVG(salary) 
-- FROM salaries 
-- WHERE playerid IN (SELECT playerid 
-- 				   FROM tn_players 
-- 				   WHERE schoolid='tennessee')
				   
-- SELECT * FROM schools WHERE schoolid = 'tennessee'