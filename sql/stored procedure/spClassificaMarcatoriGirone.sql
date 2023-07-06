DROP PROCEDURE IF EXISTS ClassificaMarcatoriGirone;

DELIMITER $$
CREATE PROCEDURE ClassificaMarcatoriGirone (IN letteragirone CHAR(1))
BEGIN
    SELECT G.Nome, G.Cognome, G.TotaleGoal
    FROM Giocatore G
    INNER JOIN Squadra S ON G.Squadra = S.Nome -- grazie al join gli svincolati li escludo
    WHERE S.Girone = letteragirone
    ORDER BY G.TotaleGoal DESC;
END $$
DELIMITER ;

-- CALL ClassificaMarcatoriGirone('A');
