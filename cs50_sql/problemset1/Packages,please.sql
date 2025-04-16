-- *** The Lost Letter ***
-- From: 900 Somerville Avenue, To: 2 Finnegan Street, uptown
-- Find type of address
SELECT "type" FROM "addresses"
WHERE "id" = (
    -- Finding address id where package is
    SELECT "address_id" FROM "scans"
    WHERE "package_id" = (
        -- Finding the package id
        SELECT "id" FROM "packages"
        WHERE "from_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '900 Somerville Avenue'
        )
        AND "to_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '2 Finnigan Street'
        )
    )
    ORDER BY "timestamp" DESC
    LIMIT 1
);


SELECT "address" FROM "addresses"
WHERE "id" = (
    -- Finding address id where package is
    SELECT "address_id" FROM "scans"
    WHERE "package_id" = (
        -- Finding the package id
        SELECT "id" FROM "packages"
        WHERE "from_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '900 Somerville Avenue'
        )
        AND "to_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '2 Finnigan Street'
        )
    )
    ORDER BY "timestamp" DESC
    LIMIT 1
);




-- *** The Devious Delivery ***
-- Find parcels that got sent with no from address
SELECT * FROM "packages"
WHERE "from_address_id" IS NULL;


-- type of address pacakge ended up
SELECT "type" FROM "addresses"
WHERE "id" = (
    SELECT "to_address_id" FROM "packages"
    WHERE "from_address_id" IS NULL
);

SELECT * FROM "addresses"
WHERE "id" = (
    SELECT "address_id" FROM "scans"
    WHERE "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "from_address_id" IS NULL
    ) ORDER BY "timestamp" DESC
    LIMIT 1
);



-- Contents of Devious delivery
SELECT "contents" FROM "packages"
WHERE "from_address_id" IS NULL;


-- *** The Forgotten Gift ***
-- to: 728 Maple Place, from: 109 Tileston Street
-- contents of the forgotten package
SELECT "contents" FROM "packages"
WHERE "from_address_id" = (
    SELECT "id" FROM "addresses"
    WHERE "address" = '109 Tileston Street'
) AND "to_address_id" = (
    SELECT "id" FROM "addresses"
    WHERE "address" = '728 Maple Place'
);

-- who has the forgotten gift


SELECT "name" FROM "drivers"
WHERE "id" = (
    SELECT "driver_id" FROM "scans"
    WHERE "package_id" = (
        SELECT "id" FROM "packages"
        WHERE "from_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '109 Tileston Street'
        ) AND "to_address_id" = (
            SELECT "id" FROM "addresses"
            WHERE "address" = '728 Maple Place'
        )
    ) ORDER BY "timestamp" DESC
    LIMIT 1
);



