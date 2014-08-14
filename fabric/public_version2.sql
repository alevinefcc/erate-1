﻿--CREATE MASTER TABLE
drop table if exists fabric.master3;

create table fabric.master3 as
select ncessch, fipst, leaid, schno, stid, seasch, leanm, schnam, lstree, lcity, lstate, lzip, lzip4, type, 
	status, ulocal, latcod, loncod, conum, coname, cdcode, bies, level, chartr, member, geom
from analysis.nces_public_2011;

--VIEW TABLE
select *
from fabric.master3;

--CAI 
select ncessch, caiid, fiber
from fabric.master3, analysis.cai_dec2013
where cai_dec2013.caiid = master3.ncessch;

alter table fabric.master3
	drop column if exists cai1;
alter table fabric.master3
	add column cai1 int;
with new_values as(
select caiid, fiber as cai_fiber
	from analysis.cai_dec2013
)
update fabric.master3
	set cai1 = new_values.cai_fiber
	from new_values
	where new_values.caiid=master3.ncessch;

select seasch, caiid, lstate, statecode, fiber
from fabric.master3, analysis.cai_dec2013
where cai_dec2013.caiid = master3.seasch
	and lstate = statecode;

alter table fabric.master3
	drop column if exists cai2;
alter table fabric.master3
	add column cai2 int;
with new_values as(
select caiid, statecode, fiber as cai_fiber
	from analysis.cai_dec2013
)
update fabric.master3
	set cai2 = new_values.cai_fiber
	from new_values
	where new_values.caiid=master3.seasch
		and statecode=lstate;

select stid, caiid, lstate, statecode fiber
from fabric.master3, analysis.cai_dec2013
where cai_dec2013.caiid = master3.stid
	and statecode = lstate;

alter table fabric.master3
	drop column if exists cai3;
alter table fabric.master3
	add column cai3 int;
with new_values as(
select caiid, statecode, fiber as cai_fiber
	from analysis.cai_dec2013
)
update fabric.master3
	set cai3 = new_values.cai_fiber
	from new_values
	where new_values.caiid=master3.stid
		and statecode = lstate;

alter table fabric.master3
	add column cai int;
update fabric.master3
	set cai = cai1
	where cai1 is not null;
update fabric.master3
	set cai = cai2
	where cai2 is not null;
update fabric.master3
	set cai = cai3
	where cai3 is not null;

select cai, count(*)
from fabric.master3
group by cai;

--CALIFORNIA (HSN K-12)
alter table fabric.master3
	drop column if exists st_cd;
alter table fabric.master3
	add column st_cd character varying(30);
update fabric.master3
	set st_cd = stid || seasch
	where lstate = 'CA';

select st_cd, cds_code, fiber
	from fabric.master3, fabric.cenic
	where master3.st_cd = cds_code
	and lstate = 'CA';

alter table fabric.master3
	drop column if exists ca_ind;
alter table fabric.master3
	add column ca_ind int;
with new_values as(
select cds_code, fiber as ca_fiber
	from fabric.cenic
	order by cds_code
)
update fabric.master3
	set ca_ind = new_values.ca_fiber
	from new_values
	where new_values.cds_code=master3.st_cd
		and lstate = 'CA';

--FLORIDA
alter table fabric.master3
	drop column if exists stid_fl;
alter table fabric.master3
	add column stid_fl character varying(2);
update fabric.master3
	set stid_fl = '0' || stid
	from fabric.fl_ind
	where char_length(stid) = 1
	and lstate = 'FL';
update fabric.master3
	set stid_fl = stid
	from fabric.fl_ind
	where char_length(stid) = 2;
alter table fabric.master3
	drop column if exists sea_fl;
alter table fabric.master3
	add column sea_fl character varying(4);
update fabric.master3
	set sea_fl = '000' || seasch
	where char_length(seasch) = 1
	and lstate = 'FL';
