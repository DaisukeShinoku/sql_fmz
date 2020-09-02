-- SampleMathテーブルを作成する

CREATE TABLE SampleMath
(m NUMERIC (10,3),
n INTEGER,
p INTEGER);

BEGIN TRANSACTION;

INSERT INTO SampleMath(m, n, p) VALUES (500, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (-180, 0, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, NULL, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 7, 3);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 5, 2);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 4, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8, NULL, 3);
INSERT INTO SampleMath(m, n, p) VALUES (2.27, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (5.555, 2, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (NULL, 1, NULL);
INSERT INTO SampleMath(m, n, p) VALUES (8.76, NULL, NULL);

COMMIT;


-- ABS関数(絶対値を求める)

SELECT m,
ABS(m) AS abs_col
FROM SampleMath;

-- MOD関数（余剰を求める N÷Pの値）

SELECT n, p,
MOD(n, p) AS mod_col
FROM SampleMath;


-- ROUND関数（四捨五入）m:対象数 n:丸め桁数

SELECT m, n,
ROUND(m, n) AS round_col
FROM SampleMath;

-- SampleStrテーブルを作成する

CREATE TABLE SampleStr
(str1 VARCHAR(40),
str2 VARCHAR(40),
str3 VARCHAR(40));

BEGIN TRANSACTION;

INSERT INTO SampleStr (str1, str2, str3) VALUES ('あいう', 'えお', NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc', 'def', NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('山田', '太郎', 'です');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aaa', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES (NULL, 'あああ', NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('@!#$%', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ABC', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('aBC', NULL, NULL);
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abc太郎', 'abc', 'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('abcdeffabc', 'abc', 'ABC');
INSERT INTO SampleStr (str1, str2, str3) VALUES ('ミックマック', 'ッ', 'っ');

COMMIT;

-- || 連結

SELECT str1, str2, str1 || str2 AS str_concat
FROM SampleStr;

-- 3つの文字列をつなげる

SELECT str1, str2, str3, str1 || str2 || str3 AS str_concat
FROM SampleStr
WHERE str1 = '山田';

-- LENGTH 文字列長

SELECT str1, LENGTH(str1) AS len_str
FROM SampleStr;

-- LOWER 小文字化 (UPPER 大文字化)

SELECT str1, LOWER(str1) AS low_str
FROM SampleStr
WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');

-- REPLACE 文字列の置換 str1:対象 str2:置換前 str3:置換後 rep_str:結果 

SELECT str1, str2, str3, REPLACE(str1, str2, str3) AS rep_str
FROM SampleStr;

-- SUBSTRING 文字列の切り出し

SELECT str1, SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
FROM SampleStr;

-- UPPER 文字列化

SELECT str1, 
UPPER (str1) AS up_str
FROM SampleStr
WHERE str1 IN ('ABC', 'aBC', 'abc', '山田');

-- CURRENT_DATE 現在の日付

SELECT CURRENT_DATE;

-- CURRENT_TIME 現在の時間

SELECT CURRENT_TIME;

-- CURRENT_TIMESTAMP 現在の日時

SELECT CURRENT_TIMESTAMP;

-- EXTRACT 日付要素の取り出す

SELECT CURRENT_TIMESTAMP,
EXTRACT(YEAR FROM CURRENT_TIMESTAMP) AS year,
EXTRACT(MONTH FROM CURRENT_TIMESTAMP) AS month,
EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day,
EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS hour,
EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS minute,
EXTRACT(SECOND FROM CURRENT_TIMESTAMP) AS second;

-- CAST 型変換
SELECT CAST('0001' AS INTEGER) AS int_col;

-- 日付型の変換
SELECT CAST('2009-12-14' AS DATE) AS date_col;

-- COALESCE NULLを値へ変換
SELECT COALESCE(NULL, 1) AS col_1,
COALESCE(NULL, 'test', NULL) AS col_2,
COALESCE(NULL, NULL, '2009-11-01') AS col_3;

SELECT COALESCE(str2, 'NULLです')
FROM SampleStr;

-- SampleLikeテーブルを作成する
CREATE TABLE SampleLike
( strcol VARCHAR(6) NOT NULL,
PRIMARY KEY (strcol));

BEGIN TRANSACTION;

INSERT INTO SampleLike (strcol) VALUES ('abcddd');
INSERT INTO SampleLike (strcol) VALUES ('dddabc');
INSERT INTO SampleLike (strcol) VALUES ('abdddc');
INSERT INTO SampleLike (strcol) VALUES ('abcdd');
INSERT INTO SampleLike (strcol) VALUES ('ddabc');
INSERT INTO SampleLike (strcol) VALUES ('abddc');

COMMIT;

-- 前方一致

SELECT *
FROM SampleLike
WHERE strcol LIKE 'ddd%';

-- 中間一致

SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd%';

-- 後方一致

SELECT *
FROM SampleLike
WHERE strcol LIKE '%ddd';

-- アンスコで任意の１文字を表す

SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc__';

SELECT *
FROM SampleLike
WHERE strcol LIKE 'abc___';

-- BETWEEN で範囲検索

SELECT shohin_mei, hanbai_tanka
FROM Shohin
WHERE hanbai_tanka BETWEEN 100 AND 1000;

-- 100と1000を含みたくないなら<,>使う

SELECT shohin_mei, hanbai_tanka
FROM Shohin
WHERE hanbai_tanka > 100
AND hanbai_tanka < 1000;

-- NULLかどうかの判定（＝は使えない）

SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka IS NULL;

SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka IS NOT NULL;

-- ORを使う時、INでも同じことができる

SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka = 320
OR shiire_tanka = 500
OR shiire_tanka = 5000;

SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka IN (320, 500, 5000);

-- 店舗商品テーブルを作成

CREATE TABLE TenpoShohin
(tenpo_id  CHAR(4)       NOT NULL,
 tenpo_mei  VARCHAR(200) NOT NULL,
 shohin_id CHAR(4)       NOT NULL,
 suryo     INTEGER       NOT NULL,
 PRIMARY KEY (tenpo_id, shohin_id));

BEGIN TRANSACTION;

INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'東京',		'0001',	30);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'東京',		'0002',	50);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000A',	'東京',		'0003',	15);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0002',	30);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0003',	120);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0004',	20);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0006',	10);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000B',	'名古屋',	'0007',	40);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0003',	20);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0004',	50);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0006',	90);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000C',	'大阪',		'0007',	70);
INSERT INTO TenpoShohin (tenpo_id, tenpo_mei, shohin_id, suryo) VALUES ('000D',	'福岡',		'0001',	100);

