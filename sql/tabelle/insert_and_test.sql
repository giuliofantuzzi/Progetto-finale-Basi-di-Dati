/*
ALCUNE NOTE PER L'UTENTE: 
~ Assicurarsi di attivare tutti i trigger!
~ Questo script contiene alcuni test per controllare l'effettivo funzionamento dei trigger
  Per scrupolo ho commentato tutte le righe in cui i trigger bloccavano le azioni
  --> così da poter eseguire lo script in blocco per popolare (un minimo minimo!) il database
~ Molti attributi saranno NULL (es: arbitri non assegnati a partita).
  --> Ho inserito il minimo necessario la verifica di query,SP e trigger
*/

-- SETTINGS
use PrimaCategoriaVeneta;
show tables;
show triggers;

-- INSERIMENTO GIRONI
INSERT INTO Girone VALUES ('A');
INSERT INTO Girone VALUES ('B');
INSERT INTO Girone VALUES ('C');
INSERT INTO Girone VALUES ('D');
INSERT INTO Girone VALUES ('E');
INSERT INTO Girone VALUES ('F');
INSERT INTO Girone VALUES ('G');
INSERT INTO Girone VALUES ('H');
select* from Girone;

-- INSERIMENTO STADI (inserisco solo alcuni campi necessari)
INSERT INTO Stadio(Nome,Capienza,CostoBiglietto) VALUES('Stadio Lino madiotto',400,7);
INSERT INTO Stadio(Nome,Capienza,CostoBiglietto) VALUES('Impianto comunale',500,8);
INSERT INTO Stadio(Nome,Capienza,CostoBiglietto) VALUES('Campo Zanardo',200,5);
INSERT INTO Stadio(Nome,Capienza,CostoBiglietto) VALUES('Stadio Picchi',4000,9);
INSERT INTO Stadio(Nome,Capienza,CostoBiglietto) VALUES('Stadio olimpico Caorle',2000,10);
INSERT INTO Stadio(Nome,Capienza,CostoBiglietto) VALUES('Stadio Teghil',5000,8);
select* from Stadio;

-- INSERIMENTO SQUADRE (di default allenatore e stadio non sono ancora assegnati, e W P L e GF GS sono inizialmente 0)
INSERT INTO Squadra(Nome,Paese,Girone, Stadio) VALUES ('USD Torre di Mosto', 'Torre di Mosto','A', 'Stadio Lino madiotto');
INSERT INTO Squadra(Nome,Paese,Girone, Stadio) VALUES ('AC Ceggia', 'Ceggia','A', 'Impianto comunale');
INSERT INTO Squadra(Nome,Paese,Girone, Stadio) VALUES ('ACD San stino', 'San stino di Livenza','A','Campo Zanardo');
INSERT INTO Squadra(Nome,Paese,Girone, Stadio) VALUES ('Calcio Caorle', 'Caorle','B','Stadio olimpico Caorle');
INSERT INTO Squadra(Nome,Paese,Girone, Stadio) VALUES ('Lignano', 'Lignano Sabbiadoro','B','Stadio Teghil');
select* from Squadra;

-- INSERIMENTO GIOCATORI (inserisco solo alcuni campi necessari)
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale, Squadra) VALUES('FNTGLIO1R16E473H', 'Giulio','Fantuzzi','2001-10-16','Attaccante', 'USD Torre di Mosto');
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale, Squadra) VALUES('FNTGVNO1I17E473H', 'Giovanni','Fantuzzi','1991-10-17','Difensore', 'USD Torre di Mosto');
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale, Squadra) VALUES('ANDPNTO1R15F473H', 'Andrea','Panta','2000-03-10','Attaccante', 'ACD San stino');
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale, Squadra) VALUES('CHEVERO1R12G472H', 'Checco','Veronelli','2003-07-02','Centrocampista', 'AC Ceggia');
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale, Squadra) VALUES('MARRINO1R15E471H', 'Mario','Rinaldi','1988-04-11','Portiere', 'Calcio Caorle');
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale, Squadra) VALUES('LUCBNDO1R16E474H', 'Luca','Badon','1997-01-02','Centrocampista', 'AC Ceggia');
-- Giocatore svincolato
INSERT INTO Giocatore(CF,Nome,Cognome, DataDiNascita, RuoloPrincipale) VALUES('SILCOLO1T26E444L', 'Silvestro','Colosso','1980-02-24','Difensore');
select* from Giocatore;

