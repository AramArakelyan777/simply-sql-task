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

-- List makes that have at least one car with the 'GPS' feature.
SELECT
    `name` AS make_name
FROM
    makes
WHERE
    EXISTS (
        SELECT
            1
        FROM
            models
            JOIN cars ON cars.model_id = models.id
            JOIN car_features ON car_features.car_id = cars.id
            JOIN features ON features.id = car_features.feature_id
        WHERE
            models.make_id = makes.id
            AND features.name = 'GPS'
    );

-- Retrieve cars from models that have no features assigned (use a NOT EXISTS subquery).
SELECT
    models.name
FROM
    models
    JOIN cars ON models.id = cars.model_id
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            car_features
        WHERE
            car_features.car_id = cars.id
    );