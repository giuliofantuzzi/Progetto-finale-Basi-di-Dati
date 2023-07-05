DROP TRIGGER IF EXISTS UpdateStatisticheSquadra;
DELIMITER $$
CREATE TRIGGER UpdateStatisticheSquadra AFTER UPDATE ON Partita
FOR EACH ROW
BEGIN
  -- Inizialmente i goal sono NULL. Voglio che il trigger scatti solo quando aggiorno i goal
  -- (in assenza di questo IF creava dei problemi quando inserivo l'arbitro ad esempio
	IF NEW.GoalCasa IS NOT NULL AND NEW.GoalTrasferta IS NOT NULL THEN 
		-- AGGIORNAMENTO RISULTATI
		-- Caso 1: vittoria squadra di casa
		IF NEW.GoalCasa > NEW.GoalTrasferta THEN 
			UPDATE Squadra SET Vittorie = Vittorie + 1 WHERE Nome = NEW.SquadraCasa;
			UPDATE Squadra SET Sconfitte = Sconfitte + 1 WHERE Nome = NEW.SquadraTrasferta;
		-- Caso 2: pareggio
		ELSEIF NEW.GoalCasa = NEW.GoalTrasferta THEN
			UPDATE Squadra SET Pareggi = Pareggi + 1  WHERE Nome = NEW.SquadraCasa OR Nome = NEW.SquadraTrasferta;
		-- Caso 3: vittoria squadra in trasferta
		ELSE
			UPDATE Squadra SET Sconfitte = Sconfitte + 1 WHERE Nome = NEW.SquadraCasa;
			UPDATE Squadra SET Vittorie = Vittorie + 1 WHERE Nome = NEW.SquadraTrasferta;
		END IF;
		-- AGGIORNAMENTO GOAL FATTI E SUBITI
		-- Squadra di casa
		UPDATE Squadra SET GoalFatti= GoalFatti+NEW.GoalCasa WHERE Nome= NEW.SquadraCasa;
		UPDATE Squadra SET GoalSubiti= GoalSubiti+NEW.GoalTrasferta WHERE Nome= NEW.SquadraCasa;
		-- Squadra in trasferta
		UPDATE Squadra SET GoalFatti= GoalFatti+NEW.GoalTrasferta WHERE Nome= NEW.SquadraTrasferta;
		UPDATE Squadra SET GoalSubiti= GoalSubiti+NEW.GoalCasa WHERE Nome= NEW.SquadraTrasferta;
	END IF;
END $$
DELIMITER ;