-- INSERIMENTO ALLENATORI
INSERT INTO Allenatore(CF,Patentino) VALUES ('MAUBLIO1R16P472H',TRUE);
INSERT INTO Allenatore(CF,Patentino) VALUES ('LIOBLIO1R12W471H',TRUE);
INSERT INTO Allenatore(CF,Patentino) VALUES ('NITCLIO1E14F473L',TRUE);
INSERT INTO Allenatore(CF,Patentino) VALUES ('UBLCREO1R16L479H',TRUE);
INSERT INTO Allenatore(CF,Patentino) VALUES ('CTAELIO1S16E475H',TRUE);
INSERT INTO Allenatore(CF,Patentino) VALUES ('BISOLIO1R16E476B',FALSE);
select* from Allenatore;

-- INSERIMENTO ARBITRI
INSERT INTO Arbitro VALUES('ARBGLIO1R16E473H', NULL,NULL,NULL,'Torre di Mosto', 'Sez. Portogruaro');
INSERT INTO Arbitro VALUES('ARBDSJO1F19E473P', NULL,NULL,NULL,'Meolo', 'Sez. Treviso');


/*--------------------------------------------------------------------------------------------------------------------------------*/
-- ALCUNI TEST PER VEDERE SE VINCOLI UNIQUE E TRIGGER FUNZIONANO (ed altri inserimenti)
-- NB: ho commentato le righe in cui qualche azione viene bloccata

-- Provo a inserire un allentore valido al torre
UPDATE Squadra SET Allenatore ='MAUBLIO1R16P472H' WHERE Nome='USD Torre di Mosto'; -- OK!

-- UPDATE Squadra SET Allenatore ='BISOLIO1R16E476B' WHERE Nome='USD Torre di Mosto'; -- Giustamente non me lo fa fare grazie al trigger patentino UPDATE

-- INSERT INTO Squadra(Nome,Paese,Girone) VALUES('Jesolo FC','Jesolo','A','Campo Zanardo'); -- Giustamente non me lo fa fare perchè lo stadio è gia assegnato (stadio è UNIQUE)

-- INSERT INTO Squadra(Nome,Paese,Girone,Stadio,Allenatore) VALUES('Jesolo FC','Jesolo','A','Stadio Picchi', 'BISOLIO1R16E476B'); -- Giustamente non me lo fa fare grazie al trigger patentino INSERT

UPDATE Allenatore SET Patentino=TRUE WHERE CF='BISOLIO1R16E476B';-- cambiamo il campo patentino e rendiamolo TRUE
INSERT INTO Squadra(Nome,Paese,Girone,Stadio,Allenatore) VALUES('Jesolo FC','Jesolo','A','Stadio Picchi', 'BISOLIO1R16E476B'); -- Ora va (giusto!)

-- E se provassi a modificare l'allenatore del torre e mettere lo stesso dello jesolo?
-- UPDATE Squadra SET Allenatore='BISOLIO1R16E476B' WHERE Nome='USD Torre di Mosto'; -- non me lo fa fare: allenatore è unique per squadra
-- Ora inserisco gli altri allenatori
UPDATE Squadra SET Allenatore='LIOBLIO1R12W471H' WHERE Nome='AC Ceggia';
UPDATE Squadra SET Allenatore='NITCLIO1E14F473L' WHERE Nome='ACD San stino';
UPDATE Squadra SET Allenatore='UBLCREO1R16L479H' WHERE Nome='Calcio Caorle';
UPDATE Squadra SET Allenatore='CTAELIO1S16E475H' WHERE Nome='Lignano';
-- Test trigger che impedisce a 2 squadre di gironi diversi di affrontarsi
-- INSERT INTO Partita(ID,Giornata,Data,SquadraCasa,SquadraTrasferta,Stadio) VALUES('A0101',1,'2023-09-01','USD Torre di Mosto','Calcio Caorle','Stadio lino madiotto');

