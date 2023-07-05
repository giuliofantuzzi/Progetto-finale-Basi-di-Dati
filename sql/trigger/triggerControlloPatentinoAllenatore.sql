/*IDEA: un allenatore senza patentino non può essere assegnato ad una squadra
Mi serve un trigger che agisca sia quando inserisco una squadra, sia quando la modifico
Purtroppo su mySQL non si può fare trigger che agisca sia in insert che update. Bisogna farne 2
Per non scrivere codice ripetitivo, creo una procedura standard che richiamerò nei trigger*/

DROP PROCEDURE IF EXISTS ProceduraControlloPatentino;
DROP TRIGGER IF EXISTS ControlloPatentinoInsert;
DROP TRIGGER IF EXISTS ControlloPatentinoUpdate;

DELIMITER $$
CREATE PROCEDURE ProceduraControlloPatentino(IN CFAllenatore CHAR(16))
BEGIN
    DECLARE possesso BOOL;
    -- Ottieni il valore del campo Patentino dell'allenatore
    SELECT Patentino INTO possesso
    FROM Allenatore
    WHERE CF = CFAllenatore;
    -- Verifica se il valore del campo Patentino è FALSE
    IF possesso = FALSE THEN
        SIGNAL SQLSTATE '45001'
        SET MESSAGE_TEXT = "Impossibile eseguire l'operazione. L'allenatore non ha il patentino!";
    END IF;
END $$
DELIMITER ;

-- Trigger per inserimento squadra
DELIMITER $$
CREATE TRIGGER ControlloPatentinoInsert
BEFORE INSERT ON Squadra 
FOR EACH ROW
BEGIN
	CALL ProceduraControlloPatentino(NEW.Allenatore);
END $$
DELIMITER ;

-- Trigger per modifica squadra
DELIMITER $$
CREATE TRIGGER ControlloPatentinoUpdate
BEFORE UPDATE ON Squadra
FOR EACH ROW
BEGIN
	CALL ProceduraControlloPatentino(NEW.Allenatore);
END $$
DELIMITER ;
