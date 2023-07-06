DROP TRIGGER IF EXISTS ControlloMaxSpettatori;
DELIMITER $$
CREATE TRIGGER ControlloMaxSpettatori
BEFORE UPDATE ON Partita
FOR EACH ROW
BEGIN
    DECLARE capienzastadio INT;
    
    SELECT Capienza INTO capienzastadio
    FROM Stadio
    WHERE Nome = OLD.Stadio; -- stadio viene già inserito in inserimento partita!
    
    IF NEW.Spettatori > capienzastadio THEN
        SIGNAL SQLSTATE '45004'
        SET MESSAGE_TEXT = 'Il numero di spettatori supera la capienza dello stadio. Inserimento non consentito.';
    END IF;
END $$
DELIMITER ;
