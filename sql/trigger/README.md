# Trigger

In questa cartella sono presenti gli script sql dei seguenti trigger:

- `triggerControlloGirone.sql`: trigger per evitare che venga creata una partita in cui si affrontano squadre appartenenti a gironi diversi;
  
- `triggerControlloAssegnazioneArbitro.sql`: trigger per le designazioni arbitrali: si richiede che un arbitro non possa dirigere una
gara in cui gioca una squadra (se esiste) del suo paese di residenza;

- `triggerControlloPatentinoAllenatore.sql`: trigger per evitare che la gestione delle squadre venga affidata ad allenatori non in possesso del patentino di base. In particolare, volevo garantire che il trigger agisse sia in fase di inserimento che di modifica. Siccome mySQL -purtroppo- non prevede la possibilità di farlo in un unico trigger, ho valutato di creare una procedura da richiamare poi in entrambi i trigger (per non appesantire il codice e per facilitare eventuali modifiche future);

- `triggerUpdateStatisticheSquadra.sql`: trigger che quando viene inserito un risultato di una sua partita aggiorna automaticamente gli attributi Vittorie,Pareggi,Sconfitte,GoalFatti,GoalSubiti
delle squadre coinvolte;

- `triggerUpdateTotaleGoalGiocatore.sql`: trigger che aggiorna automaticamente l'attributo TotaleGoal di un giocatore quando egli risulta marcatore in una partita a cui ha partecipato;

- `triggerControlloMaxSpettatori.sql`: trigger per evitare che in una partita venga inserito un numero di spettatori maggiore della capienza massima dello stadio;

### Nota
Per come ho scelto di strutturare il database, l’arbitro e il risultato possono essere assegnati in un momento successivo all’inserimento di una partita. Nella realtà infatti, ciò che si fa è stilare ad inizio campionato il calendario di tutte le partite , per poi aggiornarlo man mano inserendo arbitri, risultati ed altri dettagli (es: numero spettatori). Nulla vieta però di inserire questi dati quando si inserisce una partita: è dunque opportuno che alcuni trigger, oltre che in UPDATE, vengano definiti anche in INSERT (magari definendo una procedura standard per non appesantire il codice, come per `triggerControlloPatentinoAllenatore.sql`). Nel mio progetto, per semplicità, ho scelto di proporre solamente la versione UPDATE di tali trigger
