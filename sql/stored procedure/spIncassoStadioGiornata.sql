-- incassi di una fissata giornata di campionato (comprendo tutti i gironi)
DROP PROCEDURE IF EXISTS IncassoStadioGiornata
DELIMITER $$
CREATE PROCEDURE IncassoStadioGiornata(IN giornata INT)
BEGIN
    SELECT P.Stadio, SUM(P.Spettatori * S.CostoBiglietto) AS Incasso
    FROM Partita P
    INNER JOIN Stadio S ON P.Stadio = S.Nome
    WHERE P.Giornata = giornata
    GROUP BY P.Stadio;
END $$
DELIMITER;
