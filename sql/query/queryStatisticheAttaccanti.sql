SELECT g.Nome,g.Cognome,min(p.Goal) AS MinGoal,max(p.Goal) AS MaxGoal,avg(p.Goal) AS AvgGoal
FROM Partecipazione p INNER JOIN Giocatore g ON p.Giocatore=g.CF
WHERE g.RuoloPrincipale='Attaccante'
GROUP BY p.Giocatore
ORDER BY avg(p.Goal) DESC;
