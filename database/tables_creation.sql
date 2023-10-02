-- Table: onboarding_schema.users

-- DROP TABLE IF EXISTS onboarding_schema.users;

CREATE TABLE IF NOT EXISTS onboarding_schema.users
(
    id integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT users_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.users
    OWNER to postgres;
	
	
-- Table: onboarding_schema.items

-- DROP TABLE IF EXISTS onboarding_schema.items;

CREATE TABLE IF NOT EXISTS onboarding_schema.items
(
    id integer NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT items_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.items
    OWNER to postgres;
	
-- Table: onboarding_schema.purchases

-- DROP TABLE IF EXISTS onboarding_schema.purchases;

CREATE TABLE IF NOT EXISTS onboarding_schema.purchases
(
    "user" integer NOT NULL,
    item integer NOT NULL,
    CONSTRAINT purchases_pkey PRIMARY KEY ("user", item),
    CONSTRAINT item_bought FOREIGN KEY (item)
        REFERENCES onboarding_schema.items (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_who_bought FOREIGN KEY ("user")
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.purchases
    OWNER to postgres;
	
	
	
-- Table: onboarding_schema.mark_as_favourite

-- DROP TABLE IF EXISTS onboarding_schema.mark_as_favourite;

CREATE TABLE IF NOT EXISTS onboarding_schema.mark_as_favourite
(
    "user" integer NOT NULL,
    item integer NOT NULL,
    CONSTRAINT mark_as_favourite_pkey PRIMARY KEY ("user", item),
    CONSTRAINT item_marked_as_favourite FOREIGN KEY (item)
        REFERENCES onboarding_schema.items (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_who_marked_as_favourite FOREIGN KEY ("user")
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.mark_as_favourite
    OWNER to postgres;
	
	
-- Table: onboarding_schema.followers

-- DROP TABLE IF EXISTS onboarding_schema.followers;

CREATE TABLE IF NOT EXISTS onboarding_schema.followers
(
    follower integer NOT NULL,
    followed_user integer NOT NULL,
    CONSTRAINT followers_pkey PRIMARY KEY (follower, followed_user),
    CONSTRAINT user_being_followed FOREIGN KEY (followed_user)
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_who_follows FOREIGN KEY (follower)
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.followers
    OWNER to postgres;
	
-- Table: onboarding_schema.shared_items

-- DROP TABLE IF EXISTS onboarding_schema.shared_items;

CREATE TABLE IF NOT EXISTS onboarding_schema.shared_items
(
    sender_user integer NOT NULL,
    receiver_user integer NOT NULL,
    item_shared integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    CONSTRAINT shared_items_pkey PRIMARY KEY (sender_user, receiver_user, item_shared, "timestamp"),
    CONSTRAINT item_shared FOREIGN KEY (item_shared)
        REFERENCES onboarding_schema.items (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT receiver_user FOREIGN KEY (receiver_user)
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sender_user FOREIGN KEY (sender_user)
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.shared_items
    OWNER to postgres;
	

-- Table: onboarding_schema.comments

-- DROP TABLE IF EXISTS onboarding_schema.comments;

CREATE TABLE IF NOT EXISTS onboarding_schema.comments
(
    user_sender integer NOT NULL,
    user_receiver integer NOT NULL,
    item_commented integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    CONSTRAINT comments_pkey PRIMARY KEY (user_sender, user_receiver, item_commented, "timestamp"),
    CONSTRAINT has_been_marked_as_favourite FOREIGN KEY (item_commented, user_receiver)
        REFERENCES onboarding_schema.mark_as_favourite (item, "user") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT user_who_commented FOREIGN KEY (user_sender)
        REFERENCES onboarding_schema.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS onboarding_schema.comments
    OWNER to postgres;