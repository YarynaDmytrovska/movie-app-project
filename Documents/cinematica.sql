PGDMP     (    !            
    {         
   cinematica    15.4    15.4 }    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16641 
   cinematica    DATABASE     �   CREATE DATABASE cinematica WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United Kingdom.1251';
    DROP DATABASE cinematica;
                postgres    false            g           1247    16720    email    DOMAIN     �   CREATE DOMAIN public.email AS character varying(256)
	CONSTRAINT email_check CHECK (((VALUE)::text ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'::text));
    DROP DOMAIN public.email;
       public          postgres    false            k           1247    16723    list    DOMAIN     �   CREATE DOMAIN public.list AS character varying(50) NOT NULL
	CONSTRAINT list_check CHECK (((VALUE)::text = ANY (ARRAY[('Watching'::character varying)::text, ('Want to watch'::character varying)::text, ('Watched'::character varying)::text])));
    DROP DOMAIN public.list;
       public          postgres    false            c           1247    16717    phone_number    DOMAIN     p   CREATE DOMAIN public.phone_number AS text
	CONSTRAINT phone_number_check CHECK ((VALUE ~* '^\+\d{12}$'::text));
 !   DROP DOMAIN public.phone_number;
       public          postgres    false            o           1247    16726    rating    DOMAIN     >  CREATE DOMAIN public.rating AS character varying(50) NOT NULL
	CONSTRAINT rating_check CHECK (((VALUE)::text = ANY (ARRAY[('0'::character varying)::text, ('1'::character varying)::text, ('2'::character varying)::text, ('3'::character varying)::text, ('4'::character varying)::text, ('5'::character varying)::text])));
    DROP DOMAIN public.rating;
       public          postgres    false            _           1247    16714    text_no_digits    DOMAIN     r   CREATE DOMAIN public.text_no_digits AS text
	CONSTRAINT text_no_digits_check CHECK ((VALUE ~ '^[^0-9]*$'::text));
 #   DROP DOMAIN public.text_no_digits;
       public          postgres    false            �            1259    16840    actor    TABLE     a  CREATE TABLE public.actor (
    actorid integer NOT NULL,
    name character varying(50) NOT NULL,
    avatar character varying(255),
    birthdate date NOT NULL,
    deathdate date,
    nominations character varying(300),
    height character varying(80),
    countryofbirth public.text_no_digits,
    actingcareer text NOT NULL,
    biography text
);
    DROP TABLE public.actor;
       public         heap    postgres    false    863            �            1259    16839    actor_actorid_seq    SEQUENCE     �   CREATE SEQUENCE public.actor_actorid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.actor_actorid_seq;
       public          postgres    false    229            �           0    0    actor_actorid_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.actor_actorid_seq OWNED BY public.actor.actorid;
          public          postgres    false    228            �            1259    16850    actor_movie    TABLE     `   CREATE TABLE public.actor_movie (
    actorid integer NOT NULL,
    movieid integer NOT NULL
);
    DROP TABLE public.actor_movie;
       public         heap    postgres    false            �            1259    16785    moviegenres    TABLE     p   CREATE TABLE public.moviegenres (
    genreid integer NOT NULL,
    genrename public.text_no_digits NOT NULL
);
    DROP TABLE public.moviegenres;
       public         heap    postgres    false    863            �            1259    16784    moviegenres_genreid_seq    SEQUENCE     �   CREATE SEQUENCE public.moviegenres_genreid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.moviegenres_genreid_seq;
       public          postgres    false    222            �           0    0    moviegenres_genreid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.moviegenres_genreid_seq OWNED BY public.moviegenres.genreid;
          public          postgres    false    221            �            1259    16793    moviegenres_movies    TABLE     g   CREATE TABLE public.moviegenres_movies (
    movieid integer NOT NULL,
    genreid integer NOT NULL
);
 &   DROP TABLE public.moviegenres_movies;
       public         heap    postgres    false            �            1259    16823    movieinlists    TABLE     g   CREATE TABLE public.movieinlists (
    id integer NOT NULL,
    listid integer,
    movieid integer
);
     DROP TABLE public.movieinlists;
       public         heap    postgres    false            �            1259    16822    movieinlists_id_seq    SEQUENCE     �   CREATE SEQUENCE public.movieinlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.movieinlists_id_seq;
       public          postgres    false    227            �           0    0    movieinlists_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.movieinlists_id_seq OWNED BY public.movieinlists.id;
          public          postgres    false    226            �            1259    16809 
   movielists    TABLE     u   CREATE TABLE public.movielists (
    listid integer NOT NULL,
    userid integer,
    status public.list NOT NULL
);
    DROP TABLE public.movielists;
       public         heap    postgres    false    875            �            1259    16808    movielists_listid_seq    SEQUENCE     �   CREATE SEQUENCE public.movielists_listid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.movielists_listid_seq;
       public          postgres    false    225            �           0    0    movielists_listid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.movielists_listid_seq OWNED BY public.movielists.listid;
          public          postgres    false    224            �            1259    16902    movierating    TABLE     �   CREATE TABLE public.movierating (
    movieratingid integer NOT NULL,
    movieid integer,
    userid integer,
    rating public.rating
);
    DROP TABLE public.movierating;
       public         heap    postgres    false    879            �            1259    16901    movierating_movieratingid_seq    SEQUENCE     �   CREATE SEQUENCE public.movierating_movieratingid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.movierating_movieratingid_seq;
       public          postgres    false    236            �           0    0    movierating_movieratingid_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE public.movierating_movieratingid_seq OWNED BY public.movierating.movieratingid;
          public          postgres    false    235            �            1259    16742    movies    TABLE     8  CREATE TABLE public.movies (
    movieid integer NOT NULL,
    title character varying(50) NOT NULL,
    poster character varying(255),
    releaseyear integer,
    duration character varying(50) NOT NULL,
    director public.text_no_digits NOT NULL,
    country public.text_no_digits NOT NULL,
    plot text
);
    DROP TABLE public.movies;
       public         heap    postgres    false    863    863            �            1259    16741    movies_movieid_seq    SEQUENCE     �   CREATE SEQUENCE public.movies_movieid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.movies_movieid_seq;
       public          postgres    false    217            �           0    0    movies_movieid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.movies_movieid_seq OWNED BY public.movies.movieid;
          public          postgres    false    216            �            1259    16930    notifications    TABLE        CREATE TABLE public.notifications (
    notificationid integer NOT NULL,
    userid integer,
    notificationtypeid integer
);
 !   DROP TABLE public.notifications;
       public         heap    postgres    false            �            1259    16929     notifications_notificationid_seq    SEQUENCE     �   CREATE SEQUENCE public.notifications_notificationid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.notifications_notificationid_seq;
       public          postgres    false    240            �           0    0     notifications_notificationid_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE public.notifications_notificationid_seq OWNED BY public.notifications.notificationid;
          public          postgres    false    239            �            1259    16921    notificationtype    TABLE     a   CREATE TABLE public.notificationtype (
    notificationtypeid integer NOT NULL,
    type text
);
 $   DROP TABLE public.notificationtype;
       public         heap    postgres    false            �            1259    16920 '   notificationtype_notificationtypeid_seq    SEQUENCE     �   CREATE SEQUENCE public.notificationtype_notificationtypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.notificationtype_notificationtypeid_seq;
       public          postgres    false    238            �           0    0 '   notificationtype_notificationtypeid_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE public.notificationtype_notificationtypeid_seq OWNED BY public.notificationtype.notificationtypeid;
          public          postgres    false    237            �            1259    16866    reviews    TABLE     {   CREATE TABLE public.reviews (
    reviewsid integer NOT NULL,
    comment text,
    userid integer,
    movieid integer
);
    DROP TABLE public.reviews;
       public         heap    postgres    false            �            1259    16865    reviews_reviewsid_seq    SEQUENCE     �   CREATE SEQUENCE public.reviews_reviewsid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.reviews_reviewsid_seq;
       public          postgres    false    232            �           0    0    reviews_reviewsid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.reviews_reviewsid_seq OWNED BY public.reviews.reviewsid;
          public          postgres    false    231            �            1259    16885    reviewslikes    TABLE     u   CREATE TABLE public.reviewslikes (
    reviewslikesid integer NOT NULL,
    userid integer,
    reviewsid integer
);
     DROP TABLE public.reviewslikes;
       public         heap    postgres    false            �            1259    16884    reviewslikes_reviewslikesid_seq    SEQUENCE     �   CREATE SEQUENCE public.reviewslikes_reviewslikesid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.reviewslikes_reviewslikesid_seq;
       public          postgres    false    234            �           0    0    reviewslikes_reviewslikesid_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE public.reviewslikes_reviewslikesid_seq OWNED BY public.reviewslikes.reviewslikesid;
          public          postgres    false    233            �            1259    16769    subscribers    TABLE     d   CREATE TABLE public.subscribers (
    userid integer NOT NULL,
    subscriberid integer NOT NULL
);
    DROP TABLE public.subscribers;
       public         heap    postgres    false            �            1259    16753 	   usermovie    TABLE     n   CREATE TABLE public.usermovie (
    subscriberid integer NOT NULL,
    userid integer,
    movieid integer
);
    DROP TABLE public.usermovie;
       public         heap    postgres    false            �            1259    16752    usermovie_subscriberid_seq    SEQUENCE     �   CREATE SEQUENCE public.usermovie_subscriberid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.usermovie_subscriberid_seq;
       public          postgres    false    219            �           0    0    usermovie_subscriberid_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.usermovie_subscriberid_seq OWNED BY public.usermovie.subscriberid;
          public          postgres    false    218            �            1259    16729    users    TABLE     �   CREATE TABLE public.users (
    userid integer NOT NULL,
    email public.email NOT NULL,
    phone public.phone_number,
    password text NOT NULL,
    username character varying(50) NOT NULL,
    avatar character varying(255),
    description text
);
    DROP TABLE public.users;
       public         heap    postgres    false    867    871            �            1259    16728    users_userid_seq    SEQUENCE     �   CREATE SEQUENCE public.users_userid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.users_userid_seq;
       public          postgres    false    215            �           0    0    users_userid_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.users_userid_seq OWNED BY public.users.userid;
          public          postgres    false    214            �           2604    16843    actor actorid    DEFAULT     n   ALTER TABLE ONLY public.actor ALTER COLUMN actorid SET DEFAULT nextval('public.actor_actorid_seq'::regclass);
 <   ALTER TABLE public.actor ALTER COLUMN actorid DROP DEFAULT;
       public          postgres    false    229    228    229            �           2604    16788    moviegenres genreid    DEFAULT     z   ALTER TABLE ONLY public.moviegenres ALTER COLUMN genreid SET DEFAULT nextval('public.moviegenres_genreid_seq'::regclass);
 B   ALTER TABLE public.moviegenres ALTER COLUMN genreid DROP DEFAULT;
       public          postgres    false    221    222    222            �           2604    16826    movieinlists id    DEFAULT     r   ALTER TABLE ONLY public.movieinlists ALTER COLUMN id SET DEFAULT nextval('public.movieinlists_id_seq'::regclass);
 >   ALTER TABLE public.movieinlists ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    226    227            �           2604    16812    movielists listid    DEFAULT     v   ALTER TABLE ONLY public.movielists ALTER COLUMN listid SET DEFAULT nextval('public.movielists_listid_seq'::regclass);
 @   ALTER TABLE public.movielists ALTER COLUMN listid DROP DEFAULT;
       public          postgres    false    225    224    225            �           2604    16905    movierating movieratingid    DEFAULT     �   ALTER TABLE ONLY public.movierating ALTER COLUMN movieratingid SET DEFAULT nextval('public.movierating_movieratingid_seq'::regclass);
 H   ALTER TABLE public.movierating ALTER COLUMN movieratingid DROP DEFAULT;
       public          postgres    false    236    235    236            �           2604    16745    movies movieid    DEFAULT     p   ALTER TABLE ONLY public.movies ALTER COLUMN movieid SET DEFAULT nextval('public.movies_movieid_seq'::regclass);
 =   ALTER TABLE public.movies ALTER COLUMN movieid DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    16933    notifications notificationid    DEFAULT     �   ALTER TABLE ONLY public.notifications ALTER COLUMN notificationid SET DEFAULT nextval('public.notifications_notificationid_seq'::regclass);
 K   ALTER TABLE public.notifications ALTER COLUMN notificationid DROP DEFAULT;
       public          postgres    false    239    240    240            �           2604    16924 #   notificationtype notificationtypeid    DEFAULT     �   ALTER TABLE ONLY public.notificationtype ALTER COLUMN notificationtypeid SET DEFAULT nextval('public.notificationtype_notificationtypeid_seq'::regclass);
 R   ALTER TABLE public.notificationtype ALTER COLUMN notificationtypeid DROP DEFAULT;
       public          postgres    false    238    237    238            �           2604    16869    reviews reviewsid    DEFAULT     v   ALTER TABLE ONLY public.reviews ALTER COLUMN reviewsid SET DEFAULT nextval('public.reviews_reviewsid_seq'::regclass);
 @   ALTER TABLE public.reviews ALTER COLUMN reviewsid DROP DEFAULT;
       public          postgres    false    232    231    232            �           2604    16888    reviewslikes reviewslikesid    DEFAULT     �   ALTER TABLE ONLY public.reviewslikes ALTER COLUMN reviewslikesid SET DEFAULT nextval('public.reviewslikes_reviewslikesid_seq'::regclass);
 J   ALTER TABLE public.reviewslikes ALTER COLUMN reviewslikesid DROP DEFAULT;
       public          postgres    false    233    234    234            �           2604    16756    usermovie subscriberid    DEFAULT     �   ALTER TABLE ONLY public.usermovie ALTER COLUMN subscriberid SET DEFAULT nextval('public.usermovie_subscriberid_seq'::regclass);
 E   ALTER TABLE public.usermovie ALTER COLUMN subscriberid DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    16732    users userid    DEFAULT     l   ALTER TABLE ONLY public.users ALTER COLUMN userid SET DEFAULT nextval('public.users_userid_seq'::regclass);
 ;   ALTER TABLE public.users ALTER COLUMN userid DROP DEFAULT;
       public          postgres    false    214    215    215            �          0    16840    actor 
   TABLE DATA           �   COPY public.actor (actorid, name, avatar, birthdate, deathdate, nominations, height, countryofbirth, actingcareer, biography) FROM stdin;
    public          postgres    false    229   Q�       �          0    16850    actor_movie 
   TABLE DATA           7   COPY public.actor_movie (actorid, movieid) FROM stdin;
    public          postgres    false    230   n�       �          0    16785    moviegenres 
   TABLE DATA           9   COPY public.moviegenres (genreid, genrename) FROM stdin;
    public          postgres    false    222   ��       �          0    16793    moviegenres_movies 
   TABLE DATA           >   COPY public.moviegenres_movies (movieid, genreid) FROM stdin;
    public          postgres    false    223   ��       �          0    16823    movieinlists 
   TABLE DATA           ;   COPY public.movieinlists (id, listid, movieid) FROM stdin;
    public          postgres    false    227   Ś       �          0    16809 
   movielists 
   TABLE DATA           <   COPY public.movielists (listid, userid, status) FROM stdin;
    public          postgres    false    225   �       �          0    16902    movierating 
   TABLE DATA           M   COPY public.movierating (movieratingid, movieid, userid, rating) FROM stdin;
    public          postgres    false    236   ��       �          0    16742    movies 
   TABLE DATA           h   COPY public.movies (movieid, title, poster, releaseyear, duration, director, country, plot) FROM stdin;
    public          postgres    false    217   �       �          0    16930    notifications 
   TABLE DATA           S   COPY public.notifications (notificationid, userid, notificationtypeid) FROM stdin;
    public          postgres    false    240   9�       �          0    16921    notificationtype 
   TABLE DATA           D   COPY public.notificationtype (notificationtypeid, type) FROM stdin;
    public          postgres    false    238   V�       �          0    16866    reviews 
   TABLE DATA           F   COPY public.reviews (reviewsid, comment, userid, movieid) FROM stdin;
    public          postgres    false    232   s�       �          0    16885    reviewslikes 
   TABLE DATA           I   COPY public.reviewslikes (reviewslikesid, userid, reviewsid) FROM stdin;
    public          postgres    false    234   ��       �          0    16769    subscribers 
   TABLE DATA           ;   COPY public.subscribers (userid, subscriberid) FROM stdin;
    public          postgres    false    220   ��       �          0    16753 	   usermovie 
   TABLE DATA           B   COPY public.usermovie (subscriberid, userid, movieid) FROM stdin;
    public          postgres    false    219   ʛ       �          0    16729    users 
   TABLE DATA           ^   COPY public.users (userid, email, phone, password, username, avatar, description) FROM stdin;
    public          postgres    false    215   �       �           0    0    actor_actorid_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.actor_actorid_seq', 1, false);
          public          postgres    false    228            �           0    0    moviegenres_genreid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.moviegenres_genreid_seq', 1, false);
          public          postgres    false    221            �           0    0    movieinlists_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.movieinlists_id_seq', 1, false);
          public          postgres    false    226            �           0    0    movielists_listid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.movielists_listid_seq', 1, false);
          public          postgres    false    224            �           0    0    movierating_movieratingid_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.movierating_movieratingid_seq', 1, false);
          public          postgres    false    235            �           0    0    movies_movieid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.movies_movieid_seq', 1, false);
          public          postgres    false    216            �           0    0     notifications_notificationid_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.notifications_notificationid_seq', 1, false);
          public          postgres    false    239            �           0    0 '   notificationtype_notificationtypeid_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('public.notificationtype_notificationtypeid_seq', 1, false);
          public          postgres    false    237            �           0    0    reviews_reviewsid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.reviews_reviewsid_seq', 1, false);
          public          postgres    false    231            �           0    0    reviewslikes_reviewslikesid_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('public.reviewslikes_reviewslikesid_seq', 1, false);
          public          postgres    false    233            �           0    0    usermovie_subscriberid_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.usermovie_subscriberid_seq', 1, false);
          public          postgres    false    218            �           0    0    users_userid_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.users_userid_seq', 63, true);
          public          postgres    false    214            �           2606    16854    actor_movie actor_movie_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.actor_movie
    ADD CONSTRAINT actor_movie_pkey PRIMARY KEY (actorid, movieid);
 F   ALTER TABLE ONLY public.actor_movie DROP CONSTRAINT actor_movie_pkey;
       public            postgres    false    230    230            �           2606    16849    actor actor_name_key 
   CONSTRAINT     O   ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_name_key UNIQUE (name);
 >   ALTER TABLE ONLY public.actor DROP CONSTRAINT actor_name_key;
       public            postgres    false    229            �           2606    16847    actor actor_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actorid);
 :   ALTER TABLE ONLY public.actor DROP CONSTRAINT actor_pkey;
       public            postgres    false    229            �           2606    16797 *   moviegenres_movies moviegenres_movies_pkey 
   CONSTRAINT     v   ALTER TABLE ONLY public.moviegenres_movies
    ADD CONSTRAINT moviegenres_movies_pkey PRIMARY KEY (movieid, genreid);
 T   ALTER TABLE ONLY public.moviegenres_movies DROP CONSTRAINT moviegenres_movies_pkey;
       public            postgres    false    223    223            �           2606    16792    moviegenres moviegenres_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.moviegenres
    ADD CONSTRAINT moviegenres_pkey PRIMARY KEY (genreid);
 F   ALTER TABLE ONLY public.moviegenres DROP CONSTRAINT moviegenres_pkey;
       public            postgres    false    222            �           2606    16828    movieinlists movieinlists_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.movieinlists
    ADD CONSTRAINT movieinlists_pkey PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.movieinlists DROP CONSTRAINT movieinlists_pkey;
       public            postgres    false    227            �           2606    16816    movielists movielists_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.movielists
    ADD CONSTRAINT movielists_pkey PRIMARY KEY (listid);
 D   ALTER TABLE ONLY public.movielists DROP CONSTRAINT movielists_pkey;
       public            postgres    false    225            �           2606    16909    movierating movierating_pkey 
   CONSTRAINT     e   ALTER TABLE ONLY public.movierating
    ADD CONSTRAINT movierating_pkey PRIMARY KEY (movieratingid);
 F   ALTER TABLE ONLY public.movierating DROP CONSTRAINT movierating_pkey;
       public            postgres    false    236            �           2606    16749    movies movies_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_pkey PRIMARY KEY (movieid);
 <   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_pkey;
       public            postgres    false    217            �           2606    16751    movies movies_title_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.movies
    ADD CONSTRAINT movies_title_key UNIQUE (title);
 A   ALTER TABLE ONLY public.movies DROP CONSTRAINT movies_title_key;
       public            postgres    false    217            �           2606    16935     notifications notifications_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notificationid);
 J   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_pkey;
       public            postgres    false    240            �           2606    16928 &   notificationtype notificationtype_pkey 
   CONSTRAINT     t   ALTER TABLE ONLY public.notificationtype
    ADD CONSTRAINT notificationtype_pkey PRIMARY KEY (notificationtypeid);
 P   ALTER TABLE ONLY public.notificationtype DROP CONSTRAINT notificationtype_pkey;
       public            postgres    false    238            �           2606    16873    reviews reviews_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (reviewsid);
 >   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_pkey;
       public            postgres    false    232            �           2606    16890    reviewslikes reviewslikes_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.reviewslikes
    ADD CONSTRAINT reviewslikes_pkey PRIMARY KEY (reviewslikesid);
 H   ALTER TABLE ONLY public.reviewslikes DROP CONSTRAINT reviewslikes_pkey;
       public            postgres    false    234            �           2606    16773    subscribers subscribers_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT subscribers_pkey PRIMARY KEY (userid, subscriberid);
 F   ALTER TABLE ONLY public.subscribers DROP CONSTRAINT subscribers_pkey;
       public            postgres    false    220    220            �           2606    16758    usermovie usermovie_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.usermovie
    ADD CONSTRAINT usermovie_pkey PRIMARY KEY (subscriberid);
 B   ALTER TABLE ONLY public.usermovie DROP CONSTRAINT usermovie_pkey;
       public            postgres    false    219            �           2606    16738    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    215            �           2606    16736    users users_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    215            �           2606    16740    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    215            �           2606    16855 $   actor_movie actor_movie_actorid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.actor_movie
    ADD CONSTRAINT actor_movie_actorid_fkey FOREIGN KEY (actorid) REFERENCES public.actor(actorid) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.actor_movie DROP CONSTRAINT actor_movie_actorid_fkey;
       public          postgres    false    229    3297    230            �           2606    16860 $   actor_movie actor_movie_movieid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.actor_movie
    ADD CONSTRAINT actor_movie_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movies(movieid) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.actor_movie DROP CONSTRAINT actor_movie_movieid_fkey;
       public          postgres    false    217    3279    230            �           2606    16803 2   moviegenres_movies moviegenres_movies_genreid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.moviegenres_movies
    ADD CONSTRAINT moviegenres_movies_genreid_fkey FOREIGN KEY (genreid) REFERENCES public.moviegenres(genreid) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.moviegenres_movies DROP CONSTRAINT moviegenres_movies_genreid_fkey;
       public          postgres    false    222    223    3287            �           2606    16798 2   moviegenres_movies moviegenres_movies_movieid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.moviegenres_movies
    ADD CONSTRAINT moviegenres_movies_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movies(movieid) ON UPDATE CASCADE ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.moviegenres_movies DROP CONSTRAINT moviegenres_movies_movieid_fkey;
       public          postgres    false    3279    217    223            �           2606    16829 %   movieinlists movieinlists_listid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movieinlists
    ADD CONSTRAINT movieinlists_listid_fkey FOREIGN KEY (listid) REFERENCES public.movielists(listid) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.movieinlists DROP CONSTRAINT movieinlists_listid_fkey;
       public          postgres    false    227    3291    225            �           2606    16834 &   movieinlists movieinlists_movieid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movieinlists
    ADD CONSTRAINT movieinlists_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movies(movieid) ON UPDATE CASCADE ON DELETE CASCADE;
 P   ALTER TABLE ONLY public.movieinlists DROP CONSTRAINT movieinlists_movieid_fkey;
       public          postgres    false    217    3279    227            �           2606    16817 !   movielists movielists_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movielists
    ADD CONSTRAINT movielists_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.movielists DROP CONSTRAINT movielists_userid_fkey;
       public          postgres    false    225    215    3275            �           2606    16910 $   movierating movierating_movieid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movierating
    ADD CONSTRAINT movierating_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movies(movieid) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.movierating DROP CONSTRAINT movierating_movieid_fkey;
       public          postgres    false    217    3279    236            �           2606    16915 #   movierating movierating_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.movierating
    ADD CONSTRAINT movierating_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON UPDATE CASCADE ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.movierating DROP CONSTRAINT movierating_userid_fkey;
       public          postgres    false    3275    236    215            �           2606    16941 3   notifications notifications_notificationtypeid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_notificationtypeid_fkey FOREIGN KEY (notificationtypeid) REFERENCES public.notificationtype(notificationtypeid) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_notificationtypeid_fkey;
       public          postgres    false    3307    240    238                        2606    16936 '   notifications notifications_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid);
 Q   ALTER TABLE ONLY public.notifications DROP CONSTRAINT notifications_userid_fkey;
       public          postgres    false    215    3275    240            �           2606    16879    reviews reviews_movieid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movies(movieid) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_movieid_fkey;
       public          postgres    false    217    232    3279            �           2606    16874    reviews reviews_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.reviews DROP CONSTRAINT reviews_userid_fkey;
       public          postgres    false    232    215    3275            �           2606    16896 (   reviewslikes reviewslikes_reviewsid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewslikes
    ADD CONSTRAINT reviewslikes_reviewsid_fkey FOREIGN KEY (reviewsid) REFERENCES public.reviews(reviewsid) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.reviewslikes DROP CONSTRAINT reviewslikes_reviewsid_fkey;
       public          postgres    false    234    232    3301            �           2606    16891 %   reviewslikes reviewslikes_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.reviewslikes
    ADD CONSTRAINT reviewslikes_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.reviewslikes DROP CONSTRAINT reviewslikes_userid_fkey;
       public          postgres    false    234    3275    215            �           2606    16774 )   subscribers subscribers_subscriberid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT subscribers_subscriberid_fkey FOREIGN KEY (subscriberid) REFERENCES public.usermovie(subscriberid) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public.subscribers DROP CONSTRAINT subscribers_subscriberid_fkey;
       public          postgres    false    220    219    3283            �           2606    16779 #   subscribers subscribers_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.subscribers
    ADD CONSTRAINT subscribers_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON UPDATE CASCADE ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.subscribers DROP CONSTRAINT subscribers_userid_fkey;
       public          postgres    false    3275    215    220            �           2606    16764     usermovie usermovie_movieid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usermovie
    ADD CONSTRAINT usermovie_movieid_fkey FOREIGN KEY (movieid) REFERENCES public.movies(movieid) ON UPDATE CASCADE ON DELETE CASCADE;
 J   ALTER TABLE ONLY public.usermovie DROP CONSTRAINT usermovie_movieid_fkey;
       public          postgres    false    217    3279    219            �           2606    16759    usermovie usermovie_userid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.usermovie
    ADD CONSTRAINT usermovie_userid_fkey FOREIGN KEY (userid) REFERENCES public.users(userid) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.usermovie DROP CONSTRAINT usermovie_userid_fkey;
       public          postgres    false    219    3275    215            �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �     x��XiS"K�,�B�#d5p���VV�oq�]�őC����G�<
��~n;)�2����t�~������/53?�fV����<<g����a����:�w�^�����Z噝���f����iW�v�pW�q�\~!;x�����Ul1��{� ���7�ٶ���AD <G��S�0���5��!�A�{���xI:�ӽ�V�0<�- �_�7fKA5��"jxK:z�p识��+p��TԉD����G?�Ó�J�m�z�gx���8h4����<��t����٭���f��T-�Q/r��y�l{x���^��;^}������
��6�\T���34a���A��K�t��Ih���1��#6Y�I�7��1�B5�qA��s�-u)3��4�2�IE�g�e�b������I-d�A�ϒўwW+a�3	Xa����;��`&`e��O�q|�v}��� j�s�s�*o��2�h�6��h��	���vb��2�`�
8��������:&�9�0��I����r����J��������?o��{e�}a*^|T<A��2S�<���CC,>�?��/�XJ����}�d�MUb��m:�z��������:#���FK��;���+b3M��l�"����o����R�ij)�n��"C��et�����T�z�RX�d��_������kS0��k`bE�x�R[u'��&���pp���ژ�!��� �ي�!�<X<�|7��,.��!�Y�߻��:��I��a�����0H�&�|��F�!pڄ����Z�d}#�s2
W5R�b����P�q`k6�/��Vl�p̡�zQ�p0}�6ഥ]ZkT�W���'puH@�<�.��^ђ�#�I������V�;=�_Q�����8������}�]*��fMa-L���b�y?����\�$P���L=�s�Ml�	Ζ��b��n�N���k"0E)���f������tM��!m�]��a��rF�'��/�������n��]0��X��9BE���Vr���p��8bj�Y/����Ǘ�����)�mZ,(I0R�E�t�����TF�ńw��2y����a���+����>�m��| 5r>��:_��M��tI���W��éI7J
�X�i�����q&�L��*V('������޹�/EL��������;6�I|XhmZ'-
��~���j�}'��O����(6�CW7q��{�;`W���+ �a,��Vq��]0����d��~�#��?|�̺     