COMMIT;

-- IN の述語にサブクエリを指定する

SELECT shohin_mei, hanbai_tanka
FROM Shohin
WHERE shohin_id IN (
  SELECT shohin_id
  FROM TenpoShohin
  WHERE tenpo_id = '000C'
);

-- NOT IN とサブクエリ

SELECT shohin_mei, hanbai_tanka
FROM Shohin
WHERE shohin_id NOT IN (SELECT shohin_id
                        FROM TenpoShohin
                        WHERE tenpo_id = '000A');


-- EXISTS の使い方

SELECT shohin_mei, hanbai_tanka
FROM Shohin AS S
WHERE EXISTS (SELECT *
              FROM TenpoShohin AS TS
              WHERE TS.tenpo_id = '000C'
              AND TS.shohin_id = S.shohin_id);

-- NOT EXISTS の使い方

SELECT shohin_mei, hanbai_tanka
FROM Shohin AS S
WHERE NOT EXISTS (SELECT *
                  FROM TenpoShohin AS TS
                  WHERE TS.tenpo_id = '000A'
                  AND TS.shohin_id = S.shohin_id);

-- CASE 式の使い方

SELECT shohin_mei,
CASE WHEN shohin_bunrui = '衣服'
    THEN 'A:' || shohin_bunrui
  WHEN shohin_bunrui = '事務用品'
    THEN 'B:' || shohin_bunrui
  WHEN shohin_bunrui = 'キッチン用品'
    THEN 'C:' || shohin_bunrui
  ELSE NULL
END AS abc_shohin_bunrui
FROM Shohin;


SELECT SUM(CASE WHEN shohin_bunrui = '衣服'
            THEN hanbai_tanka ELSE 0 END) AS sum_tanka_ihuku,
        SUM(CASE WHEN shohin_bunrui = 'キッチン用品'
            THEN hanbai_tanka ELSE 0 END) AS sum_tanka_kitchen,
        SUM(CASE WHEN shohin_bunrui = '事務用品'
            THEN hanbai_tanka ELSE 0 END) AS sum_tanka_jimu
FROM Shohin;