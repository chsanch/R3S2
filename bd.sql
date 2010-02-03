--
-- PostgreSQL database dump
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

ALTER TABLE ONLY public.usuario_sede DROP CONSTRAINT usuario;
ALTER TABLE ONLY public.usuario_rol DROP CONSTRAINT usuario;
ALTER TABLE ONLY public.ponente DROP CONSTRAINT sede;
ALTER TABLE ONLY public.sede_distro DROP CONSTRAINT sede;
ALTER TABLE ONLY public.inscrito DROP CONSTRAINT sede;
ALTER TABLE ONLY public.usuario_sede DROP CONSTRAINT sede;
ALTER TABLE ONLY public.usuario_rol DROP CONSTRAINT rol;
ALTER TABLE ONLY public.sede_distro DROP CONSTRAINT distro;
ALTER TABLE ONLY public.usuario_sede DROP CONSTRAINT usuario_sede_id;
ALTER TABLE ONLY public.usuario_rol DROP CONSTRAINT usuario_rol_id;
ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_id;
ALTER TABLE ONLY public.sede_distro DROP CONSTRAINT sede_distro_id;
ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_id;
ALTER TABLE ONLY public.ponente DROP CONSTRAINT ponente_id;
ALTER TABLE ONLY public.inscrito DROP CONSTRAINT inscrito_id;
ALTER TABLE ONLY public.sede DROP CONSTRAINT id_sede;
ALTER TABLE ONLY public.distro DROP CONSTRAINT distro_id;
ALTER TABLE public.usuario ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.sede ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.rol ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.ponente ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.inscrito ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.distro ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.usuario_sede;
DROP TABLE public.usuario_rol;
DROP SEQUENCE public.usuario_id_seq;
DROP TABLE public.usuario;
DROP SEQUENCE public.sede_id_seq;
DROP TABLE public.sede_distro;
DROP TABLE public.sede;
DROP SEQUENCE public.role_id_seq;
DROP TABLE public.rol;
DROP SEQUENCE public.ponente_id_seq;
DROP TABLE public.ponente;
DROP SEQUENCE public.inscrito_id_seq;
DROP TABLE public.inscrito;
DROP SEQUENCE public.distro_id_seq;
DROP TABLE public.distro;
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
-- Name: distro; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE distro (
    id integer NOT NULL,
    nombre text
);


--
-- Name: distro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE distro_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: distro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE distro_id_seq OWNED BY distro.id;


--
-- Name: distro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('distro_id_seq', 4, true);


--
-- Name: inscrito; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE inscrito (
    id integer NOT NULL,
    nombres text,
    apellidos text,
    email text,
    twitter text,
    tipo_comp text,
    tipo_proc text,
    cant_ram text,
    esp_dd text,
    distro text,
    comentarios text,
    sede integer,
    uso_linux_antes character(1) DEFAULT 0,
    ccsef text,
    fecha_ins date
);


--
-- Name: inscrito_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE inscrito_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: inscrito_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE inscrito_id_seq OWNED BY inscrito.id;


--
-- Name: inscrito_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('inscrito_id_seq', 6, true);


--
-- Name: ponente; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ponente (
    id integer NOT NULL,
    nombres text,
    apellidos text,
    email text,
    twitter text,
    url text,
    fecha_ins date,
    sede integer,
    titulo_ponencia text,
    descripcion_ponencia text
);


--
-- Name: ponente_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ponente_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: ponente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ponente_id_seq OWNED BY ponente.id;


--
-- Name: ponente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('ponente_id_seq', 19, true);


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
-- Name: sede; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sede (
    id integer NOT NULL,
    ciudad text,
    lugar text,
    fecha date
);


--
-- Name: sede_distro; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sede_distro (
    sede_id integer NOT NULL,
    distro_id integer NOT NULL
);


--
-- Name: sede_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sede_id_seq
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: sede_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sede_id_seq OWNED BY sede.id;