update fabric.master3
	set sea_fl = '00' || seasch
	where char_length(seasch) = 2
	and lstate = 'FL';
update fabric.master3
	set sea_fl = '0' || seasch
	where char_length(seasch) = 3
	and lstate  = 'FL';
update fabric.master3
	set sea_fl = seasch
	where char_length(seasch) = 4
	and lstate = 'FL';
alter table fabric.master3
	drop column if exists scd_fl;
alter table fabric.master3
	add column scd_fl character varying(22);
update fabric.master3
	set scd_fl = stid_fl || ' ' || sea_fl
	where lstate = 'FL';

select scd_fl, school_code, fiber
	from fabric.master3, fabric.fl_ind
	where master3.scd_fl = fl_ind.school_code
		and lstate = 'FL';

alter table fabric.master3
	drop column if exists fl_ind;
alter table fabric.master3
	add column fl_ind int;
with new_values as(
select school_code, fiber as fl_fiber
	from fabric.fl_ind
	order by school_code
)
update fabric.master3
	set fl_ind=new_values.fl_fiber
	from new_values
	where master3.scd_fl=new_values.school_code
		and lstate = 'FL';

--WEST VIRGINIA
select wv_school_id, seasch
	from fabric.master3, fabric.wv_ind
	where master3.seasch=wv_ind.wv_school_id
		and lstate = 'WV';

alter table fabric.master3
	drop column if exists wv_ind;
alter table fabric.master3
	add column wv_ind int;
with new_values as(
select wv_school_id, fiber as wv_fiber
	from fabric.wv_ind
	order by wv_school_id
)
update fabric.master3
	set wv_ind=new_values.wv_fiber
	from new_values
	where master3.seasch=new_values.wv_school_id
		and lstate = 'WV';

--NORTH CAROLINA
alter table fabric.master3
	drop column if exists nc_ind;
alter table fabric.master3
	add column nc_ind int;
update fabric.master3
	set nc_ind = -2
	where (schnam = 'STANFIELD ELEMENTARY' or schnam = 'CHARLES E PERRY ELEMENTARY'
		or coname = 'NASH COUNTY' or coname = 'DAVIDSON COUNTY' or coname = 'FRANKLIN COUNTY'
		or coname = 'WARREN COUNTY' or coname = 'IREDELL COUNTY' or coname = 'CASEWELL COUNTY')
		and lstate = 'NC';
update fabric.master3
	set nc_ind = 2
	where nc_ind is null and lstate = 'NC';

--NEW MEXICO
select master3.ncessch, nm_ind.nces_id
	from fabric.master3, fabric.nm_ind
	where master3.ncessch=nm_ind.nces_id
		and lstate = 'NM';

alter table fabric.master3
	drop column if exists nm_ind;
alter table fabric.master3
	add column nm_ind int;
with new_values as(
select nces_id, fiber as nm_fiber
	from fabric.nm_ind
	order by nces_id
)
update fabric.master3
	set nm_ind=new_values.nm_fiber
	from new_values
	where master3.ncessch=new_values.nces_id
		and lstate = 'NM';

--MAINE
select master3.ncessch, me_ind.nces_id
	from fabric.master3, fabric.me_ind
	where master3.ncessch=me_ind.nces_id
		and lstate = 'ME';

alter table fabric.master3
	drop column if exists me_ind;
alter table fabric.master3
	add column me_ind int;
with new_values as(
select nces_id, fiber as me_fiber
	from fabric.me_ind
	order by nces_id
)
update fabric.master3
	set me_ind=new_values.me_fiber
	from new_values
	where master3.ncessch=new_values.nces_id
		and lstate = 'ME';

--TEXAS
alter table fabric.master3
	drop column if exists tx_ind;
alter table fabric.master3
	add column tx_ind int;
update fabric.master3
	set tx_ind = 2
	where leanm = 'ROUND ROCK ISD'
		and lstate = 'TX';
