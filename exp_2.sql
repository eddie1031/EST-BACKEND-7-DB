-- 데이터베이스 생성
drop database if exists `dj_air_port`;
create database `dj_air_port`;
use `dj_air_port`;

-- 대전 공항 운임표
CREATE TABLE `draft` (
  `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `sort` VARCHAR(4) NOT NULL,
  `is_rush` TINYINT(1) UNSIGNED NOT NULL COMMENT 'true :1, false: 0',
  `target_nation` VARCHAR(5) NOT NULL,
  `airline` VARCHAR(10) NOT NULL,
  `distance` TINYINT(1) UNSIGNED NOT NULL,
  `special_rate` INT(10) UNSIGNED NOT NULL,
  `freight_charge` INT(10) UNSIGNED NOT NULL,
  `shipment_date` DATE NOT NULL
);

-- 데이터 추가

INSERT INTO `draft`
    (sort, is_rush, target_nation, airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('식품', 0, '중국', '대한한공', 1, 0, 1500, '2024-11-30')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation, airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('기호품', 0, '호주', '아시아나', 2, 0, 2000, '2024-11-30')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation,  airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('전자제품', 1, '일본', '닛폰항공', 1, 1000, 1500, '2024-11-30')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation,  airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('의약품', 1, '미국',  '델타항공', 4, 1000, 3000, '2024-12-01')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation,  airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('식품', 0, '인도', '고우에어', 3, 0, 2500, '2024-12-01')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation, airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('일반우편', 0, '캐나다', '대한항공', 4, 0, 3000, '2024-12-01')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation, airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('의류', 1, '일본',  '아시아나', 1, 1000, 1500, '2024-12-02')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation,  airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('전자제품', 1, '미국',  '델타항공', 4, 1000, 3000, '2024-12-02')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation, airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('주류', 1, '칠레',  '라탐항공', 4, 1000, 3000, '2024-12-03')
;

INSERT INTO `draft`
    (sort, is_rush, target_nation,  airline, distance, special_rate, freight_charge, shipment_date)
VALUES
    ('주류', 1, '독일',  '대한항공', 4, 1000, 3000, '2024-12-03')
;

-- 전체 데이터 조회
SELECT *
FROM `draft`;

-- Group By
SELECT
    target_nation AS '목적지',
    COUNT(target_nation) AS '항공편 수'
FROM
    `draft`
GROUP BY
    target_nation
;

-- 품류 관리 표
CREATE TABLE `sort_table` (
    `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `sort` VARCHAR(4) NOT NULL,
    `is_rush` TINYINT(1) UNSIGNED NOT NULL COMMENT 'true :1, false: 0'
);

-- 데이터 생성

INSERT INTO `sort_table`
SET `sort` = '식품',
`is_rush` = 0;


INSERT INTO `sort_table`
SET `sort` = '기호품',
`is_rush` = 0;


INSERT INTO `sort_table`
SET `sort` = '전자제품',
`is_rush` = 1;


INSERT INTO `sort_table`
SET `sort` = '의약품',
`is_rush` = 1;


INSERT INTO `sort_table`
SET `sort` = '의류',
`is_rush` = 0;


INSERT INTO `sort_table`
SET `sort` = '주류',
`is_rush` = 1;


INSERT INTO `sort_table`
SET `sort` = '일반우편',
`is_rush` = 0;

-- 표 구조 확인
desc draft;

-- 두 테이블을 Join하여 동일한 컬럼 값으로 변경
update
    draft d
join
    sort_table st
on
    d.sort = st.sort
set
    d.sort_table_id = st.id
;

-- 외래키 추가
alter table
    draft
add
    foreign key(sort_table_id)
references
    sort_table(id)
;

-- 불필요한 컬럼 삭제
alter table draft drop column sort;
alter table draft drop column is_rush;

-- 표 구조 확인
desc draft;

-- 품류 관리 표 조회
SELECT
    `id` AS '번호',
    `sort` AS '품류',
    IF(`is_rush` = 0, 'x', 'o') AS '특별 수하물 여부'
#     CASE
#       WHEN
#         `is_rush` = 0
#       THEN
#         'o'
#       ELSE
#         'x'
#     END AS '특별 수하물 여부'
FROM
    `sort_table`
;

