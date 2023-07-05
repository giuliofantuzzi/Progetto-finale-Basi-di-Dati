-- età media della rosa di ogni squadra
SELECT s.Nome AS Squadra, ROUND(AVG(DATEDIFF(CURDATE(), g.DataDiNascita) / 365)) AS MediaEta
FROM Squadra s
JOIN Giocatore g ON s.Nome = g.Squadra
GROUP BY s.Nome;
