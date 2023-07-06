/*-------------------------------------------*/
-- DB SETUP 
/*-------------------------------------------*/

DROP DATABASE IF EXISTS PrimaCategoriaVeneta;
CREATE DATABASE PrimaCategoriaVeneta;
USE PrimaCategoriaVeneta;

/*-------------------------------------------*/
-- CREAZIONE DELLE TABELLE
/*-------------------------------------------*/

DROP TABLE IF EXISTS Girone;
CREATE TABLE Girone(
	Lettera char(1) PRIMARY KEY,
    CONSTRAINT GironeValido CHECK (Lettera BETWEEN 'A' AND 'H')
);

DROP TABLE IF EXISTS Allenatore;
CREATE TABLE Allenatore(
	CF char(16) PRIMARY KEY,
    Nome varchar(25),
    Cognome varchar(25),
    DataDiNascita date,
    Patentino bool DEFAULT FALSE
);

DROP TABLE IF EXISTS Stadio;
CREATE TABLE Stadio(
	Nome varchar(40) PRIMARY KEY,
    Indirizzo varchar(40),
    Capienza int(4) NOT NULL CHECK(Capienza>0),
    CostoBiglietto int(2) NOT NULL CHECK(CostoBiglietto>0)
);

DROP TABLE IF EXISTS Arbitro;
CREATE TABLE Arbitro(
	CF char(16) PRIMARY KEY,
    Nome varchar(25),
    Cognome varchar(25),
    DataDiNascita date,
    PaeseDiResidenza varchar(30) NOT NULL, -- mi servirà per controllo su assegnazione arbitro
    Sezione varchar(30) NOT NULL
);

DROP TABLE IF EXISTS Squadra;
CREATE TABLE Squadra(
	Nome varchar(25) PRIMARY KEY,
    Paese varchar(30) NOT NULL, -- voglio not null perchè farò controlli con arbitro!
    Girone char(1) NOT NULL,
    Vittorie int(2) DEFAULT 0,
    Pareggi int(2) DEFAULT 0,
    Sconfitte int(2) DEFAULT 0,
    GoalFatti int(3) DEFAULT 0 CHECK(GoalFatti>=0),
    GoalSubiti int(3) DEFAULT 0 CHECK(GoalSubiti>=0),
    Allenatore char(16) UNIQUE, -- grazie a unique non potrò avere squadre con lo stesso allenatore
    Stadio varchar(40) NOT NULL UNIQUE, -- squadra deve per forza avere stadio e non ci sono squadre con lo stesso
    FOREIGN KEY(Girone) REFERENCES Girone(Lettera),
    FOREIGN KEY(Allenatore) REFERENCES Allenatore(CF),
    FOREIGN KEY(Stadio) REFERENCES Stadio(Nome)
);

DROP TABLE IF EXISTS Giocatore;
CREATE TABLE Giocatore(
	CF char(16) PRIMARY KEY,
    Nome varchar(25),
    Cognome varchar(25),
    DataDiNascita date,
    Numero int(2),
    RuoloPrincipale varchar(20) CHECK(RuoloPrincipale IN ('Portiere', 'Difensore','Centrocampista','Attaccante')),
	TotaleGoal int(3) DEFAULT 0,
    Squadra varchar(25),
    FOREIGN KEY(Squadra) REFERENCES Squadra(Nome)
);

DROP TABLE IF EXISTS Partita;
CREATE TABLE Partita(
	ID char(5) PRIMARY KEY,
    Data date NOT NULL,
    Giornata int(2) NOT NULL CHECK(Giornata>=1),
    Spettatori int(4) DEFAULT 0 CHECK(Spettatori>=0),
    SquadraCasa varchar(25) NOT NULL,
    SquadraTrasferta varchar(25) NOT NULL,
    GoalCasa int(2) DEFAULT NULL CHECK(GoalCasa>=0),
    GoalTrasferta int(2) DEFAULT NULL CHECK(GoalTrasferta>=0),
    Stadio varchar(40) NOT NULL,
    Arbitro char(16), -- non metto NOT NULL, così la designazione arbitrale può avvenire dopo l'inserimento della partita
    FOREIGN KEY(SquadraCasa) REFERENCES Squadra(Nome),
    FOREIGN KEY(SquadraTrasferta) REFERENCES Squadra(Nome),
    FOREIGN KEY(Stadio) REFERENCES Stadio(Nome),
    FOREIGN KEY(Arbitro) REFERENCES Arbitro(CF)
);

DROP TABLE IF EXISTS Partecipazione;
CREATE TABLE Partecipazione(
	Giocatore char(16),
    Partita char(5),
    Ruolo varchar(20) CHECK(Ruolo IN ('Portiere', 'Difensore','Centrocampista','Attaccante')),
    Goal int(2) DEFAULT 0 CHECK(Goal>=0),
    Ammonizione BOOL DEFAULT FALSE,
    Espulsione BOOL DEFAULT FALSE,
    PRIMARY KEY (Giocatore,Partita),
    FOREIGN KEY(Giocatore) REFERENCES Giocatore(CF),
    FOREIGN KEY(Partita) REFERENCES Partita(ID)
);