update fabric.master3
	set tx_ind = 2
	where leanm = 'PALESTINE ISD'
		and lstate = 'TX';

--MONTANA
select master3.schnam, mt_ind.school_name
	from fabric.master3, fabric.mt_ind
	where master3.schnam = upper(mt_ind.school_name)
		and master3.leanm = upper(mt_ind.district_name)
		and lstate='MT';

alter table fabric.master3
	drop column if exists mt_ind;
alter table fabric.master3
	add column mt_ind int;
with new_values as(
select school_name, district_name, fiber as mt_fiber
	from fabric.mt_ind
)
update fabric.master3
	set mt_ind=new_values.mt_fiber
	from new_values
	where master3.schnam = upper(new_values.school_name)
		and master3.leanm = upper(new_values.district_name)
		and lstate = 'MT';

update fabric.master3
	set mt_ind = -1
	where lstate = 'MT' and (schnam = 'POLARIS SCHOOL' or schnam = 'PLENTY COUPS HIGH SCHOOL' 
		or schnam = 'LUTHER SCHOOL' or schnam = 'HAMMOND SCHOOL' or schnam = 'HAWKS HOME SCHOOL' 
		or schnam = 'BENTON LAKE SCHOOL' or schnam = 'KINSEY SCHOOL' or ncessch = '302088000624' 
		or schnam = 'WEST GLACIER SCHOOL' or schnam = 'MALMBORG SCHOOL' or schnam = 'PASS CREEK SCHOOL' 
		or schnam = 'KESTER SCHOOL' or schnam = 'BABB SCHOOL' or schnam = 'EAST GLACIER PARK' 
		or schnam = 'GLENDALE SCHOOL' or schnam = 'CARDWELL SCHOOL' or ncessch = '300009800325' 
		or schnam = 'SAGE CREEK ELEMENTARY' or schnam = 'YAAK SCHOOL' or ncessch = '302067000619' 
		or ncessch = '302067000166' or ncessch = '300093201025' or ncessch = '300093201024' or ncessch = '300093301026'
		or ncessch = '301719000538' or ncessch = '301719000251' or schnam = 'FISHTAIL SCHOOL'
		or schnam = 'LUSTRE SCHOOL' or schnam = 'MORIN SCHOOL' or schnam = 'PRAIRIE ELK COLONY SCHOOL'
		or schnam = 'RIMROCK COLONY SCHOOL' or schnam = 'MIAMI COLONY SCHOOL' or schnam = 'MIDWAY COLONY SCHOOL'
		or schnam = 'KING COLONY SCHOOL' or schnam = 'FAIRHAVEN COLONY SCHOOL' or schnam = 'CASCADE COLONY SCHOOL'
		or schnam = 'DEERFIELD COLONY SCHOOL' or schnam = 'NORTH HARLEM COLONY SCHOOL' or schnam = 'SPRING CREEK COLONY SCHOOL');

--SUNESYS
select sunesys.rev_appname, leanm, appstate, lstate
	from fabric.sunesys, fabric.master3
	where rev_appname=leanm
		and appstate=lstate
		and apptype = 'District';

alter table fabric.master3
	add column sunesys int;
with new_values as(
select sunesys.rev_appname, appstate, apptype, fiber as sunesys_fiber
	from fabric.sunesys
)
update fabric.master3
	set sunesys=new_values.sunesys_fiber
	from new_values
	where leanm=new_values.rev_appname
		and lstate=new_values.appstate
		and apptype = 'District';

--OHIO
select schnam, building_name, fiber, lcity, building_city
from fabric.master3, fabric.oh_ind
where master3.schnam = upper(oh_ind.building_name)
	and master3.lcity = upper(oh_ind.building_city)
	and lstate = 'OH';

alter table fabric.master3
	drop column if exists oh_ind;
alter table fabric.master3
	add column oh_ind int;
