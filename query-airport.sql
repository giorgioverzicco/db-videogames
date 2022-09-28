-- Query su singola tabella

-- 12- Contare quanti voli sono partiti il 4 luglio 2019 (3)
SELECT COUNT(*) AS "flights_count"
FROM flights
WHERE CAST(departure_datetime AS DATE) = '2019-07-04';

-- 11- contare tutti gli aeroporti la cui città inizia per 'East' (7)
SELECT COUNT(*) AS "airport_count"
FROM airports
WHERE city LIKE 'East%';

-- 10- Selezionare tutti i passeggeri nati nel 1960 (11)
SELECT *
FROM passengers
WHERE YEAR(date_of_birth) = 1960;

-- 9- Selezionare tutti i passeggeri il cui nome inizia con 'Al' (26)
SELECT *
FROM passengers
WHERE name LIKE 'Al%';

-- 8- Selezionare tutti gli ID dei dipendenti che hanno lasciato almeno 
-- una compagnia aerea prima del 2006 (493)
SELECT id
FROM airline_employee
WHERE YEAR(layoff_date) < 2006;

-- 7- Selezionare tutti gli ID dei dipendenti che hanno lasciato almeno una compagnia aerea (31077)
SELECT id
FROM airline_employee
WHERE layoff_date IS NOT NULL;

-- 6- Selezionare tutti gli aerei che hanno un numero di posti compreso tra 350 e 700 (30)
SELECT *
FROM airplanes
WHERE seating_capacity BETWEEN 350 AND 700;

-- 5- Selezionare tutti gli aerei che hanno piu' di 200 posti (84)
SELECT *
FROM airplanes
WHERE seating_capacity > 200;

-- 4- Selezionare tutti i passeggeri minorenni (considerando solo l'anno di nascita) (115 - nel 2022)
SELECT *
FROM passengers
WHERE (2022 - YEAR(date_of_birth)) < 18;

-- 3- Selezionare tutti i passeggeri che hanno come cognome 'Bartell' (2)
SELECT *
FROM passengers
WHERE lastname LIKE 'Bartell%';

-- 2- Selezionare tutti i nomi degli aeroporti, ordinati per nome (100)
SELECT name
FROM airports
ORDER BY name;

-- 1- Selezionare tutti i passeggeri (1000)
SELECT *
FROM passengers;