-- 新しいテーブルを用意する

CREATE TABLE Shohin2
(shohin_id     CHAR(4)      NOT NULL,
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32)  NOT NULL,
 hanbai_tanka  INTEGER      ,
 shiire_tanka  INTEGER      ,
 torokubi      DATE         ,
 PRIMARY KEY (shohin_id));

BEGIN TRANSACTION;

INSERT INTO Shohin2 VALUES ('0001', 'Tシャツ' ,'衣服', 1000, 500, '2009-09-20');
INSERT INTO Shohin2 VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO Shohin2 VALUES ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL);
INSERT INTO Shohin2 VALUES ('0009', '手袋', '衣服', 800, 500, NULL);
INSERT INTO Shohin2 VALUES ('0010', 'やかん', 'キッチン用品', 2000, 1700, '2009-09-20');

COMMIT;

-- UNION テーブルの足し算(重複行は削除される)

SELECT shohin_id, shohin_mei
FROM Shohin
UNION
SELECT shohin_id, shohin_mei
FROM Shohin2;

-- ALL 重複行を残す集合演算

SELECT shohin_id, shohin_mei
FROM Shohin
UNION ALL
SELECT shohin_id, shohin_mei
FROM Shohin2;


-- INTERSECT テーブルの共通部分の選択

SELECT shohin_id, shohin_mei
FROM Shohin
INTERSECT
SELECT shohin_id, shohin_mei
FROM Shohin2
ORDER BY shohin_id;

-- EXCEPT レコードの引き算(引き算の順番によって答えが変わる)

SELECT shohin_id, shohin_mei
FROM Shohin
EXCEPT
SELECT shohin_id, shohin_mei
FROM Shohin2
ORDER BY shohin_id;


SELECT shohin_id, shohin_mei
FROM Shohin2
EXCEPT
SELECT shohin_id, shohin_mei
FROM Shohin
ORDER BY shohin_id;

-- INNER JOIN 内部結合

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS INNER JOIN Shohin AS S
ON TS.shohin_id = S.shohin_id;

-- INNER JOIN と WHERE の組み合わせ

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS INNER JOIN Shohin AS S
ON TS.shohin_id = S.shohin_id
WHERE TS.tenpo_id = '000A';

-- OUTER JOIN 外部結合(どちらか一方にある情報なら表示される、不明箇所はNULLとして処理)

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM TenpoShohin AS TS RIGHT OUTER JOIN Shohin AS S
ON TS.shohin_id = S.shohin_id;

-- 上と同じ意味（LEFTとRIGHTの使い分け）

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka
FROM Shohin AS S LEFT OUTER JOIN TenpoShohin AS TS
ON TS.shohin_id = S.shohin_id;

-- 在庫商品テーブルを作成

CREATE TABLE ZaikoShohin
( souko_id  CHAR(4)      NOT NULL,
  shohin_id     CHAR(4)      NOT NULL,
  zaiko_suryo  INTEGER      NOT NULL,
  PRIMARY KEY (souko_id, shohin_id));

BEGIN TRANSACTION;

INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0001',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0002',	120);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0003',	200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0004',	3);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0005',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0006',	99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0007',	999);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S001',	'0008',	200);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0001',	10);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0002',	25);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0003',	34);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0004',	19);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0005',	99);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0006',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0007',	0);
INSERT INTO ZaikoShohin (souko_id, shohin_id, zaiko_suryo) VALUES ('S002',	'0008',	18);

COMMIT;

-- 3つ以上のテーブルを内部結合する

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, S.shohin_mei, S.hanbai_tanka, ZS.zaiko_suryo
FROM TenpoShohin AS TS INNER JOIN Shohin AS S
ON TS.shohin_id = S.shohin_id
      INNER JOIN ZaikoShohin AS ZS
      ON TS.shohin_id = ZS.shohin_id
WHERE ZS.souko_id = 'S001';

-- CROSS JOIN クロス結合 実務ではあまり使わないが、結合演算の基本となる

SELECT TS.tenpo_id, TS.tenpo_mei, TS.shohin_id, TS.shohin_id, S.shohin_mei
FROM TenpoShohin AS TS CROSS JOIN Shohin AS S;
