-- Keep a log of any SQL queries you execute as you solve the mystery.
SELECT description FROM crime_scene_reports
   ...> WHERE year = 2021 AND month = 7 AND day = 28 AND street = "Humphrey Street";

-- Theft of the CS50 duck took place at 10:15am at the Humphrey Street bakery.

SELECT transcript FROM interviews
   ...> WHERE year = 2021 AND month = 7 AND day = 28 AND transcript LIKE "%bakery%";

-- First transcript!
--Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot 
--and drive away. If you have security footage from the bakery parking lot,
-- you might want to look for cars that left the parking lot in that time frame.

-- Second transcript!
--I don't know the thief's name, but it was someone I recognized. 
--Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.

-- Third transcript!
--As the thief was leaving the bakery, they called someone who talked to them for less than a minute. 
--In the call, I heard the thief say that they were planning to take the earliest 
--flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone 
--to purchase the flight ticket.

SELECT name FROM people
   ...> JOIN bakery_security_logs ON bakery_security_logs.license_plate = peopl
e.license_plate
   ...> WHERE year = 2021 AND month = 7 AND day = 28 AND hour = 10 AND minute >= 15 AND minute <= 25
   ...> AND activity = "exit";

-- Suspects:Vanessa, Bruce, Barry, Luca, Sofia, Iman, Diana, Kelsey

SELECT name FROM people
   ...> JOIN bank_accounts ON bank_accounts.person_id = people.id
   ...> JOIN atm_transactions ON atm_transactions.account_number = bank_accounts.account_number
   ...> WHERE year = 2021 AND month = 7 AND day = 28 AND atm_location = "Leggett Street" AND
   ...> transaction_type = "withdraw";

-- Common suspects: Bruce, Diana, Iman, Luca,

-- FLIGHT.
SELECT name FROM people
   ...> JOIN passengers ON passengers.passport_number = people.passport_number
   ...> WHERE passengers.flight_id = (
   ...> SELECT id FROM flights
   ...> WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (
   ...> SELECT id FROM airports WHERE city = "Fiftyville")
   ...> ORDER BY hour,minute
   ...> LIMIT 1);

-- Common suspects second search: Bruce, Luca. 

SELECT name FROM people
   ...> JOIN phone_calls ON phone_calls.caller = people.phone_number
   ...> WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60;

-- Phone Call: Bruce

SELECT city FROM airports
   ...> WHERE id = (SELECT destination_airport_id FROM flights
   ...> WHERE year = 2021 AND month = 7 AND day = 29 AND origin_airport_id = (
   ...> SELECT id FROM airports WHERE city = "Fiftyville")
   ...> ORDER BY hour,  minute
   ...> LIMIT 1);

-- The city the thief ESCAPED TO : New York City

-- ACCOMPLICE: Robin
 SELECT phone_number FROM people WHERE name = "Bruce";
(367) 555-5533
SELECT name FROM people WHERE phone_number = (
   ...> SELECT receiver FROM phone_calls
   ...> WHERE year = 2021 AND month = 7 AND day = 28 AND duration < 60 AND call
er = "(367) 555-5533");



