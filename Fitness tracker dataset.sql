Create Database Fitness_tracker;
Use Fitness_tracker; 

--  1.CREATE TABLE Users 
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    join_date DATE
);

-- 2.CREATE TABLE Workouts
CREATE TABLE Workouts (
    workout_id INT PRIMARY KEY,
    workout_name VARCHAR(50),
    type VARCHAR(30),         -- e.g., Strength, Cardio
    muscle_group VARCHAR(30)  -- e.g., Forearms, Back, Legs
);

-- 3.CREATE TABLE Workout_Log
CREATE TABLE Workout_Log (
    log_id INT PRIMARY KEY,
    user_id INT,
    workout_id INT,
    workout_date DATE,
    duration_mins INT,
    calories_burned INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id)
);

-- 4.CREATE TABLE Progress_Stats
CREATE TABLE Progress_Stats (
    progress_id INT PRIMARY KEY,
    user_id INT,
    stat_date DATE,
    body_part VARCHAR(30),
    measurement_cm DECIMAL(5,2),  -- e.g., forearm: 27.5 cm
    body_fat_pct DECIMAL(4,1),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Data Inserts
-- 1. Users
INSERT INTO Users (user_id, name, age, gender, join_date) VALUES
(1, 'Aarav Mehta', 28, 'Male', '2024-01-15'),
(2, 'Sneha Rao', 24, 'Female', '2024-02-20'),
(3, 'Rohan Das', 32, 'Male', '2023-12-10'),
(4, 'Neha Singh', 29, 'Female', '2024-03-01'),
(5, 'Vikram Patel', 35, 'Male', '2024-01-05');

-- 2. Workouts
INSERT INTO Workouts (workout_id, workout_name, type, muscle_group) VALUES
(1, 'Deadlift', 'Strength', 'Back'),
(2, 'Treadmill', 'Cardio', 'Legs'),
(3, 'Bicep Curl', 'Strength', 'Arms'),
(4, 'Jump Rope', 'Cardio', 'Full Body'),
(5, 'Leg Press', 'Strength', 'Legs');

-- 3. Workout_Log
INSERT INTO Workout_Log (log_id, user_id, workout_id, workout_date, duration_mins, calories_burned) VALUES
(1, 1, 1, '2024-07-10', 45, 350),
(2, 2, 2, '2024-07-10', 30, 250),
(3, 3, 4, '2024-07-11', 20, 180),
(4, 4, 5, '2024-07-11', 40, 300),
(5, 5, 3, '2024-07-12', 25, 200);

-- 4. Progress_Stats
INSERT INTO Progress_Stats (progress_id, user_id, stat_date, body_part, measurement_cm, body_fat_pct) VALUES
(1, 1, '2024-07-01', 'Waist', 85.0, 17.5),
(2, 2, '2024-07-01', 'Arm', 28.0, 21.0),
(3, 3, '2024-07-01', 'Chest', 98.0, 15.0),
(4, 4, '2024-07-01', 'Thigh', 55.0, 19.0),
(5, 5, '2024-07-01', 'Waist', 90.0, 20.5);

-- Total Calories Burned by Muscle Group:
SELECT w.muscle_group, SUM(wl.calories_burned) AS total_calories
FROM Workout_Log wl
JOIN Workouts w ON wl.workout_id = w.workout_id
GROUP BY w.muscle_group;

-- Track Progress in Body Fat Over Time :
SELECT stat_date, body_fat_pct
FROM Progress_Stats
WHERE user_id = 1
ORDER BY stat_date;

-- Most Frequent Workouts:
SELECT w.workout_name, COUNT(*) AS frequency
FROM Workout_Log wl
JOIN Workouts w ON wl.workout_id = w.workout_id
GROUP BY w.workout_name
ORDER BY frequency DESC;

-- Workout Types Distribution (Strength vs Cardio):
SELECT w.type, COUNT(*) AS total_sessions
FROM Workout_Log wl
JOIN Workouts w ON wl.workout_id = w.workout_id
GROUP BY w.type;

-- Most Targeted Muscle Groups:
SELECT muscle_group, COUNT(*) AS workout_count
FROM Workouts
GROUP BY muscle_group
ORDER BY workout_count DESC;
