-- Query con join

-- 13- Selezionare le categorie dei videogame i quali 
-- hanno una media recensioni inferiore a 1.5 (10)
SELECT DISTINCT c.name AS "category_name"
FROM videogames
JOIN reviews r
    ON videogames.id = r.videogame_id
JOIN category_videogame cv 
    ON videogames.id = cv.videogame_id
JOIN categories c 
    ON cv.category_id = c.id
GROUP BY r.id, c.name
HAVING AVG(r.rating) < 1.5;

-- 12- Selezionare la software house che ha vinto 
-- più premi tra il 2015 e il 2016 (software house id : 1)
SELECT TOP 1 
    software_houses.id, 
    software_houses.name
FROM software_houses
JOIN videogames v
    ON software_houses.id = v.software_house_id
JOIN award_videogame av
    ON v.id = av.videogame_id
WHERE av.year BETWEEN 2015 AND 2016
GROUP BY 
    software_houses.id, 
    software_houses.name
ORDER BY COUNT(av.id) DESC;

-- 11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) 
-- con più recensioni (videogame id : 398)
SELECT TOP 1 
    videogames.id, 
    name, release_date, 
    COUNT(r.id) AS "reviews_count"
FROM videogames
JOIN reviews r
    ON videogames.id = r.videogame_id
GROUP BY 
    videogames.id, 
    name, 
    release_date
ORDER BY COUNT(r.id) DESC;

-- 10- Selezionare i dati della prima software house che ha rilasciato un gioco, 
-- assieme ai dati del gioco stesso (software house id : 5)
SELECT TOP 1 *
FROM software_houses
JOIN videogames v
    ON software_houses.id = v.software_house_id
ORDER BY v.release_date;

-- 9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
SELECT p.*
FROM videogames
JOIN award_videogame av 
    ON videogames.id = av.videogame_id
JOIN awards a 
    ON av.award_id = a.id
JOIN tournament_videogame tv 
    ON videogames.id = tv.videogame_id
JOIN tournaments t 
    ON tv.tournament_id = t.id
JOIN player_tournament pt 
    ON t.id = pt.tournament_id
JOIN players p 
    ON pt.player_id = p.id
WHERE av.year = 2018
    AND a.name = N'Gioco più atteso'
    AND t.year = 2019;

-- 8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
SELECT DISTINCT t.city
FROM videogames
JOIN award_videogame av 
    ON videogames.id = av.videogame_id
JOIN tournament_videogame tv 
    ON videogames.id = tv.videogame_id
JOIN tournaments t 
    ON tv.tournament_id = t.id
WHERE av.year = 2018;

-- 7- Selezionare quali giochi erano presenti nei tornei 
-- nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
SELECT DISTINCT videogames.name
FROM videogames
JOIN tournament_videogame tv
    ON videogames.id = tv.videogame_id
JOIN player_tournament pt
    ON tv.tournament_id = pt.tournament_id
JOIN players p
    ON pt.player_id = p.id
WHERE p.name LIKE 'S%';

-- 6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno 
-- ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
SELECT DISTINCT
    videogames.name AS "videogame_name",
    c.name AS "category_name",
    pl.name AS "pegi_label_name"
FROM videogames
JOIN category_videogame cv on videogames.id = cv.videogame_id
JOIN categories c on cv.category_id = c.id
JOIN pegi_label_videogame plv on videogames.id = plv.videogame_id
JOIN pegi_labels pl on plv.pegi_label_id = pl.id
JOIN reviews r on videogames.id = r.videogame_id
WHERE r.rating BETWEEN 4 AND 5;

-- 5- Selezionare i premi ricevuti da ogni software house 
-- per i videogiochi che ha prodotto (55)
SELECT 
    awards.name, 
    sh.name, 
    v.name
FROM awards
JOIN award_videogame av
    ON awards.id = av.award_id
JOIN videogames v 
    ON av.videogame_id = v.id
JOIN software_houses sh 
    ON v.software_house_id = sh.id
GROUP BY 
    sh.name, 
    awards.name, 
    v.name;

-- 4- Selezionare i dati di tutte le software house che hanno 
-- rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
SELECT DISTINCT software_houses.*
FROM software_houses
JOIN videogames v 
    ON software_houses.id = v.software_house_id
