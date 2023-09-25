--Fetch all the favourite items for a given user
SELECT i.name
FROM onboarding_schema.users as u, onboarding_schema.mark_as_favourite as fav, onboarding_schema.items i
Where u.name = 'John Doe' and u.id = fav."user" and fav.item = i.id

--Fetch all users together with their favourite items, even if the user doesn't have any items
SELECT u.name, i.name AS favorite_item
FROM (onboarding_schema.users AS u LEFT JOIN onboarding_schema.mark_as_favourite AS fav ON u.id = fav."user") LEFT JOIN onboarding_schema.items AS i ON fav.item = i.id
ORDER BY u.name;


-- Get the number of users without favourite items
SELECT COUNT(*) AS users_without_favourite_items
FROM onboarding_schema.users as u LEFT JOIN onboarding_schema.mark_as_favourite as fav ON u.id = fav."user"
WHERE fav.item ISNULL;


-- Fetch the name of the users that have more than five followers and some non bought favourite items
SELECT DISTINCT u.name
FROM (onboarding_schema.users AS u LEFT JOIN onboarding_schema.mark_as_favourite as mfav ON u.id = mfav.user) LEFT JOIN onboarding_schema.purchases as p ON (mfav.user = p.user and mfav.item = p.item)
WHERE u.id IN (
	SELECT f.followed_user
	FROM onboarding_schema.followers as f
	GROUP BY f.followed_user
	HAVING COUNT(*) > 5
) AND (NOT mfav.item ISNULL AND p.item ISNULL);


-- Steps to achive the result
-- Select people who are followed by more than five people (Martin Wildbaum)
SELECT f.followed_user
FROM onboarding_schema.followers as f
GROUP BY f.followed_user
HAVING COUNT(*) > 5;

SELECT *
FROM (onboarding_schema.users AS u LEFT JOIN onboarding_schema.mark_as_favourite as mfav ON u.id = mfav.user) LEFT JOIN onboarding_schema.purchases as p ON (mfav.user = p.user and mfav.item = p.item)