with new_values as(
select building_name, building_city, fiber as oh_fiber
from fabric.oh_ind
)
update fabric.master3
	set oh_ind = new_values.oh_fiber
	from new_values
	where master3.schnam = upper(new_values.building_name)
	and master3.lcity = upper(new_values.building_city)
	and master3.lstate = 'OH';

--FAT BEAM
alter table fabric.master3
	drop column if exists fatbeam;
alter table fabric.master3
	add column fatbeam int;
update fabric.master3
	set fatbeam = 2
	where leaid = '5301140' or leaid = '5303510' or leaid = '5304950' or leaid = '5308670' or leaid = '5310110'
		or leaid = '3005280' or leaid = '3005310' or leaid = '1600780' or leaid = '5305370' or leaid = '5302940'
		or leaid = '1602670';

--GEORGIA
select schnam, school_name, lcity, city, fiber
from fabric.master3, fabric.ga_ind
where master3.schnam = upper(ga_ind.school_name)
	and master3.lcity = upper(ga_ind.city);

alter table fabric.master3
	drop column if exists ga_ind;
alter table fabric.master3
	add column ga_ind int;
with new_values as(
select school_name, city, fiber AS ga_fiber
from fabric.ga_ind
)
update fabric.master3
set ga_ind = new_values.ga_fiber
from new_values
where master3.schnam = upper(new_values.school_name)
	and lcity = upper(new_values.city)
	and lstate = 'GA';

--BIE
select school_code, seasch, fiber
from fabric.master3, fabric.bie_ind
where seasch = school_code;

alter table fabric.master3
	drop column if exists bie_ind;
alter table fabric.master3
	add column bie_ind int;
with new_values as(
select school_code, fiber AS bie_fiber
from fabric.bie_ind
)
update fabric.master3
set bie_ind = new_values.bie_fiber
from new_values
where master3.seasch = new_values.school_code;

--NAVAJO
select ncessch, nces_id, fiber
from fabric.master3, fabric.navajo_schools
where master3.ncessch=navajo_schools.nces_id;

alter table fabric.master3
	drop column if exists navajo;
alter table fabric.master3
	add column navajo int;
with new_values as(
select nces_id, fiber as navajo_fiber
	from fabric.navajo_schools
	order by nces_id
)
update fabric.master3
	set navajo = new_values.navajo_fiber
	from new_values
	where new_values.nces_id=master3.ncessch;

--ARIZONA
alter table fabric.master3
	drop column if exists az_ind;
alter table fabric.master3
	add column az_ind int;
update fabric.master3
	set az_ind = 2
	where leanm = 'NOGALES UNIFIED DISTRICT'
		and lstate = 'AZ';

--TEXAS
alter table fabric.master3
	drop column if exists tx_ind;
alter table fabric.master3
	add column tx_ind int;
update fabric.master3
	set tx_ind = 2
	where leanm = 'ROUND ROCK ISD'
		and lstate = 'TX';
update fabric.master3
	set tx_ind = 2
	where leanm = 'PALESTINE ISD'
		and lstate = 'TX';

--PUERTO RICO
alter table fabric.master3
	drop column if exists pr_ind;
alter table fabric.master3
	add column pr_ind int;

with new_values as(
select school_code, fiber
from fabric.pr_ind
)
update fabric.master3
set pr_ind = new_values.fiber
from new_values
where seasch = school_code
	and lstate = 'PR';

--EMAIL SUBMISSIONS
alter table fabric.master3
	drop column if exists email;
alter table fabric.master3
	add column email int;

update fabric.master3
set email = 2
where leaid = '0200150';

update fabric.master3
set email = 2 
where leaid = '2510050';

update fabric.master3
set email = 2
where ncessch = '551044001363';

update fabric.master3
set email = 2
where ncessch = '390500203801' or ncessch = '390500203802' or ncessch = '390500203803' or ncessch = '390500203804'
	or ncessch = '390500200199' or ncessch = '390500203805';