-- 두 테이블을 이용해서 이전과 같이 표시해보기
select
    d.id as 번호,
    st.sort as 품류,
    IF(`is_rush` = 0, 'o', 'x') AS '특별 수하물 여부',
    d.target_nation as 대상국,
    d.airline as 항공사,
    d.distance as 거리_단위,
    d.special_rate as 특별운임,
    d.freight_charge as 운임,
    d.shipment_date as 보내는_날짜
from
    draft d
left join
    sort_table st
on
    d.sort_table_id = st.id
;

-- 거리당 운임 표
CREATE TABLE `distance_charge` (
    `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `culture_code` VARCHAR(5) NOT NULL UNIQUE,
    `distance` TINYINT(1) UNSIGNED NOT NULL,
    `frieght_charge` INT(10) UNSIGNED NOT NULL
);

-- 데이터 추가
INSERT INTO `distance_charge`
SET `culture_code` = '아시아',
`distance` = 1,
`frieght_charge` = 1500
;

INSERT INTO `distance_charge`
SET `culture_code` = '오세아니아',
`distance` = 2,
`frieght_charge` = 2000
;

INSERT INTO `distance_charge`
SET `culture_code` = '인도',
`distance` = 3,
`frieght_charge` = 2500
;

INSERT INTO `distance_charge`
SET `culture_code` = '유럽-미국',
`distance` = 4,
`frieght_charge` = 3000
;

-- 문화권 테이블
CREATE TABLE `culture` (
    `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `culture_code` VARCHAR(5) NOT NULL,
    `nation` VARCHAR(5) NOT NULL UNIQUE
);

-- 데이터추가

INSERT INTO `culture`
SET `culture_code` = '아시아',
`nation` = '한국'
;

INSERT INTO `culture`
SET `culture_code` = '아시아',
`nation` = '일본'
;

INSERT INTO `culture`
SET `culture_code` = '아시아',
`nation` = '중국'
;

INSERT INTO `culture`
SET `culture_code` = '오세아니아',
`nation` = '호주'
;

INSERT INTO `culture`
SET `culture_code` = '인도',
`nation` = '인도'
;

INSERT INTO `culture`
SET `culture_code` = '유럽-미국',
`nation` = '독일'
;

INSERT INTO `culture`
SET `culture_code` = '유럽-미국',
`nation` = '칠레'
;

INSERT INTO `culture`
SET `culture_code` = '유럽-미국',
`nation` = '미국'
;

INSERT INTO `culture`
SET `culture_code` = '유럽-미국',
`nation` = '캐나다'
;

-- 운임표에서 불필요한 컬럼 삭제
alter table draft drop column distance;
alter table draft drop column special_rate;
alter table draft drop column freight_charge;

-- 외래키 추가
alter table
    draft
add constraint
    fk_export_nt foreign key(target_nation)
references
    culture(nation)
;

-- 테이블 구조 확인
desc draft;

-- 외래키 추가
alter table
    culture
add constraint
    foreign key(culture_code)
references
    distance_charge(culture_code)
;

-- 테이블 구조 확인
desc culture;

-- 특별 수하물 운임표
CREATE TABLE `special_charge_table`(
    `id` INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `is_rush` TINYINT(1) UNSIGNED NOT NULL UNIQUE COMMENT 'true :1, false: 0',
    `special_rate` INT(10) UNSIGNED NOT NULL
);

-- 데이터 추가
INSERT INTO `special_charge_table`
SET `is_rush` = 1,
`special_rate` = 1000
;

INSERT INTO `special_charge_table`
SET `is_rush` = 0,
`special_rate` = 0
;

-- 외래키 추가
alter table
    sort_table
add constraint
    foreign key (is_rush)
references
    special_charge_table(is_rush)
;

-- 칠레로 가는 전자제품의 운임(특별운임 포함)
select
    (
    select st.sort
    from sort_table st
    where st.sort = '전자제품'
  ) as '품류'
, c.nation
, ((
    select dc.frieght_charge
    from distance_charge dc
    left join culture c
    on dc.culture_code = c.culture_code
    where c.nation = '칠레'
        and
          c.culture_code = dc.culture_code
    )
       +
    (
        select sct.special_rate
        from special_charge_table sct
        left join sort_table s
        on sct.is_rush = s.is_rush
        where s.sort = '전자제품'
    ))
    as '운임'
from
  culture c
where 
  c.nation = '칠레'
;

