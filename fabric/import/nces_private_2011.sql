﻿--CREATE TABLE
DROP TABLE IF EXISTS analysis.nces_private_2011;
CREATE TABLE analysis.nces_private_2011
(
	PFNLWT numeric,
	REPW1 numeric,
	REPW2 numeric,
	REPW3 numeric,
	REPW4 numeric,
	REPW5 numeric,
	REPW6 numeric,
	REPW7 numeric,
	REPW8 numeric,
	REPW9 numeric,
	REPW10 numeric,
	REPW11 numeric,
	REPW12 numeric,
	REPW13 numeric,
	REPW14 numeric,
	REPW15 numeric,
	REPW16 numeric,
	REPW17 numeric,
	REPW18 numeric,
	REPW19 numeric,
	REPW20 numeric,
	REPW21 numeric,
	REPW22 numeric,
	REPW23 numeric,
	REPW24 numeric,
	REPW25 numeric,
	REPW26 numeric,
	REPW27 numeric,
	REPW28 numeric,
	REPW29 numeric,
	REPW30 numeric,
	REPW31 numeric,
	REPW32 numeric,
	REPW33 numeric,
	REPW34 numeric,
	REPW35 numeric,
	REPW36 numeric,
	REPW37 numeric,
	REPW38 numeric,
	REPW39 numeric,
	REPW40 numeric,
	REPW41 numeric,
	REPW42 numeric,
	REPW43 numeric,
	REPW44 numeric,
	REPW45 numeric,
	REPW46 numeric,
	REPW47 numeric,
	REPW48 numeric,
	REPW49 numeric,
	REPW50 numeric,
	REPW51 numeric,
	REPW52 numeric,
	REPW53 numeric,
	REPW54 numeric,
	REPW55 numeric,
	REPW56 numeric,
	REPW57 numeric,
	REPW58 numeric,
	REPW59 numeric,
	REPW60 numeric,
	REPW61 numeric,
	REPW62 numeric,
	REPW63 numeric,
	REPW64 numeric,
	REPW65 numeric,
	REPW66 numeric,
	REPW67 numeric,
	REPW68 numeric,
	REPW69 numeric,
	REPW70 numeric,
	REPW71 numeric,
	REPW72 numeric,
	REPW73 numeric,
	REPW74 numeric,
	REPW75 numeric,
	REPW76 numeric,
	REPW77 numeric,
	REPW78 numeric,
	REPW79 numeric,
	REPW80 numeric,
	REPW81 numeric,
	REPW82 numeric,
	REPW83 numeric,
	REPW84 numeric,
	REPW85 numeric,
	REPW86 numeric,
	REPW87 numeric,
	REPW88 numeric,
	CSOURCE character varying(8),
	UNGRD_OFR character varying(8),
	UNGRD_ENRL character varying(8),
	PREK_OFR character varying(8),
	PREK_ENRL character varying(8),
	KIND_OFR character varying(8),
	KIND_ENRL character varying(8),
	TRANSK_OFR character varying(8),
	TRANSK_ENRL character varying(8),
	TRANS1_OFR character varying(8),
	TRANS1_ENRL character varying(8),
	G1_OFR character varying(8),
	G1_ENRL character varying(8),
	G2_OFR character varying(8),
	G2_ENRL character varying(8),
	G3_OFR character varying(8),
	G3_ENRL character varying(8),
	G4_OFR character varying(8),
	G4_ENRL character varying(8),
	G5_OFR character varying(8),
	G5_ENRL character varying(8),
	G6_OFR character varying(8),
	G6_ENRL character varying(8),
	G7_OFR character varying(8),
	G7_ENRL character varying(8),
	G8_OFR character varying(8),
	G8_ENRL character varying(8),
	G9_OFR character varying(8),
	G9_ENRL character varying(8),
	G10_OFR character varying(8),
	G10_ENRL character varying(8),
	G11_OFR character varying(8),
	G11_ENRL character varying(8),
	G12_OFR character varying(8),
	G12_ENRL character varying(8),
	MEMBER int,
	HISP int,
	WHITE int,
	BLACK int,
	ASIAN int,
	PACIFIC_ISLAND int,
	INDIAN_ALASKA int,
	TWO_RACES int,
	COED character varying(5),
	MALE_STUDENTS character varying(5),
	STUDENTS_G12 character varying(5),
	NUMBER_G12 character varying(5),
	PCT_4YR_COLLEGE character varying(5),
	KIND_LENGTH character varying(5),
	KIND_DAYS character varying(5),
	TEACHERS_FT numeric,
	TEACHERS_3FORTHS numeric,
	TEACHERS_HT numeric,
	TEACHERS_QT numeric,
	TEACHERS_LESS_QT numeric,
	TOT_TEACHERS int,
	TYPE_SCHOOL character varying(8),
	HOMESCHOOL character varying(8),
	PRIVATE_HOME character varying(8),
	RELIGIOUS character varying(8),
	RELIG_AFFL character varying(8),
	RELIG_ORIENT character varying(8),
	CATHOLIC character varying(8),
	Q15_0 character varying(8),
	Q15_1 character varying(8),
	Q15_2 character varying(8),
	Q15_3 character varying(8),
	Q15_4 character varying(8),
	Q15_5 character varying(8),
	Q15_6 character varying(8),
	Q15_7 character varying(8),
	Q15_8 character varying(8),
	Q15_9 character varying(8),
	Q15_10 character varying(8),
	Q15_11 character varying(8),
	Q15_12 character varying(8),
	Q15_13 character varying(8),
	Q15_14 character varying(8),
	Q15_15 character varying(8),
	Q15_16 character varying(8),
	Q15_17 character varying(8),
	Q15_18 character varying(8),
	Q15_19 character varying(8),
	Q15_20 character varying(8),
	Q15_21 character varying(8),
	Q15_22 character varying(8),
	Q15_23 character varying(8),
	Q15_24 character varying(8),
	Q15_25 character varying(8),
	Q15_26 character varying(8),
	Q15_27 character varying(8),
	Q15_28 character varying(8),
	Q15_29 character varying(8),
	Q15_30 character varying(8),
	Q15_31 character varying(8),
	Q15_32 character varying(8),
	Q15_33 character varying(8),
	Q15_34 character varying(8),
	Q15_35 character varying(8),
	Q15_36 character varying(8),
	Q15_37 character varying(8),
	Q15_38 character varying(8),
	Q15_39 character varying(8),
	DAYS int,
	LENGTH_HOURS int,
	LENGTH_MINUTES int,
	LIBRARY character varying(8),
	RESPONSE_TIME character varying(5),
	PPIN  character varying(8),
	PINST character varying(50),
	PADDRS character varying(50),
	PCITY character varying(28),
	PSTABB character varying(2),
	PZIP character varying(5),
	PZIP4 character varying(4),
	PCNTY character varying(3),
	PCNTNM character varying(40),
	PL_ADD character varying(50),
	PL_CIT character varying(28),
	PL_STABB character varying(2),
	PL_ZIP character varying(5),
	PL_ZIP4 character varying(4),
	REGION character varying(8),
	PSTANSI character varying(2),
	ULOCALE12 int,
	LATITUDE12 double precision,
	LONGITUDE12 double precision,
	LOGR2012 character varying(2),
	HIGR2012 character varying(2),
	FRAME character varying(4),
	TABFLAG numeric,
	TYPOLOGY character varying(5),
	RELIG character varying(5),
	ORIENT character varying(8),
	DIOCESE character varying(8),
	LEVEL character varying(8),
	NUMSTUDS int,
	SIZE int,
	NUMTEACH float,
	UCOMMTYP int,
	TOTHRS numeric,
	MALES int,
	F_P135 numeric,
	F_P140 numeric,
	F_P145 numeric,
	F_P150 numeric,
	F_P155 numeric,
	F_P160 numeric,
	F_P165 numeric,
	F_P170 numeric,
	F_P175 numeric,
	F_P180 numeric,
	F_P185 numeric,
	F_P190 numeric,
	F_P200 numeric,
	F_P205 numeric,
	F_P210 numeric,
	F_P215 numeric,
	F_P220 numeric,
	F_P225 numeric,
	F_P230 numeric,
	F_P235 numeric,
	F_P240 numeric,
	F_P245 numeric,
	F_P250 numeric,
	F_P255 numeric,
	F_P260 numeric,
	F_P265 numeric,
	F_P270 numeric,
	F_P275 numeric,
	F_P280 numeric,
	F_P285 numeric,
	F_P290 numeric,
	F_P295 numeric,
	F_P300 numeric,
	F_P305 numeric,
	F_P320 numeric,
	F_P330 numeric,
	F_P325 numeric,
	F_P316 numeric,
	F_P318 numeric,
	F_P310 numeric,
	F_P332 numeric,
	F_P335 numeric,
	F_P340 numeric,
	F_P345 numeric,
	F_P350 numeric,
	F_P355 numeric,
	F_P360 numeric,
	F_P365 numeric,
	F_P370 numeric,
	F_P385 numeric,
	F_P390 numeric,
	F_P395 numeric,
	F_P400 numeric,
	F_P405 numeric,
	F_P410 numeric,
	F_P415 numeric,
	F_P420 numeric,
	F_P425 numeric,
	F_P430 numeric,
	F_P435 numeric,
	F_P440 numeric,
	F_P445 numeric,
	F_P450 numeric,
	F_P455 numeric,
	F_P460 numeric,
	F_P465 numeric,
	F_P467 numeric,
	F_P468 numeric,
	F_P470 numeric,
	F_P480 numeric,
	F_P485 numeric,
	F_P490 numeric,
	F_P492 numeric,
	F_P495 numeric,
	F_P500 numeric,
	F_P505 numeric,
	F_P510 numeric,
	F_P515 numeric,
	F_P520 numeric,
	F_P522 numeric,
	F_P525 numeric,
	F_P530 numeric,
	F_P535 numeric,
	F_P540 numeric,
	F_P542 numeric,
	F_P545 numeric,
	F_P550 numeric,
	F_P555 numeric,
	F_P575 numeric,
	F_P580 numeric,
	F_P585 numeric,
	F_P590 numeric,
	F_P600 numeric,
	F_P602 numeric,
	F_P605 numeric,
	F_P610 numeric,
	F_P620 numeric,
	F_P622 numeric,
	F_P625 numeric,
	F_P630 numeric,
	F_P635 numeric,
	F_P640 numeric,
	F_P645 numeric,
	F_P650 numeric,
	F_P655 numeric,
	F_P660 numeric,
	S_KG int,
	P_INDIAN float,
	P_ASIAN float,
	P_PACIFIC float,
	P_HISP float,
	P_WHITE float,
	P_BLACK float,
	P_TR float,
	STTCH_RT float	
)	
WITH (
  OIDS=FALSE
);
ALTER TABLE analysis.nces_private_2011
  OWNER TO postgres;

SET client_encoding to 'latin1';
COPY analysis.nces_private_2011
	FROM '/Users/FCC/Documents/allison/E-rate analysis/Data/NCES/pss1112_pu.txt';

--ADD GEOMETRY
ALTER table analysis.nces_private_2011 ADD COLUMN geom geometry(POINT,4326);
UPDATE analysis.nces_private_2011 SET geom = ST_SetSRID(ST_MakePoint(LONGITUDE12,LATITUDE12),4326);
CREATE INDEX nces_private_2011_geom_gist ON analysis.nces_public_2011 USING GIST(geom);

--DROP FOREIGN DOD SCHOOLS
--DELETE FROM analysis.nces_private_2011
--WHERE FIPST = '63' AND latcod = 0 AND loncod = 0;