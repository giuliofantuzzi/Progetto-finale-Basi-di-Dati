DROP TRIGGER IF EXISTS ControlloAssegnazioneArbitro;
-- NB: propongo solo UPDATE poiché suppongo assegnazione arbitro avvenga dopo inserimento partita

DELIMITER $$
CREATE TRIGGER ControlloAssegnazioneArbitro
BEFORE UPDATE ON Partita 
FOR EACH ROW
BEGIN
    DECLARE PaeseSquadraCasa VARCHAR(30);
    DECLARE PaeseSquadraTrasferta VARCHAR(30);
	DECLARE PaeseArbitro VARCHAR(30);
    -- Ottengo il paese della squadra di casa
    SELECT Paese INTO PaeseSquadraCasa
    FROM Squadra
    WHERE Nome = NEW.SquadraCasa;
    -- Ottengo il paese della squadra in trasferta
    SELECT Paese INTO PaeseSquadraTrasferta
    FROM Squadra
    WHERE Nome = NEW.SquadraTrasferta;
    -- Ottengo il paese dell'arbitro
	SELECT PaeseDiResidenza INTO PaeseArbitro
    FROM Arbitro 
    WHERE CF = NEW.Arbitro;
    -- Verifica se l'arbitro appartiene allo stesso paese di una delle squadre
    IF ((PaeseSquadraCasa = PaeseArbitro) OR (PaeseSquadraTrasferta= PaeseArbitro))  THEN
        SIGNAL SQLSTATE '45002' 
            SET MESSAGE_TEXT = "L'arbitro non può arbitrare una partita in cui gioca una squadra del suo stesso paese";
    END IF;
END $$
DELIMITER ;
