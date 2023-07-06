# Codice per la creazione del DB

Questa cartella contiene gli script sql per la creazione del database *PrimaCategoriaVeneta*.

- `create.sql`: questo script contiene il codice per la creazione del database e di tutte le sue tabelle;

- `insert_and_test.sql`: questo script contiene il codice per l'inserimento di alcuni dati nel database. Inoltre, esso contiene alcuni semplici test per controllare l'effettivo funzionamento di trigger e vincoli.

## ISTRUZIONI (IMPORTANTI) PER L'USO 
1. Ho scelto volutamente di commentare tutte le righe in cui venivano effettuati i test, in quanto i vari trigger e vincoli bloccavano (giustamente!) l'esecuzione del codice "errato";

2. Per comodità, le tabelle sono state riempite solo con il **minimo indispensabile**: molti attributi non sono stati volutamente inseriti (*es: ci saranno partite non assegnate ad un arbitro*);

3. È possibile eseguire lo script `insert_and_test.sql` in blocco, così da popolare un minimo il database. I dati da me inseriti dovrebbero bastare per poter controllare e testare TUTTE le query, stored procedure e trigger
  - <ins>**NB: assicurarsi creare i trigger PRIMA di eseguire lo script `insert_and_test.sql`**</ins>
 
