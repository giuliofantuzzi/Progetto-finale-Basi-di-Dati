# Stored Procedure
In questa cartella sono presenti gli script sql delle seguenti stored procedure:

- `spClassificaGirone.sql`: SP per determinare la classifica marcatori di un girone a scelta (parametro in input);

- `spClassificaMarcatoriGirone.sql`: SP per determinare la classifica marcatori di un girone a scelta (parametro in input);

- `spPartiteGironeGiornata.sql`: SP che, dati un girone e il numero di una giornata (parametri in input), mostra la lista delle partite. Dato che questa operazione si vuole poter fare, in generale, per partite non ancora disputate, la SP seleziona solamente gli attributi *ID, Data,SquadraCasa,SquadraTrasferta,Stadio*;

- `spIncassoStadioGiornata.sql`: SP che, per una giornata a scelta (parametro in input), mostra gli incassi dei diversi stadi in cui si sono giocate le partite. Si noti che l'operazione vuole essere applicata all'intero campionato, senza distinguere gli stadi di un girone particolare.
