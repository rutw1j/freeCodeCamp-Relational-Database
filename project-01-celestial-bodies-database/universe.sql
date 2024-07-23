--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: discovery; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.discovery (
    discovery_id integer NOT NULL,
    name character varying(30) NOT NULL,
    discovered_object_type character varying(10) NOT NULL,
    discovered_object_id integer NOT NULL,
    discovery_date date NOT NULL,
    discovery_details text,
    CONSTRAINT discovery_discovered_object_type_check CHECK (((discovered_object_type)::text = ANY ((ARRAY['galaxy'::character varying, 'star'::character varying, 'planet'::character varying, 'moon'::character varying])::text[])))
);


ALTER TABLE public.discovery OWNER TO freecodecamp;

--
-- Name: discovery_discovery_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.discovery_discovery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.discovery_discovery_id_seq OWNER TO freecodecamp;

--
-- Name: discovery_discovery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.discovery_discovery_id_seq OWNED BY public.discovery.discovery_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    diameter_in_light_years integer NOT NULL,
    has_stars boolean NOT NULL,
    estimated_age_in_millions_of_years integer NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    estimated_radius_km numeric(20,4) NOT NULL,
    distance_from_planet_km numeric(20,4) NOT NULL,
    planet_id integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    has_moons boolean NOT NULL,
    no_of_moons integer NOT NULL,
    estimated_radius_km numeric(20,4),
    star_id integer NOT NULL
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    description text,
    has_planets boolean NOT NULL,
    no_of_planets integer NOT NULL,
    solar_mass numeric(20,4),
    galaxy_id integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: discovery discovery_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.discovery ALTER COLUMN discovery_id SET DEFAULT nextval('public.discovery_discovery_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: discovery; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.discovery VALUES (1, 'Galaxy-01', 'galaxy', 1, '1810-01-01', 'Details About Discovery 1');
INSERT INTO public.discovery VALUES (2, 'Galaxy-02', 'galaxy', 2, '1820-02-02', 'Details About Discovery 2');
INSERT INTO public.discovery VALUES (3, 'Galaxy-03', 'galaxy', 3, '1830-03-03', 'Details About Discovery 3');
INSERT INTO public.discovery VALUES (4, 'Galaxy-04', 'galaxy', 4, '1840-04-04', 'Details About Discovery 4');
INSERT INTO public.discovery VALUES (5, 'Star-01', 'star', 1, '1810-01-01', 'Details About Discovery 5');
INSERT INTO public.discovery VALUES (6, 'Star-02', 'star', 2, '1820-02-02', 'Details About Discovery 6');
INSERT INTO public.discovery VALUES (7, 'Star-03', 'star', 3, '1830-03-03', 'Details About Discovery 7');
INSERT INTO public.discovery VALUES (8, 'Star-04', 'star', 4, '1840-04-04', 'Details About Discovery 8');
INSERT INTO public.discovery VALUES (9, 'Planet-01', 'planet', 1, '1810-01-01', 'Details About Discovery 9');
INSERT INTO public.discovery VALUES (10, 'Planet-02', 'planet', 2, '1820-02-02', 'Details About Discovery 10');
INSERT INTO public.discovery VALUES (11, 'Planet-03', 'planet', 3, '1830-03-03', 'Details About Discovery 11');
INSERT INTO public.discovery VALUES (12, 'Planet-04', 'planet', 4, '1840-04-04', 'Details About Discovery 12');
INSERT INTO public.discovery VALUES (13, 'Moon-01', 'moon', 1, '1810-01-01', 'Details About Discovery 13');
INSERT INTO public.discovery VALUES (14, 'Moon-02', 'moon', 2, '1820-02-02', 'Details About Discovery 14');
INSERT INTO public.discovery VALUES (15, 'Moon-03', 'moon', 3, '1830-03-03', 'Details About Discovery 15');
INSERT INTO public.discovery VALUES (16, 'Moon-04', 'moon', 4, '1840-04-04', 'Details About Discovery 16');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Galaxy-1', 'Description of Galaxy-1', 100000, true, 1000);
INSERT INTO public.galaxy VALUES (2, 'Galaxy-2', 'Description of Galaxy-2', 200000, true, 2000);
INSERT INTO public.galaxy VALUES (3, 'Galaxy-3', 'Description of Galaxy-3', 300000, true, 3000);
INSERT INTO public.galaxy VALUES (4, 'Galaxy-4', 'Description of Galaxy-4', 400000, true, 4000);
INSERT INTO public.galaxy VALUES (5, 'Galaxy-5', 'Description of Galaxy-5', 500000, true, 5000);
INSERT INTO public.galaxy VALUES (6, 'Galaxy-6', 'Description of Galaxy-6', 600000, true, 6000);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Moon-01', 'Description for Moon-01', 1000.1200, 10000.1200, 1);
INSERT INTO public.moon VALUES (2, 'Moon-02', 'Description for Moon-02', 2000.1200, 20000.1200, 1);
INSERT INTO public.moon VALUES (3, 'Moon-03', 'Description for Moon-03', 3000.1200, 30000.1200, 2);
INSERT INTO public.moon VALUES (4, 'Moon-04', 'Description for Moon-04', 4000.1200, 40000.1200, 2);
INSERT INTO public.moon VALUES (5, 'Moon-05', 'Description for Moon-05', 5000.1200, 50000.1200, 3);
INSERT INTO public.moon VALUES (6, 'Moon-06', 'Description for Moon-06', 6000.1200, 60000.1200, 3);
INSERT INTO public.moon VALUES (7, 'Moon-07', 'Description for Moon-07', 7000.1200, 70000.1200, 4);
INSERT INTO public.moon VALUES (8, 'Moon-08', 'Description for Moon-08', 8000.1200, 80000.1200, 4);
INSERT INTO public.moon VALUES (9, 'Moon-09', 'Description for Moon-09', 9000.1200, 90000.1200, 5);
INSERT INTO public.moon VALUES (10, 'Moon-10', 'Description for Moon-10', 10000.1200, 100000.1200, 5);
INSERT INTO public.moon VALUES (11, 'Moon-11', 'Description for Moon-11', 11000.1200, 110000.1200, 6);
INSERT INTO public.moon VALUES (12, 'Moon-12', 'Description for Moon-12', 12000.1200, 120000.1200, 6);
INSERT INTO public.moon VALUES (13, 'Moon-13', 'Description for Moon-13', 13000.1200, 130000.1200, 7);
INSERT INTO public.moon VALUES (14, 'Moon-14', 'Description for Moon-14', 14000.1200, 140000.1200, 7);
INSERT INTO public.moon VALUES (15, 'Moon-15', 'Description for Moon-15', 15000.1200, 150000.1200, 8);
INSERT INTO public.moon VALUES (16, 'Moon-16', 'Description for Moon-16', 16000.1200, 160000.1200, 8);
INSERT INTO public.moon VALUES (17, 'Moon-17', 'Description for Moon-17', 17000.1200, 170000.1200, 9);
INSERT INTO public.moon VALUES (18, 'Moon-18', 'Description for Moon-18', 18000.1200, 180000.1200, 9);
INSERT INTO public.moon VALUES (19, 'Moon-19', 'Description for Moon-19', 19000.1200, 190000.1200, 10);
INSERT INTO public.moon VALUES (20, 'Moon-20', 'Description for Moon-20', 20000.1200, 200000.1200, 10);
INSERT INTO public.moon VALUES (21, 'Moon-21', 'Description for Moon-21', 21000.1200, 210000.1200, 11);
INSERT INTO public.moon VALUES (22, 'Moon-22', 'Description for Moon-22', 22000.1200, 220000.1200, 11);
INSERT INTO public.moon VALUES (23, 'Moon-23', 'Description for Moon-23', 23000.1200, 230000.1200, 12);
INSERT INTO public.moon VALUES (24, 'Moon-24', 'Description for Moon-24', 24000.1200, 240000.1200, 12);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Planet-01', 'Description of Planet-01', true, 1, 1000.1200, 1);
INSERT INTO public.planet VALUES (2, 'Planet-02', 'Description of Planet-02', true, 2, 2000.1200, 1);
INSERT INTO public.planet VALUES (3, 'Planet-03', 'Description of Planet-03', true, 3, 3000.1200, 2);
INSERT INTO public.planet VALUES (4, 'Planet-04', 'Description of Planet-04', true, 4, 4000.1200, 2);
INSERT INTO public.planet VALUES (5, 'Planet-05', 'Description of Planet-05', true, 5, 5000.1200, 3);
INSERT INTO public.planet VALUES (6, 'Planet-06', 'Description of Planet-06', true, 6, 6000.1200, 3);
INSERT INTO public.planet VALUES (7, 'Planet-07', 'Description of Planet-07', true, 7, 7000.1200, 4);
INSERT INTO public.planet VALUES (8, 'Planet-08', 'Description of Planet-08', true, 8, 8000.1200, 4);
INSERT INTO public.planet VALUES (9, 'Planet-09', 'Description of Planet-09', true, 9, 9000.1200, 5);
INSERT INTO public.planet VALUES (10, 'Planet-10', 'Description of Planet-10', true, 10, 10000.1200, 5);
INSERT INTO public.planet VALUES (11, 'Planet-11', 'Description of Planet-11', true, 11, 11000.1200, 6);
INSERT INTO public.planet VALUES (12, 'Planet-12', 'Description of Planet-12', true, 12, 12000.1200, 6);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Star-1', 'Description of Star-1', true, 10, 100.1200, 1);
INSERT INTO public.star VALUES (2, 'Star-2', 'Description of Star-2', true, 20, 200.1200, 2);
INSERT INTO public.star VALUES (3, 'Star-3', 'Description of Star-3', true, 30, 300.1200, 3);
INSERT INTO public.star VALUES (4, 'Star-4', 'Description of Star-4', true, 40, 400.1200, 4);
INSERT INTO public.star VALUES (5, 'Star-5', 'Description of Star-5', true, 50, 500.1200, 5);
INSERT INTO public.star VALUES (6, 'Star-6', 'Description of Star-6', true, 60, 600.1200, 6);


--
-- Name: discovery_discovery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.discovery_discovery_id_seq', 16, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 24, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 12, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: discovery discovery_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.discovery
    ADD CONSTRAINT discovery_name_key UNIQUE (name);


--
-- Name: discovery discovery_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.discovery
    ADD CONSTRAINT discovery_pkey PRIMARY KEY (discovery_id);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

