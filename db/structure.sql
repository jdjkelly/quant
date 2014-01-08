--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: fitbit_accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE fitbit_accounts (
    id integer NOT NULL,
    uid character varying(255),
    oauth_token character varying(255),
    oauth_token_secret character varying(255),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: fitbit_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE fitbit_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: fitbit_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE fitbit_accounts_id_seq OWNED BY fitbit_accounts.id;


--
-- Name: meals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE meals (
    id integer NOT NULL,
    date timestamp without time zone,
    calories integer,
    carbohydrates integer,
    protein integer,
    fat integer,
    user_id integer,
    description character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: meals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meals_id_seq OWNED BY meals.id;


--
-- Name: moods; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE moods (
    id integer NOT NULL,
    date timestamp without time zone,
    user_id integer,
    rating numeric,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: moods_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE moods_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE moods_id_seq OWNED BY moods.id;


--
-- Name: places; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE places (
    id integer NOT NULL,
    user_id integer,
    date timestamp without time zone,
    lat numeric,
    lng numeric,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: places_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE places_id_seq OWNED BY places.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    confirmation_token character varying(255),
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying(255),
    failed_attempts integer DEFAULT 0,
    unlock_token character varying(255),
    locked_at timestamp without time zone,
    name character varying(255),
    height double precision,
    authentication_token character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: weights; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE weights (
    id integer NOT NULL,
    type character varying(255),
    user_id integer,
    bmi double precision,
    value double precision,
    lean_mass double precision,
    fat_mass double precision,
    fat_percent double precision,
    date timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    meta hstore,
    source character varying(255)
);


--
-- Name: weights_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE weights_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: weights_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE weights_id_seq OWNED BY weights.id;


--
-- Name: withings_accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE withings_accounts (
    id integer NOT NULL,
    userid character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    oauth_token character varying(255),
    user_id integer,
    oauth_token_secret character varying(255),
    synced_at timestamp without time zone
);


--
-- Name: withings_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE withings_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: withings_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE withings_accounts_id_seq OWNED BY withings_accounts.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY fitbit_accounts ALTER COLUMN id SET DEFAULT nextval('fitbit_accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meals ALTER COLUMN id SET DEFAULT nextval('meals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY moods ALTER COLUMN id SET DEFAULT nextval('moods_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY places ALTER COLUMN id SET DEFAULT nextval('places_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY weights ALTER COLUMN id SET DEFAULT nextval('weights_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY withings_accounts ALTER COLUMN id SET DEFAULT nextval('withings_accounts_id_seq'::regclass);


--
-- Name: fitbit_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY fitbit_accounts
    ADD CONSTRAINT fitbit_accounts_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY places
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: meals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- Name: moods_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY moods
    ADD CONSTRAINT moods_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weights_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY weights
    ADD CONSTRAINT weights_pkey PRIMARY KEY (id);


--
-- Name: withings_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY withings_accounts
    ADD CONSTRAINT withings_accounts_pkey PRIMARY KEY (id);


--
-- Name: index_fitbit_accounts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_fitbit_accounts_on_user_id ON fitbit_accounts USING btree (user_id);


--
-- Name: index_meals_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_meals_on_user_id ON meals USING btree (user_id);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_authentication_token ON users USING btree (authentication_token);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON users USING btree (unlock_token);


--
-- Name: index_weights_on_meta; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_weights_on_meta ON weights USING gist (meta);


--
-- Name: index_weights_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_weights_on_user_id ON weights USING btree (user_id);


--
-- Name: index_withings_accounts_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_withings_accounts_on_user_id ON withings_accounts USING btree (user_id);


--
-- Name: locations_earthdistance_ix; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX locations_earthdistance_ix ON places USING gist (ll_to_earth((lat)::double precision, (lng)::double precision));


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20130310155705');

INSERT INTO schema_migrations (version) VALUES ('20130310195028');

INSERT INTO schema_migrations (version) VALUES ('20130311013450');

INSERT INTO schema_migrations (version) VALUES ('20130312014452');

INSERT INTO schema_migrations (version) VALUES ('20130316044213');

INSERT INTO schema_migrations (version) VALUES ('20130323044051');

INSERT INTO schema_migrations (version) VALUES ('20130323055451');

INSERT INTO schema_migrations (version) VALUES ('20130324040455');

INSERT INTO schema_migrations (version) VALUES ('20130330165127');

INSERT INTO schema_migrations (version) VALUES ('20130420171616');

INSERT INTO schema_migrations (version) VALUES ('20130420202841');

INSERT INTO schema_migrations (version) VALUES ('20130507025853');

INSERT INTO schema_migrations (version) VALUES ('20130514040006');

INSERT INTO schema_migrations (version) VALUES ('20130605043956');

INSERT INTO schema_migrations (version) VALUES ('20130608214958');

INSERT INTO schema_migrations (version) VALUES ('20130615173023');

INSERT INTO schema_migrations (version) VALUES ('20130615174058');

INSERT INTO schema_migrations (version) VALUES ('20130622044752');

INSERT INTO schema_migrations (version) VALUES ('20130622161730');

INSERT INTO schema_migrations (version) VALUES ('20130622203100');

INSERT INTO schema_migrations (version) VALUES ('20130728222444');

INSERT INTO schema_migrations (version) VALUES ('20130728222738');

INSERT INTO schema_migrations (version) VALUES ('20130803051622');

INSERT INTO schema_migrations (version) VALUES ('20130803162630');

INSERT INTO schema_migrations (version) VALUES ('20130803175122');

INSERT INTO schema_migrations (version) VALUES ('20130803175510');

INSERT INTO schema_migrations (version) VALUES ('20130816020401');

INSERT INTO schema_migrations (version) VALUES ('20130819210218');

INSERT INTO schema_migrations (version) VALUES ('20131231024056');
