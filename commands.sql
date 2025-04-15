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