-- INSERIMENTO PARTITA (valida)
INSERT INTO Partita(ID,Giornata,Data,SquadraCasa,SquadraTrasferta,Stadio) VALUES('A0101',1,'2023-09-01','USD Torre di Mosto','AC Ceggia','Stadio lino madiotto'); -- OK!
-- ASSEGNAZIONE ARBITRALE
-- Proviamo ad assegnare l'arbitro che abita a torre (non dovrebbe poter arbitrare)
-- UPDATE Partita  SET Arbitro='ARBGLIO1R16E473H' WHERE ID= 'A0101'; -- giustamente blocca
UPDATE Partita  SET Arbitro='ARBDSJO1F19E473P' WHERE ID= 'A0101'; -- qui invece va perchè l'altro arbitro non viola il vincolo

-- INSERIMENTO RISULTATO: supponiamo torre vinca 2 0 e giulio (che gioca a centrocampo, NON il suo ruoloPrincipale) segni 2 goal
-- Prima dell'inserimento:
SELECT * FROM Squadra; -- vittorie,sconfitte,pareggi,goal fatti e subiti sono 0
SELECT TotaleGoal FROM Giocatore WHERE CF='FNTGLIO1R16E473H'; -- TotaleGoal è ancora 0

UPDATE Partita SET GoalCasa=2,GoalTrasferta=0 WHERE ID='A0101';
INSERT INTO Partecipazione VALUES('FNTGLIO1R16E473H','A0101', 'Centrocampista',2,FALSE,FALSE);

-- Dopo l'inserimento
select TotaleGoal from Giocatore where CF='FNTGLIO1R16E473H'; -- campo aggiornato :)
SELECT * FROM Squadra WHERE Nome='USD Torre di Mosto' OR Nome='AC Ceggia'; -- valori aggiornati :)
/*--------------------------------------------------------------------------------------------------------------------------------*/

-- INSERIMENTO DI ALTRE (poche)PARTITE 
/*
NB: senza complicarmi le cose metto solo partita e risultato, senza specificare arbitro,
    spettatori, e senza nemmeno preoccuparmi troppo delle partecipazioni e dei giocatori
*/

INSERT INTO Partita(ID,Giornata,Data,SquadraCasa,SquadraTrasferta,Stadio) VALUES('A0102',1,'2023-09-01','ACD San stino','Jesolo FC','Campo Zanardo');
INSERT INTO Partita(ID,Giornata,Data,SquadraCasa,SquadraTrasferta,Stadio) VALUES('B0101',1,'2023-09-01','Lignano','Calcio Caorle','Stadio Teghil');
INSERT INTO Partita(ID,Giornata,Data,SquadraCasa,SquadraTrasferta,Stadio) VALUES('A0201',2,'2023-09-08','AC Ceggia','ACD San stino','Impianto comunale');
INSERT INTO Partita(ID,Giornata,Data,SquadraCasa,SquadraTrasferta,Stadio) VALUES('A0202',2,'2023-09-08','Jesolo FC','USD Torre di Mosto','Stadio Picchi');

UPDATE Partita SET GoalCasa=3,GoalTrasferta=0 WHERE ID='A0102';
INSERT INTO Partecipazione VALUES('ANDPNTO1R15F473H','A0102', 'Attaccante',3,FALSE,FALSE);

UPDATE Partita SET GoalCasa=2,GoalTrasferta=2 WHERE ID='B0101';
INSERT INTO Partecipazione VALUES('MARRINO1R15E471H','B0101', 'Portiere',1,FALSE,FALSE);

UPDATE Partita SET GoalCasa=1,GoalTrasferta=1 WHERE ID='A0201';
INSERT INTO Partecipazione VALUES('ANDPNTO1R15F473H','A0201', 'Centrocampista',1,FALSE,FALSE);
INSERT INTO Partecipazione VALUES('CHEVERO1R12G472H','A0201', 'Centrocampista',1,FALSE,FALSE);

UPDATE Partita SET GoalCasa=1,GoalTrasferta=1 WHERE ID='A0202';
INSERT INTO Partecipazione VALUES('FNTGVNO1I17E473H','A0201', 'Difensore',1,FALSE,FALSE);
INSERT INTO Partecipazione VALUES('FNTGLIO1R16E473H','A0201', 'Centrocampista',0,TRUE,FALSE); -- stavolta giulio non segna, si arrabbia e viene ammonito
