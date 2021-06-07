--Question 1

SELECT 	MIN(yearid), 
		MAX(yearid)
FROM batting;
--covers 1971 through 2016 (or 2017? using halloffame)

--Question 4 136815 rows in fielding, 11408383 total putouts in fielding
SELECT SUM(PO)
FROM fielding;

SELECT 	CASE 
			WHEN pos = 'OF' THEN 'Outfield'
			WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
			WHEN pos IN ('P','C') THEN 'Battery'
		END AS position_group,
		SUM(PO) AS total_putouts
FROM fielding
GROUP BY position_group;


--Question 9
WITH qualifying_managers AS (SELECT playerid, 
									yearid,
									awardid,
									lgid
							FROM awardsmanagers 
							WHERE awardid = 'TSN Manager of the Year'
							AND lgid IN ('NL','AL')
							AND playerid IN (	SELECT 	playerid 
												FROM awardsmanagers 
												WHERE awardid = 'TSN Manager of the Year' 
												AND lgid IN ('NL','AL')
												GROUP BY playerid
												HAVING COUNT(DISTINCT(lgid))=2) 
							 )

SELECT * FROM teamsfranchises