--
-- Name: sede_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('sede_id_seq', 4, true);


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuario (
    id integer NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    nombre text,
    apellido text,
    activo integer DEFAULT 1,
    email text,
    twitter text,
    website text
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
-- Name: usuario_sede; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE usuario_sede (
    usuario_id integer NOT NULL,
    sede_id integer NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE distro ALTER COLUMN id SET DEFAULT nextval('distro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE inscrito ALTER COLUMN id SET DEFAULT nextval('inscrito_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ponente ALTER COLUMN id SET DEFAULT nextval('ponente_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE rol ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE sede ALTER COLUMN id SET DEFAULT nextval('sede_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE usuario ALTER COLUMN id SET DEFAULT nextval('usuario_id_seq'::regclass);


--
-- Data for Name: distro; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO distro VALUES (1, 'Debian');
INSERT INTO distro VALUES (2, 'Ubuntu');
INSERT INTO distro VALUES (3, 'Fedora');
INSERT INTO distro VALUES (4, 'Canaima');


--
-- Data for Name: inscrito; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO inscrito VALUES (1, 'Juan', 'Perez', 'juan@perez.com', '@jperez', 'Escritorio', 'Pentium I', '2000', '10000', 'Debian', 'Prueba', NULL, '0', NULL, NULL);
INSERT INTO inscrito VALUES (2, 'Maria', 'Perez', 'maria@perez.com', '@perezm', 'Escritorio', 'Pentium I', '222', '222', 'Debian', 'sssss', NULL, '0', NULL, NULL);
INSERT INTO inscrito VALUES (3, 's', 's', 's', 's', 'Escritorio', 'Pentium I', 's', 's', 'Debian', 's', 1, '0', NULL, NULL);
INSERT INTO inscrito VALUES (4, 'f', 's', 'd', 'f', 'Escritorio', 'Pentium I', 'j', 'e', 'Slackware', 'd', 1, '0', NULL, NULL);
INSERT INTO inscrito VALUES (5, 'Andres', 'Lopez', 'ss', 'sss', 'Escritorio', 'Pentium I', '3', '3', 'Debian', 'sssd', 2, '0', NULL, NULL);
INSERT INTO inscrito VALUES (6, 'Juan', 'Rodriguez', 'j', 's', 'Escritorio', 'Pentium I', 'q', '3', 'Debian', 'w', 3, '0', NULL, NULL);


--
-- Data for Name: ponente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO ponente VALUES (16, 'Christian', 'Sanchez', 'csanchez@unplug.org.ve', '@g013m', 'http://blog.g013m.com.ve/', '2010-01-29', 4, 'Programando Perl', 'Programando Perl en Linux');
INSERT INTO ponente VALUES (17, 'Christian', 'Sanchez', 'csanchez@unplug.org.ve', '@g013m', 'http://blog.g013m.com.ve', '2010-01-29', 2, 'Otra Charla de Perl', 'Otra Charla Mas de Perl ...');
INSERT INTO ponente VALUES (18, 'Christian', 'Sanchez', 'csanchez@unplug.org.ve', '@g013m', 'http://blog.g013m.com.ve', '2010-01-29', 4, 'Ruby', 'Charla de Ruby');
INSERT INTO ponente VALUES (19, 'Juan', 'Perez', 'jjms0309@gmail.com', '@jperez', 'jperez.com', '2010-01-29', 4, 'PHP', 'Charla de PHP');


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO rol VALUES (1, 'admin', 'Administrador de la aplicación');
INSERT INTO rol VALUES (2, 'coordinador', 'Coordinador de algun area de la aplicación');


--
-- Data for Name: sede; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sede VALUES (1, 'Maracay', 'Teatro de la Opera', '2009-04-24');
INSERT INTO sede VALUES (2, 'Merida', 'Anfiteatro', '2010-04-18');
INSERT INTO sede VALUES (3, 'Caracas', 'UJnefa', '2010-04-24');
INSERT INTO sede VALUES (4, 'Guanarito', 'Sede Guanarito', '2010-04-24');


--
-- Data for Name: sede_distro; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sede_distro VALUES (1, 1);
INSERT INTO sede_distro VALUES (1, 2);
INSERT INTO sede_distro VALUES (1, 3);
INSERT INTO sede_distro VALUES (2, 1);
INSERT INTO sede_distro VALUES (2, 3);
INSERT INTO sede_distro VALUES (3, 4);
INSERT INTO sede_distro VALUES (3, 1);
INSERT INTO sede_distro VALUES (4, 1);
INSERT INTO sede_distro VALUES (4, 2);
INSERT INTO sede_distro VALUES (4, 3);
INSERT INTO sede_distro VALUES (4, 4);


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuario VALUES (1, 'csanchez', '90cbcc62c3251e18bc672241b012abe3caf5c40fje4Ae4bQrS', 'Christian', 'Sánchez', 1, NULL, NULL, NULL);
INSERT INTO usuario VALUES (2, 'prueba', 'b24e96454074ce091eb72c6ce8401804126302583E7wYB3SR6', 'Prueba', 'Prueba', 1, NULL, NULL, NULL);


--
-- Data for Name: usuario_rol; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO usuario_rol VALUES (1, 1);
INSERT INTO usuario_rol VALUES (2, 2);
INSERT INTO usuario_rol VALUES (1, 2);


--
-- Data for Name: usuario_sede; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: distro_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY distro
    ADD CONSTRAINT distro_id PRIMARY KEY (id);


--
-- Name: id_sede; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sede
    ADD CONSTRAINT id_sede PRIMARY KEY (id);


--
-- Name: inscrito_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY inscrito
    ADD CONSTRAINT inscrito_id PRIMARY KEY (id);


--
-- Name: ponente_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ponente
    ADD CONSTRAINT ponente_id PRIMARY KEY (id);


--
-- Name: rol_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT rol_id PRIMARY KEY (id);


--
-- Name: sede_distro_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sede_distro
    ADD CONSTRAINT sede_distro_id PRIMARY KEY (sede_id, distro_id);


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
-- Name: usuario_sede_id; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuario_sede
    ADD CONSTRAINT usuario_sede_id PRIMARY KEY (usuario_id, sede_id);


--
-- Name: distro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sede_distro
    ADD CONSTRAINT distro FOREIGN KEY (distro_id) REFERENCES distro(id);


--
-- Name: rol; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT rol FOREIGN KEY (rol_id) REFERENCES rol(id);


--
-- Name: sede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario_sede
    ADD CONSTRAINT sede FOREIGN KEY (sede_id) REFERENCES sede(id);


--
-- Name: sede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inscrito
    ADD CONSTRAINT sede FOREIGN KEY (sede) REFERENCES sede(id);


--
-- Name: sede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sede_distro
    ADD CONSTRAINT sede FOREIGN KEY (sede_id) REFERENCES sede(id);


--
-- Name: sede; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ponente
    ADD CONSTRAINT sede FOREIGN KEY (sede) REFERENCES sede(id);


--
-- Name: usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario_rol
    ADD CONSTRAINT usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- Name: usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY usuario_sede
    ADD CONSTRAINT usuario FOREIGN KEY (usuario_id) REFERENCES usuario(id);


--
-- PostgreSQL database dump complete
--

