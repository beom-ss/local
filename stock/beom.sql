
select * from STC_DMS_FSQ

select count(*) as cnt
  from (
        SELECT NAME
             , CODE
             , COUNT(*)
             
          FROM STC_DMS_ITM_PRC_DD
         GROUP BY NAME
             , CODE
         ORDER BY CODE
    ) a
;
create table tt as 
 select substr(code,1,6) code
  from STC_DMS_ITM

CREATE TABLE STC_DMS_ITM3 AS
SELECT DBMS_LOB.SUBSTR( NAME, 1000, 1)  as NAME
     , DBMS_LOB.SUBSTR( CODE, 6, 1)  as CODE
     , DBMS_LOB.SUBSTR( TYPE, 4000, 1)  as TYPE
FROM STC_DMS_ITM;


SELECT COALESCE(T1.NAME, T2.NAME) AS NAME
     , COALESCE(T1.CODE, T2.CODE) AS CODE
     , T1.TYPE AS TYPE1
     , T2.TYPE AS TYPE2
     , T2.MKT_NM
  FROM STC_DMS_ITM3 T1
       FULL JOIN STC_DMS_ITM2 T2
              ON T1.CODE = T2.CODE
 WHERE (T2.TYPE IS NULL) OR (T1.TYPE IS NULL)
 
 
select tkr_cd
     , count(tkr_cd)
  from stc_dms_vly_h
 group by tkr_cd



select tkr_cd
     , min(basc_dt) as min_dt
     , max(basc_dt) as max_dt
     , count(distinct basc_dt)
     , count(basc_dt)
  from STC_DMS_TKR_PRC
 group by tkr_cd

select basc_dt
     , count(*)
  from STC_DMS_TKR_PRC
 group by basc_dt
 order by basc_dt desc
 
select tkr_cd
     , min(basc_dt)
     , max(basc_dt)
     , count(basc_dt)
     , count(distinct basc_dt)
  from STC_DMS_TKR_PRC
 group by tkr_cd
 order by tkr_cd desc
 
select count(*) from STC_DMS_TKR_PRC

create table STC_DMS_TKR_PRC_BK as
select TKR_CD
     , regexp_replace(BASC_DT,'([0-9]{4})-([0-9]{2})-([0-9]{2})','\1\2\3') as BASC_DT
     , OPN_PRC
     , HGH_PRC
     , LOW_PRC
     , CLS_PRC
     , VLM
  from STC_DMS_TKR_PRC
;


select count(*) from stc_dms_fsy

select idx_cd
     , min(basc_dt)
     , max(basc_dt)
     , count(basc_dt)
     , count(distinct basc_dt)
  from STC_IDX_KOSPI
 group by idx_cd
 order by idx_cd desc
 
select idx_cd
     , min(basc_dt)
     , max(basc_dt)
     , count(basc_dt)
     , count(distinct basc_dt)
  from STC_IDX_NI225
 group by idx_cd
 order by idx_cd desc
 
 
 select *
   from STC_DMS_TKR_PRC
  where tkr_cd = '003350'
    and basc_dt = '2021-03-31'
    
select * from STC_DMS_TKR_RNK order by 

drop table STC_IDX_SP

select min(basc_dt)
     , max(basc_dt)
     , count(basc_dt)
  from STC_IDX_SP 
  
  


SELECT basc_dt
     , 
    tkr_cd,
    tkr_nm,
    sct_lrg_cd,
    sct_lrg_nm,
    sct_sml_cd,
    sct_sml_nm,
    mkt_gb,
    ind_cat,
    mkt_cap,
    dps,
    rank
  FROM stc_dms_tkr_rnk
 WHERE TKR_NM = 'ÆÞ¾îºñ½º'
 ORDER BY BASC_DT, RANK
 
 
 select max(basc_dt)
   from stc_etf_dbc
  