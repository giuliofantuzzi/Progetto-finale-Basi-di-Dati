DROP TRIGGER IF EXISTS UpdateTotaleGoalGiocatore;
DELIMITER $$
CREATE TRIGGER UpdateTotaleGoalGiocatore
AFTER INSERT ON Partecipazione
FOR EACH ROW
BEGIN
    DECLARE goalPartita INT;
    -- Ottengo il numero di goal appena inserito
    SET goalPartita = NEW.Goal;
    -- Aggiorno l'attributo "TotaleGoal" del giocatore che ha segnato
    UPDATE Giocatore
    SET TotaleGoal = TotaleGoal + goalPartita
    WHERE CF = NEW.Giocatore;
END $$
DELIMITER ;
