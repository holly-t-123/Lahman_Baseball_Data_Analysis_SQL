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
WHERE yearid <> '1981' AND yearid >= '1970'
AND WSWin = 'Y'
GROUP BY name, yearid, w, wswin
ORDER BY w
LIMIT 5;

--7d.
SELECT yearid, name, w
FROM teams
WHERE yearid >= '1970'
GROUP BY yearid, name, w
HAVING w =
		(SELECT MAX(W)
		 FROM teams
		 WHERE wswin = 'Y');


SELECT t1.name, t1.yearid, t1.w,
		t2.yearid, t2.wswin
FROM teams AS t1 INNER JOIN teams AS t2
USING(yearid)
WHERE t1.yearid >= '1970' 
AND t2.yearid >= '1970'
GROUP BY t1.name, t1.yearid, t1.w,
		t2.yearid, t2.wswin
HAVING MAX(t1.w) = t1.w
AND T2.wswin = 'Y';


SELECT name, yearid, w
FROM teams
WHERE yearid >= '1970'
AND w IN
	(SELECT MAX(w)
	FROM teams
	WHERE wswin = 'Y'
	GROUP BY yearid)
GROUP BY name, yearid, w;

WITH max_wins_year AS
(SELECT yearid, name, MAX(w) AS most_wins
	 FROM teams
	 WHERE yearid >= '1970'
	 GROUP BY yearid, name
	ORDER BY yearid DESC),
wswinner AS (SELECT yearid, name
	FROM teams
	WHERE wswin = 'Y'
		AND yearid >= '1970')

SELECT t.name AS Team_name,
		yearid AS Year,
		w AS wins		
FROM teams AS t
INNER JOIN max_wins_year USING(yearid)
INNER JOIN wswinner USING(yearid)
WHERE yearid IN
	(SELECT yearid
	FROM max_wins_year)
AND wswin = 'Y'
GROUP BY yearid, t.name, w
ORDER BY yearid;