update fabric.master3
set email = 2
where ncessch = '173441003526' or ncessch = '173441003527' or ncessch = '173441003538' or ncessch = '173441003528' 
	or ncessch = '173441003530' or ncessch = '173441006107' or ncessch = '173441003534' or ncessch = '170020406200' 
	or ncessch = '173441006155' or ncessch = '173441003535' or ncessch = '173441005967' or ncessch = '173441003540' 
	or ncessch = '173441003536' or ncessch = '173441005338' or ncessch = '173441003529';

update fabric.master3
set email = 2
where ncessch = '171410004687' or ncessch = '171410001760' or ncessch = '171410001762' or ncessch = '171410005506' 
	or ncessch = '171410001761';

update fabric.master3
set email = 2
where ncessch = '171605001914' or ncessch = '171605001913' or ncessch = '171605001912';

update fabric.master3
set email = 2
where ncessch = '550567000601' or ncessch = '550567000602' or ncessch = '550567000603' or ncessch = '550567002704'
	or ncessch = '550567000604';

update fabric.master3
set email = 2
where leaid = '5308910' or leaid = '5309930';

update fabric.master3
set email = 2
where leaid = '3904857' or leaid = '3910030' or leaid = '3904859' or leaid = '3904858';

update fabric.master3
set email = 2
where leaid = '2102940' or leaid = '2104620';

update fabric.master3
set email = 2 
where leaid = '2003570' or leaid = '2008130' or leaid = '2009450' or leaid = '2008310' or leaid = '2011430';

update fabric.master3
set email = 2
where leaid = '010162' or leaid = '012311' or leaid = '010599' or leaid = '010601' or leaid = '010561'
	or leaid = '010447' or leaid = '010627' or leaid = '010628' or leaid = '010630' or leaid = '012609';

update fabric.master3
set email = 2
where leaid = '1918930';



--------------------------------CORROBORATION SCORING----------------------------------
--MAP SCORE
alter table fabric.master3
	drop column if exists score_map;
alter table fabric.master3
	add column score_map int;

with new_values as(
select ncessch, coalesce(cai,0) + coalesce(ca_ind,0) + coalesce(fl_ind,0) + coalesce(wv_ind,0) 
	+ coalesce(nc_ind,0) + coalesce(nm_ind,0) + coalesce(me_ind,0) + coalesce(mt_ind,0)
	+ coalesce(sunesys,0) + coalesce(oh_ind,0) + coalesce(fatbeam,0) + coalesce(ga_ind,0)
	+ coalesce(navajo,0) + coalesce(bie_ind,0) + coalesce(az_ind,0) + coalesce(tx_ind,0)
	+ coalesce(pr_ind,0) + coalesce(email,0)
	as row_score
from fabric.master3
)
update fabric.master3
set score_map = new_values.row_score
from new_values
where master3.ncessch = new_values.ncessch;

alter table fabric.master3
	drop column if exists fiber_map;
alter table fabric.master3
	add column fiber_map int;

update fabric.master3
set fiber_map = 1
where score_map > 0;

update fabric.master3
set fiber_map = 0
where score_map = 0;

update fabric.master3
set fiber_map = -1
where score_map < 0;

select fiber_map, count(*)
from fabric.master3
group by fiber_map
order by fiber_map;

select score_map, count(*)
from fabric.master3
group by score_map
order by score_map;

drop table if exists fabric.map_fiber_aug1;
create table fabric.map_fiber_aug1 as(
select ncessch, leaid, ulocal, member, geom, score_map, fiber_map
from fabric.master3
);

copy(select * from fabric.map_fiber_aug1) to '/Users/FCC/Documents/allison/E-rate analysis/Maps/map_fiber_aug1.csv' with delimiter '|' CSV header;

select fiber_map, score_map, count(*)
from fabric.map_fiber_aug1
group by fiber_map, score_map
order by fiber_map, score_map;