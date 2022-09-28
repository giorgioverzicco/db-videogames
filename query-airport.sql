-- Query con group by

-- 9- Selezionare gli impiegati che non hanno mai cambiato compagnia aerea per cui lavorano (1061)
SELECT *
FROM airline_employee
WHERE layoff_date IS NULL;
-- FIXME

-- 8- Contare quante manutenzioni ha ricevuto ciascun 
-- aereo nel 2021 (dell'aereo vogliamo solo l'ID) (36)
SELECT
    airplane_id,
    COUNT(*) AS "maintenance_works_count"
FROM maintenance_works
WHERE YEAR(datetime) = 2021
GROUP BY airplane_id;

-- 7- Per ogni manufacturer, trovare l'aereo con maggior numero di posti a sedere (8)
SELECT 
    manufacturer, 
    MAX(seating_capacity) AS "max_seating_capacity"
FROM airplanes
GROUP BY manufacturer
ORDER BY MAX(seating_capacity) DESC;

-- 6- Contare quanti voli ci sono stati ogni anno (tenendo conto della data di partenza) (11)
SELECT
    YEAR(departure_datetime) AS "departure_year",
    COUNT(*) AS "flights_count"
FROM flights
GROUP BY YEAR(departure_datetime);

-- 5- Contare quanti passeggeri sono nati nello stesso anno (61)
SELECT 
    YEAR(date_of_birth) AS "year_of_birth", 
    COUNT(*) AS "passengers_count"
FROM passengers
GROUP BY YEAR(date_of_birth);

-- 4- Ordinare gli aerei per numero di manutenzioni ricevute 
-- (da quello che ne ha di piu'; dell'aereo vogliamo solo l'ID) (100)
SELECT 
    airplane_id, 
    COUNT(*) AS "maintenance_works_count"
FROM maintenance_works
GROUP BY airplane_id
ORDER BY COUNT(*) DESC;

-- 3- Contare per ogni volo il numero di passeggeri (del volo vogliamo solo l'ID) (1000)
SELECT 
    COUNT(*) as "passengers_count",
    passenger_id
FROM flight_passenger
GROUP BY passenger_id;


-- 2- Contare quante volte ogni impiegato ha lasciato una compagnia aerea 
-- (non mostrare quelli che non hanno mai lasciato; dell'impiegato vogliamo solo l'ID) (8939)
SELECT 
    COUNT(*) AS "employees_count",
    employee_id
FROM airline_employee
WHERE layoff_date IS NOT NULL
GROUP BY employee_id;

-- 1- Contare quanti lavori di manutenzione ha eseguito ogni 
-- impiegato (dell'impiegato vogliamo solo l'ID) (1136)
SELECT 
    COUNT(*) AS "maintenance_works_count",
    employee_id
FROM employee_maintenance_work
GROUP BY employee_id;

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