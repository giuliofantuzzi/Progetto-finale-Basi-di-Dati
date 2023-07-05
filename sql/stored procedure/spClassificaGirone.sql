DROP PROCEDURE IF EXISTS ClassificaGirone;
DELIMITER $$
CREATE PROCEDURE ClassificaGirone (IN lettera CHAR(1))
BEGIN
    SELECT(Vittorie * 3 + Pareggi) AS Punti, Nome, GoalFatti, GoalSubiti, (GoalFatti- GoalSubiti) AS DifferenzaReti
    FROM Squadra
    WHERE Girone = lettera
    ORDER BY Punti DESC, DifferenzaReti DESC;-- a parità di punti prevale la differenza reti >
END $$
DELIMITER ;

-- CALL ClassificaGirone('A');
