set feedback off
create table listpriv as 
select GRANTOR,GRANTEE,OWNER,TABLE_NAME,PRIVILEGE,GRANTABLE from dba_tab_privs where grantee  in (select username from dba_users where username not in ('SYS', 'SYSTEM', 'WMSYS', 'SYSMAN','MDSYS','ORDSYS','XDB', 'WKSYS', 'EXFSYS', 
         'OLAPSYS', 'DBSNMP', 'DMSYS','CTXSYS','WK_TEST', 'ORDPLUGINS', 'OUTLN','REMOTE_SCHEDULER_AGE',
         'APPQOSSYS','DBSFWUSER','SQLTXADMIN','SI_INFORMTN_SCHEMA','DVF','DVSYS','GSMADMIN_INTERNAL','SQLTXPLAIN',
         'MDSYS','ORDDATA','OLAPSYS','OUTLN','ORACLE_OCM','ORDSYS','WMSYS','LBACSYS','AUDSYS','REMOTE_SCHEDULER_AGENT','OJVMSYS','PUBLIC'
         ,'GSMROOTUSER','XS$NULL','SYS$UMF','GGSYS','ANONYMOUS','GSMCATUSER','MDDATA','SYSBACKUP','GSMROOTUSER','SYSRAC','SYSDG','SYSKM'
         ,'LBACSYS','DIP','TEST','GSMUSER'));   
set lin 300
COL GRANTEE FOR A20
COL OWNER FOR A20
COL TABLE_NAME FOR A20
COL GRANTOR FOR A20
COL PRIVILEGE FOR A20
col CONNECT_PATH for a30
select * from  listpriv;
create table c0 as
select GRANTOR,
GRANTEE,
OWNER,
TABLE_NAME,
PRIVILEGE,
GRANTABLE,
owner||'/'||table_name  as topshu,
owner||'/'||table_name||'/'||PRIVILEGE as cengji
from listpriv;
create table c1 as 
select owner,table_name,owner||'/'||table_name  as topshu from listpriv group by owner,table_name;
create table c2 as 
select owner,table_name,privilege,owner||'/'||table_name  as topshu,owner||'/'||table_name||'/'||PRIVILEGE as cengji 
from listpriv;
create table tree1 as 
select c0.GRANTOR,c0.GRANTEE,c0.topshu,c0.cengji,c0.GRANTABLE from c0,c1
where c0.GRANTOR=c1.owner and c0.topshu=c1.topshu;
create table tree2 as 
(
select GRANTOR,GRANTEE,topshu,cengji,GRANTABLE from (
select c0.GRANTOR,c0.GRANTEE,c0.topshu,c0.cengji,c0.GRANTABLE from c0,c2,tree1
where c0.cengji=c2.cengji
and tree1.cengji=c2.cengji
and tree1.GRANTEE=c0.GRANTOR) group by GRANTOR,GRANTEE,topshu,cengji,GRANTABLE
);
create table tree3 as 
(
select GRANTOR,GRANTEE,topshu,cengji,GRANTABLE from (
select c0.GRANTOR,c0.GRANTEE,c0.topshu,c0.cengji,c0.GRANTABLE from c0,c2,tree2
where c0.cengji=c2.cengji
and tree2.cengji=c2.cengji
and tree2.GRANTEE=c0.GRANTOR) group by GRANTOR,GRANTEE,topshu,cengji,GRANTABLE
);
create or replace procedure pro_3 wrapped 
a000000
354
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
7
6a6 2c9
Q+QYnKSqB+cEltDip2OEB3P553kwgztc2Uj8fC/NPM+VfsVnwMy6p/ONdhepw69KdrDtv42u
fT1MTggNhhcRCTLMNhjNiHJurcEWoPLA2CMCpbu1xksHRbqNMOWVnsVdsl5T4aYZCtzF3Qza
tBdVNQeywLJcVSmjdQKneb+5+0ryh2fV27Dhii4S6aic5Z7Eu43Psaq6ViuP/fNOO5cMeIWH
xO0ZWJpQd+F4HgdPEDy6XnSRbWYhLfhglzzmqe8nP9yPAqeI2OBZryQNQP7HxbiWGiKXh87O
VjTDkcHUmkWRJKc6yF+E5uOw98ecvPPTGXUGF+hBxIgmSZV0YOnGSWYyMYmMV+08uYmNshvi
T2L1jA4MeueTRkC8XsjKioKy1DTjtNj6hQvbU3waLnQ2BQ2GV2jAFJr10P7TMfNyRnkTgrtb
wryHIOW5erqxClLZ2Ql2s9s4G/xaTOdg5YZHtlLXr8OaWTj/eFYYDNmas0K7Mp+IWzlZw2uX
a19o89TP+rSfA6poi1KW6wm0KlR0SRGayQRmi4a2mOlqiJeLPWuZ8cmUSYdZSF1orX/hUfer
q1oOOHHssqdc/1WXOuqw0SM97CrfSjNfpjTB4V9TkIKQNTiJYYKLFzT3pEpNm17EoDM2dGSW
8XnjmmiJmZV27PX5mZaLofhS+zOdqMaPRbCc/nV5tqNsBxBS/r1PX18Y

/
set serveroutput on;
exec pro_3
drop table listpriv;
drop table c0;
drop table c1;
drop table c2;
drop table tree1;
drop table tree2;
drop table tree3;
