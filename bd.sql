--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.usuario_rol DROP CONSTRAINT usuario;
ALTER TABLE ONLY public.usuario_rol DROP CONSTRAINT rol;
ALTER TABLE ONLY public.usuario_rol DROP CONSTRAINT usuario_rol_id;
ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_id;
ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_id;
ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.rol ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.usuario_rol;
DROP SEQUENCE public.usuario_id_seq;
DROP TABLE public.usuario;
DROP SEQUENCE public.role_id_seq;
DROP TABLE public.rol;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: rol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rol (
    id integer NOT NULL,
    nombre text,
    descripcion text
);


--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE role_id_seq OWNED BY rol.id;


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('role_id_seq', 1, false);


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuario (
    id integer NOT NULL,
    login text NOT NULL,
    password text NOT NULL,
    nombre text,
    apellido text,
    activo integer DEFAULT 1
);


--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE usuario_id_seq OWNED BY usuario.id;


--
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('usuario_id_seq', 1, false);


--
-- Name: usuario_rol; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuario_rol (
    usuario_id integer NOT NULL,
    rol_id integer NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE rol ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO rol VALUES (1, 'admin', 'Administrador de la aplicación');
INSERT INTO rol VALUES (2, 'coordinador', 'Coordinador de algun area de la aplicación');


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuario VALUES (1, 'csanchez', '90cbcc62c3251e18bc672241b012abe3caf5c40fje4Ae4bQrS', 'Christian', 'Sánchez', 1);
INSERT INTO usuario VALUES (2, 'prueba', 'b24e96454074ce091eb72c6ce8401804126302583E7wYB3SR6', 'Prueba', 'Prueba', 1);


--
-- Data for Name: usuario_rol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuario_rol VALUES (1, 1);
INSERT INTO usuario_rol VALUES (2, 2);


--
-- Name: rol_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT rol_id PRIMARY KEY (id);


--
-- Name: usuario_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_id PRIMARY KEY (id);


--
-- Name: usuario_rol_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT usuario_rol_id PRIMARY KEY (usuario_id, rol_id);


--
-- Name: rol; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT rol FOREIGN KEY (rol_id) REFERENCES rol(id);


--
-- Name: usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- PostgreSQL database dump complete
--

