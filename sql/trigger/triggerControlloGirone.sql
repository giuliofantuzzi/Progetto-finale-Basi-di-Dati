DROP TRIGGER IF EXISTS ControlloGirone;
DELIMITER $$
CREATE TRIGGER ControlloGirone
BEFORE INSERT ON Partita
FOR EACH ROW
BEGIN
    DECLARE GironeCasa CHAR(1);
    DECLARE GironeTrasferta CHAR(1);
    SELECT Girone INTO GironeCasa FROM Squadra WHERE Nome = NEW.SquadraCasa;
    SELECT Girone INTO GironeTrasferta FROM Squadra WHERE Nome = NEW.SquadraTrasferta;
    IF GironeCasa <> GironeTrasferta THEN
        SIGNAL SQLSTATE '45003'
        SET MESSAGE_TEXT = 'Le due squadre appartengono a gironi diversi. Inserimento non consentito.';
    END IF;
END $$
DELIMITER ;
