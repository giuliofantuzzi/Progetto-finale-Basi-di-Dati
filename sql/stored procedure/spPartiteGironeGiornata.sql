-- partite in programma per una giornata di un girone (anche futura, quindi non seleziono risultati e spettatori!)
DROP PROCEDURE IF EXISTS PartiteGironeGiornata;
DELIMITER $$
CREATE PROCEDURE PartiteGironeGiornata(IN lettera CHAR(1), IN numero INT)
BEGIN
    SELECT ID, Data,SquadraCasa,SquadraTrasferta,Stadio
    FROM Partita
    WHERE (Giornata = numero) AND (SquadraCasa IN (SELECT Nome FROM Squadra WHERE Girone = lettera)); -- per trovare il girone mi basta una squadra
END $$
DELIMITER ;

-- CALL PartiteGironeGiornata('A',1);
