--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: onboarding_schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA onboarding_schema;


ALTER SCHEMA onboarding_schema OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comments; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.comments (
    user_sender integer NOT NULL,
    user_receiver integer NOT NULL,
    item_commented integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE onboarding_schema.comments OWNER TO postgres;

--
-- Name: followers; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.followers (
    follower integer NOT NULL,
    followed_user integer NOT NULL
);


ALTER TABLE onboarding_schema.followers OWNER TO postgres;

--
-- Name: items; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.items (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE onboarding_schema.items OWNER TO postgres;

--
-- Name: mark_as_favourite; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.mark_as_favourite (
    "user" integer NOT NULL,
    item integer NOT NULL
);


ALTER TABLE onboarding_schema.mark_as_favourite OWNER TO postgres;

--
-- Name: purchases; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.purchases (
    "user" integer NOT NULL,
    item integer NOT NULL
);


ALTER TABLE onboarding_schema.purchases OWNER TO postgres;

--
-- Name: shared_items; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.shared_items (
    sender_user integer NOT NULL,
    receiver_user integer NOT NULL,
    item_shared integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE onboarding_schema.shared_items OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: onboarding_schema; Owner: postgres
--

CREATE TABLE onboarding_schema.users (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE onboarding_schema.users OWNER TO postgres;

--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (user_sender, user_receiver, item_commented, "timestamp");


--
-- Name: followers followers_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.followers
    ADD CONSTRAINT followers_pkey PRIMARY KEY (follower, followed_user);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: mark_as_favourite mark_as_favourite_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.mark_as_favourite
    ADD CONSTRAINT mark_as_favourite_pkey PRIMARY KEY ("user", item);


--
-- Name: purchases purchases_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY ("user", item);


--
-- Name: shared_items shared_items_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.shared_items
    ADD CONSTRAINT shared_items_pkey PRIMARY KEY (sender_user, receiver_user, item_shared, "timestamp");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: purchases item_bought; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.purchases
    ADD CONSTRAINT item_bought FOREIGN KEY (item) REFERENCES onboarding_schema.items(id);


--
-- Name: mark_as_favourite item_marked_as_favourite; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.mark_as_favourite
    ADD CONSTRAINT item_marked_as_favourite FOREIGN KEY (item) REFERENCES onboarding_schema.items(id);


--
-- Name: shared_items item_shared; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.shared_items
    ADD CONSTRAINT item_shared FOREIGN KEY (item_shared) REFERENCES onboarding_schema.items(id);


--
-- Name: comments itme_commented_about; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.comments
    ADD CONSTRAINT itme_commented_about FOREIGN KEY (item_commented) REFERENCES onboarding_schema.items(id);


--
-- Name: shared_items receiver_user; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.shared_items
    ADD CONSTRAINT receiver_user FOREIGN KEY (receiver_user) REFERENCES onboarding_schema.users(id);


--
-- Name: shared_items sender_user; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.shared_items
    ADD CONSTRAINT sender_user FOREIGN KEY (sender_user) REFERENCES onboarding_schema.users(id);


--
-- Name: followers user_being_followed; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.followers
    ADD CONSTRAINT user_being_followed FOREIGN KEY (followed_user) REFERENCES onboarding_schema.users(id);


--
-- Name: purchases user_who_bought; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.purchases
    ADD CONSTRAINT user_who_bought FOREIGN KEY ("user") REFERENCES onboarding_schema.users(id);


--
-- Name: comments user_who_commented; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.comments
    ADD CONSTRAINT user_who_commented FOREIGN KEY (user_sender) REFERENCES onboarding_schema.users(id);


--
-- Name: followers user_who_follows; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.followers
    ADD CONSTRAINT user_who_follows FOREIGN KEY (follower) REFERENCES onboarding_schema.users(id);


--
-- Name: mark_as_favourite user_who_marked_as_favourite; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.mark_as_favourite
    ADD CONSTRAINT user_who_marked_as_favourite FOREIGN KEY ("user") REFERENCES onboarding_schema.users(id);


--
-- Name: comments user_who_received_the_comment; Type: FK CONSTRAINT; Schema: onboarding_schema; Owner: postgres
--

ALTER TABLE ONLY onboarding_schema.comments
    ADD CONSTRAINT user_who_received_the_comment FOREIGN KEY (user_receiver) REFERENCES onboarding_schema.users(id);


--
-- PostgreSQL database dump complete
--

