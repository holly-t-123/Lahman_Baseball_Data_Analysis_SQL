-- Question 1.What range of years for baseball games played does the provided database cover?
SELECT MIN(yearid),MAX(yearid)
FROM teams;

-- Question 2.Find the name and height of the shortest player in the database. How many games did he play in? What is the name of the team for which he played?

--Question 3.Find all players in the database who played at Vanderbilt University. Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. Sort this list in descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?
WITH played_at_vandy AS (SELECT DISTINCT playerid
					                 
                    FROM people AS p 
					 INNER JOIN collegeplaying AS cp
                     USING(playerid)
                     WHERE schoolid ILIKE 'vandy')

SELECT namefirst,namelast,
SUM(s.salary)AS total_salary
                 
      FROM people AS p 
      INNER JOIN salaries AS s
      USING(playerid)
            
                  WHERE playerid IN (SELECT * FROM played_at_vandy)
				  GROUP BY namefirst,namelast
				  ORDER BY total_salary DESC
				
				  


					 








--Question 4.Using the fielding table, group players into three groups based on their position: label players with position OF as "Outfield", those with position "SS", "1B", "2B", and "3B" as "Infield", and those with position "P" or "C" as "Battery". Determine the number of putouts made by each of these three groups in 2016.

--Question 5.Find the average number of strikeouts per game by decade since 1920. Round the numbers you report to 2 decimal places. Do the same for home runs per game. Do you see any trends?

--Question 6.Find the player who had the most success stealing bases in 2016, where success is measured as the percentage of stolen base attempts which are successful. (A stolen base attempt results either in a stolen base or being caught stealing.) Consider only players who attempted at least 20 stolen bases.

--Question 7.From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? What is the smallest number of wins for a team that did win the world series? Doing this will probably result in an unusually small number of wins for a world series champion – determine why this is the case. Then redo your query, excluding the problem year. How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? What percentage of the time?

--Question 8.Using the attendance figures from the homegames table, find the teams and parks which had the top 5 average attendance per game in 2016 (where average attendance is defined as total attendance divided by number of games). Only consider parks where there were at least 10 games played. Report the park name, team name, and average attendance. Repeat for the lowest 5 average attendance.

--Question 9.Which managers have won the TSN Manager of the Year award in both the National League (NL) and the American League (AL)? Give their full name and the teams that they were managing when they won the award.