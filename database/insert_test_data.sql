-- INSERT TEST DATA
-- Inserting data into the "users" table
INSERT INTO onboarding_schema.users (id, name) VALUES
(5, 'Nicolas Wildbaum'),
(6, 'Deborah Laufer'),
(7, 'Micaela Wildbaum');


-- Inserting data into the "items" table
INSERT INTO onboarding_schema.items (id, name) VALUES
(101, 'Item A'),
(102, 'Item B'),
(103, 'Item C');

-- Inserting data into the "purchases" table
INSERT INTO onboarding_schema.purchases ("user", item) VALUES
(4, 102),
(2, 102),
(3, 103),
(1, 102),
(2, 101);

-- Inserting data into the "mark_as_favourite" table
INSERT INTO onboarding_schema.mark_as_favourite ("user", item) VALUES
(4, 101),
(2, 101),
(3, 103);

-- Inserting data into the "followers" table
INSERT INTO onboarding_schema.followers (follower, followed_user) VALUES
(1, 5),
(2, 5),
(3, 5),
(4, 5),
(5, 5),
(6, 5);

-- Inserting data into the "shared_items" table
INSERT INTO onboarding_schema.shared_items (sender_user, receiver_user, item_shared, "timestamp") VALUES
(1, 2, 101, NOW()),
(2, 3, 102, NOW()),
(3, 1, 103, NOW());

-- Inserting data into the "comments" table
INSERT INTO onboarding_schema.comments (user_sender, user_receiver, item_commented, "timestamp") VALUES
(1, 2, 101, NOW()),
(2, 1, 102, NOW()),
(3, 1, 101, NOW());
