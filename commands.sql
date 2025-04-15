-- Calculate the average price of cars for each model, ordered by average price descending.
SELECT
    makes.name,
    models.name as model,
    AVG(cars.price) as average_price
FROM
    cars
    INNER JOIN models ON cars.model_id = models.id
    INNER JOIN makes ON makes.id = models.make_id
GROUP BY
    models.name,
    makes.name
ORDER BY
    average_price DESC;

-- Find the oldest and newest car years for each make.
SELECT
    makes.id,
    makes.name,
    min(cars.year) AS oldest,
    max(cars.year) AS newest
FROM
    makes
    INNER JOIN models ON makes.id = models.make_id
    INNER JOIN cars ON models.id = cars.model_id
GROUP BY
    makes.name,
    makes.id
ORDER BY
    makes.id;

-- List models with more than 1 car, along with the count of cars.
SELECT
    name,
    COUNT(models.name) AS `count`
FROM
    models
    INNER JOIN cars ON models.id = cars.model_id
GROUP BY
    models.name
HAVING
    `count` > 1;