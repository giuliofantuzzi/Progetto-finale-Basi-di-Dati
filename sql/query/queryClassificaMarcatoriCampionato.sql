-- Query per classifica marcatori del campionato
SELECT g.Nome, g.Cognome,g.TotaleGoal
    FROM Giocatore g
    WHERE g.Squadra IS NOT NULL -- non considero giocatori svincolati
    ORDER BY g.TotaleGoal DESC;
    
