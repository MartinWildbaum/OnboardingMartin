--Fetch all the favourite items for a given user
SELECT i.name
FROM onboarding_schema.users as u, onboarding_schema.mark_as_favourite as fav, onboarding_schema.items i
Where u.name = 'John Doe' and u.id = fav.user and fav.item = i.id

--Fetch all users together with their favourite items, even if the user doesn't have any items
SELECT u.name, i.name AS favorite_item
FROM onboarding_schema.users AS u
LEFT JOIN onboarding_schema.mark_as_favourite AS fav ON u.id = fav."user"
LEFT JOIN onboarding_schema.items AS i ON fav.item = i.id
ORDER BY u.name;


-- Get the number of users without favourite items
SELECT COUNT(*) as users_without_favourite_items
FROM onboarding_schema.users as u
LEFT JOIN onboarding_schema.mark_as_favourite as fav ON u.id = fav.user
WHERE fav.user ISNULL;


-- Fetch the name of the users that have more than five followers and some non bought favourite items