WHERE YEAR(v.release_date) > 2020;

-- 3- Mostrare le categorie di ogni videogioco (1718)
SELECT 
    videogames.id, 
    videogames.name, 
    category.id, 
    category.name
FROM videogames
JOIN category_videogame cv 
    ON videogames.id = cv.videogame_id
JOIN categories category 
    ON cv.category_id = category.id;

-- 2- Sezionare tutti i videogame dei tornei tenuti nel 2016, 
-- mostrandoli una sola volta (226)
SELECT DISTINCT 
    videogames.id, 
    videogames.name
FROM videogames
JOIN tournament_videogame tv 
    ON videogames.id = tv.videogame_id
JOIN tournaments t 
    ON tv.tournament_id = t.id
WHERE t.year = 2016;

-- 1- Selezionare i dati di tutti giocatori che hanno scritto 
-- almeno una recensione, mostrandoli una sola volta (996)
SELECT DISTINCT players.*
FROM players
JOIN reviews r
    ON players.id = r.player_id;

-- Query con group by

-- 6- Ordinare i videogame in base alla media 
-- delle recensioni (del videogioco vogliamo solo l'ID) (500)
SELECT 
    videogame_id,
    AVG(rating) AS "average_rating"
FROM reviews
GROUP BY videogame_id
ORDER BY AVG(rating);

-- 5- Contare quanti videogiochi sono disponbiili 
-- per ciascun device (del device vogliamo solo l'ID) (7)
SELECT
    device_id,
    COUNT(*) AS "videogames_count"
FROM device_videogame
GROUP BY device_id;

-- 4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
SELECT 
    YEAR(release_date) AS "year", 
    COUNT(*) AS "count"
FROM videogames
GROUP BY YEAR(release_date);

-- 3- Contare quanti videogiochi hanno ciascuna 
-- classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
SELECT 
    pegi_label_id,
    COUNT(*) as "videogames_count"
FROM pegi_label_videogame
GROUP BY pegi_label_id;

-- 2- Contare quante recensioni ha ricevuto 
-- ogni videogioco (del videogioco vogliamo solo l'ID) (500)
SELECT 
    videogame_id, 
    COUNT(*) AS "reviews_count"
FROM reviews
GROUP BY videogame_id;

-- 1- Contare quante software house ci sono per ogni paese (3)
SELECT country, COUNT(*) AS "count"
FROM software_houses
GROUP BY country;

-- Query su singola tabella

-- 12- Selezionare il numero di videogame che la software house con ID = 1 
-- ha rilasciato nel 2018 (13)
SELECT COUNT(*) AS "GamesCount"
FROM videogames
WHERE software_house_id = 1
    AND YEAR(release_date) = 2018;

-- 11- Selezionare il numero e la media delle recensioni 
-- per il videogioco con ID = 412 (review number = 12, avg_rating = 3)
SELECT 
    COUNT(*) AS "ReviewsCount", 
    AVG(rating) AS "AverageRating"
FROM reviews
WHERE videogame_id = 412;

-- 10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, 
-- mostrandoli una sola volta (443)
SELECT DISTINCT videogame_id
FROM reviews
WHERE rating = 5;

-- 9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
SELECT *
FROM videogames
WHERE YEAR(release_date) = 2020;

-- 8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
SELECT *
FROM reviews
WHERE rating BETWEEN 2 AND 4;

-- 7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG),
-- mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
SELECT DISTINCT videogame_id
FROM category_videogame
WHERE category_id = 2
    OR category_id = 6;

-- 6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
SELECT *
FROM awards
WHERE description LIKE '%facere%';

-- 5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
SELECT COUNT(*) AS "TournamentsCount"
FROM tournaments
WHERE year = 2015;

-- 4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
SELECT *
FROM reviews
WHERE player_id = 800;

-- 3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
SELECT *
FROM players
WHERE name LIKE '%a';

-- 2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
SELECT *
FROM players
WHERE city = 'Rogahnland';

-- 1- Selezionare tutte le software house americane (3)
SELECT *
FROM software_houses
WHERE country = 'United States';