toc.dat                                                                                             0000600 0004000 0002000 00000063022 13714604653 0014453 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       
                     x            Factory    12.3    12.3 [    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         �           1262    16472    Factory    DATABASE     g   CREATE DATABASE "Factory" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';
    DROP DATABASE "Factory";
                postgres    false         �            1255    16639 0   add_address(integer, integer, character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.add_address(sehir_id integer, ilce_id integer, text character varying)
    LANGUAGE plpgsql
    AS $$ BEGIN
   insert into public.adres(text,sehir_id,ilce_id) values(text,sehir_id,ilce_id);
 END;$$;
 ^   DROP PROCEDURE public.add_address(sehir_id integer, ilce_id integer, text character varying);
       public          postgres    false         �            1255    16640 C   add_factory(character varying, integer, integer, character varying) 	   PROCEDURE     �  CREATE PROCEDURE public.add_factory(factory_name character varying, city_id integer, ilce_id integer, address_text character varying)
    LANGUAGE plpgsql
    AS $$DECLARE 
  tempMax INTEGER;
 BEGIN 
   insert into public.adres(text,sehir_id,ilce_id) values(address_text,city_id,ilce_id);
   SELECT id Into tempMax FROM public.adres ORDER BY id DESC LIMIT 1;
   insert into public.fabrika(fabrika_adi,adres_id) values(factory_name,tempMax);

 END;$$;
 �   DROP PROCEDURE public.add_factory(factory_name character varying, city_id integer, ilce_id integer, address_text character varying);
       public          postgres    false         �            1255    16649 !   add_imalathane(character varying) 	   PROCEDURE     �   CREATE PROCEDURE public.add_imalathane(imalathane_adi character varying)
    LANGUAGE plpgsql
    AS $$ BEGIN 
  insert into public.imalathane(imalathane_adi) values(imalathane_adi);
END;$$;
 H   DROP PROCEDURE public.add_imalathane(imalathane_adi character varying);
       public          postgres    false         �            1255    16661    log_table()    FUNCTION     �   CREATE FUNCTION public.log_table() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN
   insert into logtable select 'ALTER Table',now();
 END;$$;
 "   DROP FUNCTION public.log_table();
       public          postgres    false         �            1255    16650    remove_factory(integer) 	   PROCEDURE     6  CREATE PROCEDURE public.remove_factory(factory_id integer)
    LANGUAGE plpgsql
    AS $$ BEGIN
   delete from public.fabrika WHERE id = factory_id;
   delete from public.fabrika_imalathane WHERE fabrika_id = factory_id;
   update public.genel_mudur SET fabrika_id = -1 WHERE fabrika_id = factory_id;
 END;$$;
 :   DROP PROCEDURE public.remove_factory(factory_id integer);
       public          postgres    false         �            1255    16652    remove_imalathane(integer) 	   PROCEDURE     �  CREATE PROCEDURE public.remove_imalathane(im_id integer)
    LANGUAGE plpgsql
    AS $$BEGIN
   delete from public.imalathane where id = im_id;
   delete from public.imalathane_urun where imalathane_id = im_id;
   update public.personel set imalathane_id=-1 where imalathane_id = im_id;
   update public.sorumlu set imalathane_id=-1 where imalathane_id = im_id;
   delete from public.fabrika_imalathane where imalathane_id = im_id;
 END;$$;
 8   DROP PROCEDURE public.remove_imalathane(im_id integer);
       public          postgres    false         �            1255    16653    remove_kategori(integer) 	   PROCEDURE     �   CREATE PROCEDURE public.remove_kategori(cat_id integer)
    LANGUAGE plpgsql
    AS $$ BEGIN
  delete from public.kategori where id = cat_id;
  update public.urun set kategori_id = -1 where kategori_id = cat_id;
 END;$$;
 7   DROP PROCEDURE public.remove_kategori(cat_id integer);
       public          postgres    false         �            1255    16663    trigger_scream()    FUNCTION     L  CREATE FUNCTION public.trigger_scream() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN
      IF (TG_OP = 'DELETE') THEN
	    RAISE NOTICE 'DELETED: ';
      ELSIF (TG_OP = 'UPDATE') THEN
	    RAISE NOTICE 'UPDATED: ';
      ELSIF (TG_OP = 'INSERT') THEN
	    RAISE NOTICE 'INSERTED: ';
      END IF;
    RETURN NULL;
	END;$$;
 '   DROP FUNCTION public.trigger_scream();
       public          postgres    false         �            1259    16518    adres    TABLE     �   CREATE TABLE public.adres (
    id integer NOT NULL,
    text character varying(220),
    sehir_id integer,
    ilce_id integer
);
    DROP TABLE public.adres;
       public         heap    postgres    false         �            1259    16610    adres_id_seq    SEQUENCE     �   ALTER TABLE public.adres ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.adres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    210         �            1259    16503    fabrika    TABLE     �   CREATE TABLE public.fabrika (
    id integer NOT NULL,
    fabrika_adi character varying(120) NOT NULL,
    adres_id integer
);
    DROP TABLE public.fabrika;
       public         heap    postgres    false         �            1259    16616    fabrika_id_seq    SEQUENCE     �   ALTER TABLE public.fabrika ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fabrika_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    207         �            1259    16508    fabrika_imalathane    TABLE     w   CREATE TABLE public.fabrika_imalathane (
    id integer NOT NULL,
    fabrika_id integer,
    imalathane_id integer
);
 &   DROP TABLE public.fabrika_imalathane;
       public         heap    postgres    false         �            1259    16665    fabrika_imalathane_id_seq    SEQUENCE     �   ALTER TABLE public.fabrika_imalathane ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fabrika_imalathane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    208         �            1259    16483    kisi    TABLE     �   CREATE TABLE public.kisi (
    id integer NOT NULL,
    ad character varying(34) NOT NULL,
    soyad character varying(34) NOT NULL,
    iletisim_id integer
);
    DROP TABLE public.kisi;
       public         heap    postgres    false         �            1259    16543    genel_mudur    TABLE     \   CREATE TABLE public.genel_mudur (
    fabrika_id integer NOT NULL
)
INHERITS (public.kisi);
    DROP TABLE public.genel_mudur;
       public         heap    postgres    false    203         �            1259    16641    genel_mudur_id_seq    SEQUENCE     �   ALTER TABLE public.genel_mudur ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.genel_mudur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    215         �            1259    16523    ilce    TABLE     Z   CREATE TABLE public.ilce (
    id integer NOT NULL,
    ilce_adi character varying(56)
);
    DROP TABLE public.ilce;
       public         heap    postgres    false         �            1259    16614    ilce_id_seq    SEQUENCE     �   ALTER TABLE public.ilce ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ilce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    211         �            1259    16478    iletisim    TABLE     r   CREATE TABLE public.iletisim (
    id integer NOT NULL,
    tel_no character varying(24),
    adres_id integer
);
    DROP TABLE public.iletisim;
       public         heap    postgres    false         �            1259    16528 
   imalathane    TABLE     f   CREATE TABLE public.imalathane (
    id integer NOT NULL,
    imalathane_adi character varying(64)
);
    DROP TABLE public.imalathane;
       public         heap    postgres    false         �            1259    16618    imalathane_id_seq    SEQUENCE     �   ALTER TABLE public.imalathane ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.imalathane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    212         �            1259    16538    imalathane_urun    TABLE     q   CREATE TABLE public.imalathane_urun (
    id integer NOT NULL,
    imalathane_id integer,
    urun_id integer
);
 #   DROP TABLE public.imalathane_urun;
       public         heap    postgres    false         �            1259    16628    imalathane_urun_id_seq    SEQUENCE     �   ALTER TABLE public.imalathane_urun ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.imalathane_urun_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    214         �            1259    16546    kategori    TABLE     c   CREATE TABLE public.kategori (
    id integer NOT NULL,
    kategori_adi character varying(120)
);
    DROP TABLE public.kategori;
       public         heap    postgres    false         �            1259    16620    kategori_id_seq    SEQUENCE     �   ALTER TABLE public.kategori ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kategori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    216         �            1259    16622    kisi_id_seq    SEQUENCE     �   ALTER TABLE public.kisi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    203         �            1259    16654    logtable    TABLE     �   CREATE TABLE public.logtable (
    id integer NOT NULL,
    log_text character varying(120),
    time_log timestamp(6) with time zone
);
    DROP TABLE public.logtable;
       public         heap    postgres    false         �            1259    16659    logtable_id_seq    SEQUENCE     �   ALTER TABLE public.logtable ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.logtable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    230         �            1259    16500    personel    TABLE     u   CREATE TABLE public.personel (
    imalathane_id integer,
    gorev character varying(120)
)
INHERITS (public.kisi);
    DROP TABLE public.personel;
       public         heap    postgres    false    203         �            1259    16643    personel_id_seq    SEQUENCE     �   ALTER TABLE public.personel ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    206         �            1259    16494    personel_yakini    TABLE     X   CREATE TABLE public.personel_yakini (
    personel_id integer
)
INHERITS (public.kisi);
 #   DROP TABLE public.personel_yakini;
       public         heap    postgres    false    203         �            1259    16645    personel_yakini_id_seq    SEQUENCE     �   ALTER TABLE public.personel_yakini ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personel_yakini_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    204         �            1259    16513    sehir    TABLE     \   CREATE TABLE public.sehir (
    id integer NOT NULL,
    sehir_adi character varying(45)
);
    DROP TABLE public.sehir;
       public         heap    postgres    false         �            1259    16612    sehir_id_seq    SEQUENCE     �   ALTER TABLE public.sehir ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sehir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    209         �            1259    16497    sorumlu    TABLE     i   CREATE TABLE public.sorumlu (
    ulasim_id integer,
    imalathane_id integer
)
INHERITS (public.kisi);
    DROP TABLE public.sorumlu;
       public         heap    postgres    false    203         �            1259    16647    sorumlu_id_seq    SEQUENCE     �   ALTER TABLE public.sorumlu ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sorumlu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    205         �            1259    16533    urun    TABLE     t   CREATE TABLE public.urun (
    id integer NOT NULL,
    urun_adi character varying(120),
    kategori_id integer
);
    DROP TABLE public.urun;
       public         heap    postgres    false         �            1259    16624    urun_id_seq    SEQUENCE     �   ALTER TABLE public.urun ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.urun_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);
            public          postgres    false    213         �          0    16518    adres 
   TABLE DATA           <   COPY public.adres (id, text, sehir_id, ilce_id) FROM stdin;
    public          postgres    false    210       3266.dat �          0    16503    fabrika 
   TABLE DATA           <   COPY public.fabrika (id, fabrika_adi, adres_id) FROM stdin;
    public          postgres    false    207       3263.dat �          0    16508    fabrika_imalathane 
   TABLE DATA           K   COPY public.fabrika_imalathane (id, fabrika_id, imalathane_id) FROM stdin;
    public          postgres    false    208       3264.dat �          0    16543    genel_mudur 
   TABLE DATA           M   COPY public.genel_mudur (id, ad, soyad, iletisim_id, fabrika_id) FROM stdin;
    public          postgres    false    215       3271.dat �          0    16523    ilce 
   TABLE DATA           ,   COPY public.ilce (id, ilce_adi) FROM stdin;
    public          postgres    false    211       3267.dat �          0    16478    iletisim 
   TABLE DATA           8   COPY public.iletisim (id, tel_no, adres_id) FROM stdin;
    public          postgres    false    202       3258.dat �          0    16528 
   imalathane 
   TABLE DATA           8   COPY public.imalathane (id, imalathane_adi) FROM stdin;
    public          postgres    false    212       3268.dat �          0    16538    imalathane_urun 
   TABLE DATA           E   COPY public.imalathane_urun (id, imalathane_id, urun_id) FROM stdin;
    public          postgres    false    214       3270.dat �          0    16546    kategori 
   TABLE DATA           4   COPY public.kategori (id, kategori_adi) FROM stdin;
    public          postgres    false    216       3272.dat �          0    16483    kisi 
   TABLE DATA           :   COPY public.kisi (id, ad, soyad, iletisim_id) FROM stdin;
    public          postgres    false    203       3259.dat �          0    16654    logtable 
   TABLE DATA           :   COPY public.logtable (id, log_text, time_log) FROM stdin;
    public          postgres    false    230       3286.dat �          0    16500    personel 
   TABLE DATA           T   COPY public.personel (id, ad, soyad, iletisim_id, imalathane_id, gorev) FROM stdin;
    public          postgres    false    206       3262.dat �          0    16494    personel_yakini 
   TABLE DATA           R   COPY public.personel_yakini (id, ad, soyad, iletisim_id, personel_id) FROM stdin;
    public          postgres    false    204       3260.dat �          0    16513    sehir 
   TABLE DATA           .   COPY public.sehir (id, sehir_adi) FROM stdin;
    public          postgres    false    209       3265.dat �          0    16497    sorumlu 
   TABLE DATA           W   COPY public.sorumlu (id, ad, soyad, iletisim_id, ulasim_id, imalathane_id) FROM stdin;
    public          postgres    false    205       3261.dat �          0    16533    urun 
   TABLE DATA           9   COPY public.urun (id, urun_adi, kategori_id) FROM stdin;
    public          postgres    false    213       3269.dat �           0    0    adres_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.adres_id_seq', 23, true);
          public          postgres    false    217         �           0    0    fabrika_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.fabrika_id_seq', 14, true);
          public          postgres    false    220         �           0    0    fabrika_imalathane_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.fabrika_imalathane_id_seq', 10, true);
          public          postgres    false    232         �           0    0    genel_mudur_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.genel_mudur_id_seq', 6, true);
          public          postgres    false    226         �           0    0    ilce_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.ilce_id_seq', 2, true);
          public          postgres    false    219         �           0    0    imalathane_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.imalathane_id_seq', 12, true);
          public          postgres    false    221         �           0    0    imalathane_urun_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.imalathane_urun_id_seq', 2, true);
          public          postgres    false    225         �           0    0    kategori_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.kategori_id_seq', 8, true);
          public          postgres    false    222         �           0    0    kisi_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.kisi_id_seq', 1, false);
          public          postgres    false    223         �           0    0    logtable_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.logtable_id_seq', 1, false);
          public          postgres    false    231         �           0    0    personel_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.personel_id_seq', 1, false);
          public          postgres    false    227         �           0    0    personel_yakini_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.personel_yakini_id_seq', 1, false);
          public          postgres    false    228         �           0    0    sehir_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.sehir_id_seq', 2, true);
          public          postgres    false    218         �           0    0    sorumlu_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.sorumlu_id_seq', 1, false);
          public          postgres    false    229         �           0    0    urun_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.urun_id_seq', 5, true);
          public          postgres    false    224         ,           2606    16522    adres adres_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.adres DROP CONSTRAINT adres_pkey;
       public            postgres    false    210         (           2606    16512 *   fabrika_imalathane fabrika_imalathane_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public.fabrika_imalathane
    ADD CONSTRAINT fabrika_imalathane_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.fabrika_imalathane DROP CONSTRAINT fabrika_imalathane_pkey;
       public            postgres    false    208         &           2606    16507    fabrika fabrika_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.fabrika
    ADD CONSTRAINT fabrika_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.fabrika DROP CONSTRAINT fabrika_pkey;
       public            postgres    false    207         .           2606    16527    ilce ilce_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.ilce DROP CONSTRAINT ilce_pkey;
       public            postgres    false    211                    2606    16482    iletisim iletisim_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT iletisim_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.iletisim DROP CONSTRAINT iletisim_pkey;
       public            postgres    false    202         0           2606    16532    imalathane imalathane_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.imalathane
    ADD CONSTRAINT imalathane_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.imalathane DROP CONSTRAINT imalathane_pkey;
       public            postgres    false    212         4           2606    16542 $   imalathane_urun imalathane_urun_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.imalathane_urun
    ADD CONSTRAINT imalathane_urun_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.imalathane_urun DROP CONSTRAINT imalathane_urun_pkey;
       public            postgres    false    214         6           2606    16550    kategori kategori_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.kategori DROP CONSTRAINT kategori_pkey;
       public            postgres    false    216         "           2606    16487    kisi kisi_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT kisi_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.kisi DROP CONSTRAINT kisi_pkey;
       public            postgres    false    203         8           2606    16658    logtable logtable_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.logtable
    ADD CONSTRAINT logtable_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.logtable DROP CONSTRAINT logtable_pkey;
       public            postgres    false    230         *           2606    16517    sehir sehir_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.sehir DROP CONSTRAINT sehir_pkey;
       public            postgres    false    209         $           2606    16627    sorumlu sorumlu_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.sorumlu
    ADD CONSTRAINT sorumlu_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.sorumlu DROP CONSTRAINT sorumlu_pkey;
       public            postgres    false    205         2           2606    16537    urun urun_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.urun DROP CONSTRAINT urun_pkey;
       public            postgres    false    213                     1259    16493    fki_iletisim_id    INDEX     G   CREATE INDEX fki_iletisim_id ON public.kisi USING btree (iletisim_id);
 #   DROP INDEX public.fki_iletisim_id;
       public            postgres    false    203         ;           2620    16662    kategori kategori_log_trigger    TRIGGER     �   CREATE TRIGGER kategori_log_trigger AFTER INSERT OR UPDATE OF id, kategori_adi ON public.kategori FOR EACH STATEMENT EXECUTE FUNCTION public.log_table();
 6   DROP TRIGGER kategori_log_trigger ON public.kategori;
       public          postgres    false    216    239    216    216         :           2620    16664    urun scream_alterations    TRIGGER     �   CREATE TRIGGER scream_alterations AFTER INSERT OR UPDATE ON public.urun FOR EACH STATEMENT EXECUTE FUNCTION public.trigger_scream();
 0   DROP TRIGGER scream_alterations ON public.urun;
       public          postgres    false    213    240         9           2606    16488    kisi iletisim_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT iletisim_id FOREIGN KEY (iletisim_id) REFERENCES public.iletisim(id) NOT VALID;
 :   ALTER TABLE ONLY public.kisi DROP CONSTRAINT iletisim_id;
       public          postgres    false    202    203    3103                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      3266.dat                                                                                            0000600 0004000 0002000 00000000610 13714604653 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        10	\N	1	1
11	$post["text"]	1	1
12	''	1	1
13	'kaşıkçı caddesi , 98/B'	1	1
16	çekirge	1	1
17	çekirge	1	1
18	'kaşıkçı caddesi , 98/BADAS'	1	1
19	'Yarrak Hasan caddesi'	1	2
20	'Amcık caddesi'	2	2
21	'asdasdkdksjd   jjdskdk'	1	1
8	Aybek Caddesi	1	2
9	Can Caddesi 123	1	1
22	'fabrika yeri'	1	1
23	kaşıkçı caddesi , 98/B	1	2
14	'asdasd 4343424'	1	1
15	Aybek Caddesi123 32323	2	1
\.


                                                                                                                        3263.dat                                                                                            0000600 0004000 0002000 00000000155 13714604653 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        7	çekirge	16
8	çekirge	17
13	Yeni fab	22
14	Aybekin Fabrikası	23
5	'çekirge'	14
6	Aybek Can Kaya	15
\.


                                                                                                                                                                                                                                                                                                                                                                                                                   3264.dat                                                                                            0000600 0004000 0002000 00000000060 13714604653 0014255 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        4	5	8
5	6	8
6	6	9
7	6	7
8	7	7
9	8	6
10	8	7
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                3271.dat                                                                                            0000600 0004000 0002000 00000000210 13714604653 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	osman	osmik	1	-1
3	Barış	Manço	-1	5
4	İrem	Subaşı	-1	6
5	Ricardo	Quaresma	-1	7
6	Süleyman	Seba	-1	8
2	Emmanuel	Kant	-1	-1
\.


                                                                                                                                                                                                                                                                                                                                                                                        3267.dat                                                                                            0000600 0004000 0002000 00000000025 13714604653 0014261 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	mamak
2	tuzla
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3258.dat                                                                                            0000600 0004000 0002000 00000000047 13714604653 0014265 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	02122333233	\N
2	02122333233	\N
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         3268.dat                                                                                            0000600 0004000 0002000 00000000176 13714604653 0014271 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	İstanbul İmalathanesi
7	Ankara İmalathanesi
8	Tuzla İmalathanesi
9	Yağlı Gıdalar İmalathanesi
12	Gebze İmalat
\.


                                                                                                                                                                                                                                                                                                                                                                                                  3270.dat                                                                                            0000600 0004000 0002000 00000000005 13714604653 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3272.dat                                                                                            0000600 0004000 0002000 00000000050 13714604653 0014253 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        6	Tuzlu Gıdalar
7	Tatlı Gıdalar
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3259.dat                                                                                            0000600 0004000 0002000 00000000005 13714604653 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3286.dat                                                                                            0000600 0004000 0002000 00000000005 13714604653 0014260 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3262.dat                                                                                            0000600 0004000 0002000 00000000005 13714604653 0014252 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3260.dat                                                                                            0000600 0004000 0002000 00000000005 13714604653 0014250 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3265.dat                                                                                            0000600 0004000 0002000 00000000031 13714604653 0014254 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	istanbul
2	ankara
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       3261.dat                                                                                            0000600 0004000 0002000 00000000005 13714604653 0014251 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3269.dat                                                                                            0000600 0004000 0002000 00000000066 13714604653 0014270 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        2	Zeytinyağı	-1
1	Cikolata	-1
4	Ekmek	3
5	Su	4
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                          restore.sql                                                                                         0000600 0004000 0002000 00000053432 13714604653 0015404 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.3
-- Dumped by pg_dump version 12.3

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

DROP DATABASE "Factory";
--
-- Name: Factory; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "Factory" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE "Factory" OWNER TO postgres;

\connect "Factory"

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
-- Name: add_address(integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_address(sehir_id integer, ilce_id integer, text character varying)
    LANGUAGE plpgsql
    AS $$ BEGIN
   insert into public.adres(text,sehir_id,ilce_id) values(text,sehir_id,ilce_id);
 END;$$;


ALTER PROCEDURE public.add_address(sehir_id integer, ilce_id integer, text character varying) OWNER TO postgres;

--
-- Name: add_factory(character varying, integer, integer, character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_factory(factory_name character varying, city_id integer, ilce_id integer, address_text character varying)
    LANGUAGE plpgsql
    AS $$DECLARE 
  tempMax INTEGER;
 BEGIN 
   insert into public.adres(text,sehir_id,ilce_id) values(address_text,city_id,ilce_id);
   SELECT id Into tempMax FROM public.adres ORDER BY id DESC LIMIT 1;
   insert into public.fabrika(fabrika_adi,adres_id) values(factory_name,tempMax);

 END;$$;


ALTER PROCEDURE public.add_factory(factory_name character varying, city_id integer, ilce_id integer, address_text character varying) OWNER TO postgres;

--
-- Name: add_imalathane(character varying); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.add_imalathane(imalathane_adi character varying)
    LANGUAGE plpgsql
    AS $$ BEGIN 
  insert into public.imalathane(imalathane_adi) values(imalathane_adi);
END;$$;


ALTER PROCEDURE public.add_imalathane(imalathane_adi character varying) OWNER TO postgres;

--
-- Name: log_table(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.log_table() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN
   insert into logtable select 'ALTER Table',now();
 END;$$;


ALTER FUNCTION public.log_table() OWNER TO postgres;

--
-- Name: remove_factory(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.remove_factory(factory_id integer)
    LANGUAGE plpgsql
    AS $$ BEGIN
   delete from public.fabrika WHERE id = factory_id;
   delete from public.fabrika_imalathane WHERE fabrika_id = factory_id;
   update public.genel_mudur SET fabrika_id = -1 WHERE fabrika_id = factory_id;
 END;$$;


ALTER PROCEDURE public.remove_factory(factory_id integer) OWNER TO postgres;

--
-- Name: remove_imalathane(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.remove_imalathane(im_id integer)
    LANGUAGE plpgsql
    AS $$BEGIN
   delete from public.imalathane where id = im_id;
   delete from public.imalathane_urun where imalathane_id = im_id;
   update public.personel set imalathane_id=-1 where imalathane_id = im_id;
   update public.sorumlu set imalathane_id=-1 where imalathane_id = im_id;
   delete from public.fabrika_imalathane where imalathane_id = im_id;
 END;$$;


ALTER PROCEDURE public.remove_imalathane(im_id integer) OWNER TO postgres;

--
-- Name: remove_kategori(integer); Type: PROCEDURE; Schema: public; Owner: postgres
--

CREATE PROCEDURE public.remove_kategori(cat_id integer)
    LANGUAGE plpgsql
    AS $$ BEGIN
  delete from public.kategori where id = cat_id;
  update public.urun set kategori_id = -1 where kategori_id = cat_id;
 END;$$;


ALTER PROCEDURE public.remove_kategori(cat_id integer) OWNER TO postgres;

--
-- Name: trigger_scream(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_scream() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN
      IF (TG_OP = 'DELETE') THEN
	    RAISE NOTICE 'DELETED: ';
      ELSIF (TG_OP = 'UPDATE') THEN
	    RAISE NOTICE 'UPDATED: ';
      ELSIF (TG_OP = 'INSERT') THEN
	    RAISE NOTICE 'INSERTED: ';
      END IF;
    RETURN NULL;
	END;$$;


ALTER FUNCTION public.trigger_scream() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adres (
    id integer NOT NULL,
    text character varying(220),
    sehir_id integer,
    ilce_id integer
);


ALTER TABLE public.adres OWNER TO postgres;

--
-- Name: adres_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.adres ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.adres_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: fabrika; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fabrika (
    id integer NOT NULL,
    fabrika_adi character varying(120) NOT NULL,
    adres_id integer
);


ALTER TABLE public.fabrika OWNER TO postgres;

--
-- Name: fabrika_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fabrika ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fabrika_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: fabrika_imalathane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fabrika_imalathane (
    id integer NOT NULL,
    fabrika_id integer,
    imalathane_id integer
);


ALTER TABLE public.fabrika_imalathane OWNER TO postgres;

--
-- Name: fabrika_imalathane_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.fabrika_imalathane ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.fabrika_imalathane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kisi (
    id integer NOT NULL,
    ad character varying(34) NOT NULL,
    soyad character varying(34) NOT NULL,
    iletisim_id integer
);


ALTER TABLE public.kisi OWNER TO postgres;

--
-- Name: genel_mudur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genel_mudur (
    fabrika_id integer NOT NULL
)
INHERITS (public.kisi);


ALTER TABLE public.genel_mudur OWNER TO postgres;

--
-- Name: genel_mudur_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.genel_mudur ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.genel_mudur_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: ilce; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ilce (
    id integer NOT NULL,
    ilce_adi character varying(56)
);


ALTER TABLE public.ilce OWNER TO postgres;

--
-- Name: ilce_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.ilce ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.ilce_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: iletisim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iletisim (
    id integer NOT NULL,
    tel_no character varying(24),
    adres_id integer
);


ALTER TABLE public.iletisim OWNER TO postgres;

--
-- Name: imalathane; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imalathane (
    id integer NOT NULL,
    imalathane_adi character varying(64)
);


ALTER TABLE public.imalathane OWNER TO postgres;

--
-- Name: imalathane_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.imalathane ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.imalathane_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: imalathane_urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imalathane_urun (
    id integer NOT NULL,
    imalathane_id integer,
    urun_id integer
);


ALTER TABLE public.imalathane_urun OWNER TO postgres;

--
-- Name: imalathane_urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.imalathane_urun ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.imalathane_urun_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: kategori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kategori (
    id integer NOT NULL,
    kategori_adi character varying(120)
);


ALTER TABLE public.kategori OWNER TO postgres;

--
-- Name: kategori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.kategori ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kategori_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: kisi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.kisi ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.kisi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: logtable; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logtable (
    id integer NOT NULL,
    log_text character varying(120),
    time_log timestamp(6) with time zone
);


ALTER TABLE public.logtable OWNER TO postgres;

--
-- Name: logtable_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.logtable ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.logtable_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel (
    imalathane_id integer,
    gorev character varying(120)
)
INHERITS (public.kisi);


ALTER TABLE public.personel OWNER TO postgres;

--
-- Name: personel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.personel ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: personel_yakini; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personel_yakini (
    personel_id integer
)
INHERITS (public.kisi);


ALTER TABLE public.personel_yakini OWNER TO postgres;

--
-- Name: personel_yakini_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.personel_yakini ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.personel_yakini_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: sehir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sehir (
    id integer NOT NULL,
    sehir_adi character varying(45)
);


ALTER TABLE public.sehir OWNER TO postgres;

--
-- Name: sehir_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sehir ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sehir_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: sorumlu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sorumlu (
    ulasim_id integer,
    imalathane_id integer
)
INHERITS (public.kisi);


ALTER TABLE public.sorumlu OWNER TO postgres;

--
-- Name: sorumlu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.sorumlu ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sorumlu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Name: urun; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urun (
    id integer NOT NULL,
    urun_adi character varying(120),
    kategori_id integer
);


ALTER TABLE public.urun OWNER TO postgres;

--
-- Name: urun_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.urun ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.urun_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 500
    CACHE 1
);


--
-- Data for Name: adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adres (id, text, sehir_id, ilce_id) FROM stdin;
\.
COPY public.adres (id, text, sehir_id, ilce_id) FROM '$$PATH$$/3266.dat';

--
-- Data for Name: fabrika; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fabrika (id, fabrika_adi, adres_id) FROM stdin;
\.
COPY public.fabrika (id, fabrika_adi, adres_id) FROM '$$PATH$$/3263.dat';

--
-- Data for Name: fabrika_imalathane; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fabrika_imalathane (id, fabrika_id, imalathane_id) FROM stdin;
\.
COPY public.fabrika_imalathane (id, fabrika_id, imalathane_id) FROM '$$PATH$$/3264.dat';

--
-- Data for Name: genel_mudur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genel_mudur (id, ad, soyad, iletisim_id, fabrika_id) FROM stdin;
\.
COPY public.genel_mudur (id, ad, soyad, iletisim_id, fabrika_id) FROM '$$PATH$$/3271.dat';

--
-- Data for Name: ilce; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ilce (id, ilce_adi) FROM stdin;
\.
COPY public.ilce (id, ilce_adi) FROM '$$PATH$$/3267.dat';

--
-- Data for Name: iletisim; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.iletisim (id, tel_no, adres_id) FROM stdin;
\.
COPY public.iletisim (id, tel_no, adres_id) FROM '$$PATH$$/3258.dat';

--
-- Data for Name: imalathane; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.imalathane (id, imalathane_adi) FROM stdin;
\.
COPY public.imalathane (id, imalathane_adi) FROM '$$PATH$$/3268.dat';

--
-- Data for Name: imalathane_urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.imalathane_urun (id, imalathane_id, urun_id) FROM stdin;
\.
COPY public.imalathane_urun (id, imalathane_id, urun_id) FROM '$$PATH$$/3270.dat';

--
-- Data for Name: kategori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kategori (id, kategori_adi) FROM stdin;
\.
COPY public.kategori (id, kategori_adi) FROM '$$PATH$$/3272.dat';

--
-- Data for Name: kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kisi (id, ad, soyad, iletisim_id) FROM stdin;
\.
COPY public.kisi (id, ad, soyad, iletisim_id) FROM '$$PATH$$/3259.dat';

--
-- Data for Name: logtable; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logtable (id, log_text, time_log) FROM stdin;
\.
COPY public.logtable (id, log_text, time_log) FROM '$$PATH$$/3286.dat';

--
-- Data for Name: personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel (id, ad, soyad, iletisim_id, imalathane_id, gorev) FROM stdin;
\.
COPY public.personel (id, ad, soyad, iletisim_id, imalathane_id, gorev) FROM '$$PATH$$/3262.dat';

--
-- Data for Name: personel_yakini; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personel_yakini (id, ad, soyad, iletisim_id, personel_id) FROM stdin;
\.
COPY public.personel_yakini (id, ad, soyad, iletisim_id, personel_id) FROM '$$PATH$$/3260.dat';

--
-- Data for Name: sehir; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sehir (id, sehir_adi) FROM stdin;
\.
COPY public.sehir (id, sehir_adi) FROM '$$PATH$$/3265.dat';

--
-- Data for Name: sorumlu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sorumlu (id, ad, soyad, iletisim_id, ulasim_id, imalathane_id) FROM stdin;
\.
COPY public.sorumlu (id, ad, soyad, iletisim_id, ulasim_id, imalathane_id) FROM '$$PATH$$/3261.dat';

--
-- Data for Name: urun; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urun (id, urun_adi, kategori_id) FROM stdin;
\.
COPY public.urun (id, urun_adi, kategori_id) FROM '$$PATH$$/3269.dat';

--
-- Name: adres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adres_id_seq', 23, true);


--
-- Name: fabrika_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fabrika_id_seq', 14, true);


--
-- Name: fabrika_imalathane_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fabrika_imalathane_id_seq', 10, true);


--
-- Name: genel_mudur_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.genel_mudur_id_seq', 6, true);


--
-- Name: ilce_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ilce_id_seq', 2, true);


--
-- Name: imalathane_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.imalathane_id_seq', 12, true);


--
-- Name: imalathane_urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.imalathane_urun_id_seq', 2, true);


--
-- Name: kategori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kategori_id_seq', 8, true);


--
-- Name: kisi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kisi_id_seq', 1, false);


--
-- Name: logtable_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logtable_id_seq', 1, false);


--
-- Name: personel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_id_seq', 1, false);


--
-- Name: personel_yakini_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personel_yakini_id_seq', 1, false);


--
-- Name: sehir_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sehir_id_seq', 2, true);


--
-- Name: sorumlu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sorumlu_id_seq', 1, false);


--
-- Name: urun_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.urun_id_seq', 5, true);


--
-- Name: adres adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adres
    ADD CONSTRAINT adres_pkey PRIMARY KEY (id);


--
-- Name: fabrika_imalathane fabrika_imalathane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fabrika_imalathane
    ADD CONSTRAINT fabrika_imalathane_pkey PRIMARY KEY (id);


--
-- Name: fabrika fabrika_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fabrika
    ADD CONSTRAINT fabrika_pkey PRIMARY KEY (id);


--
-- Name: ilce ilce_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ilce
    ADD CONSTRAINT ilce_pkey PRIMARY KEY (id);


--
-- Name: iletisim iletisim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT iletisim_pkey PRIMARY KEY (id);


--
-- Name: imalathane imalathane_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imalathane
    ADD CONSTRAINT imalathane_pkey PRIMARY KEY (id);


--
-- Name: imalathane_urun imalathane_urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imalathane_urun
    ADD CONSTRAINT imalathane_urun_pkey PRIMARY KEY (id);


--
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);


--
-- Name: kisi kisi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT kisi_pkey PRIMARY KEY (id);


--
-- Name: logtable logtable_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logtable
    ADD CONSTRAINT logtable_pkey PRIMARY KEY (id);


--
-- Name: sehir sehir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sehir
    ADD CONSTRAINT sehir_pkey PRIMARY KEY (id);


--
-- Name: sorumlu sorumlu_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sorumlu
    ADD CONSTRAINT sorumlu_pkey PRIMARY KEY (id);


--
-- Name: urun urun_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urun
    ADD CONSTRAINT urun_pkey PRIMARY KEY (id);


--
-- Name: fki_iletisim_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fki_iletisim_id ON public.kisi USING btree (iletisim_id);


--
-- Name: kategori kategori_log_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER kategori_log_trigger AFTER INSERT OR UPDATE OF id, kategori_adi ON public.kategori FOR EACH STATEMENT EXECUTE FUNCTION public.log_table();


--
-- Name: urun scream_alterations; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scream_alterations AFTER INSERT OR UPDATE ON public.urun FOR EACH STATEMENT EXECUTE FUNCTION public.trigger_scream();


--
-- Name: kisi iletisim_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kisi
    ADD CONSTRAINT iletisim_id FOREIGN KEY (iletisim_id) REFERENCES public.iletisim(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      