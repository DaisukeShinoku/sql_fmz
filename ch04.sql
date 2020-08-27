-- テーブル作成
CREATE TABLE ShohinIns
(shohin_id CHAR(4) NOT NULL,
shohin_mei VARCHAR(100) NOT NULL,
shohin_bunrui VARCHAR(32) NOT NULL,
hanbai_tanka INTEGER DEFAULT 0,
shiire_tanka INTEGER,
torokubi DATE,
PRIMARY KEY(shohin_id));

-- １行登録
INSERT INTO ShohinIns (shohin_id,shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
VALUES ('0001', 'Tシャツ', '衣服', 1000, 500, '2009-09-20');

--NULLの挿入
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
VALUES('0006','フォーク','キッチン用品', 500, NULL, '2009-09-20');

--明示的なDEFALUT挿入
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
VALUES('0007', 'おろしがね', 'キッチン用品', DEFAULT, 790, '2009-04-28');

--暗黙的なDEFALUT挿入
INSERT INTO ShohinIns (shohin_id, shohin_mei, shohin_bunrui, shiire_tanka, torokubi)
VALUES('0007', 'おろしがね', 'キッチン用品', 790, '2009-04-28');

-- 他のテーブルからデータをコピーする
CREATE TABLE ShohinCopy
(shohin_id CHAR(4) NOT NULL,
shohin_mei VARCHAR(100) NOT NULl,
shohin_bunrui VARCHAR(32) NOT NULL,
hanbai_tanka INTEGER,
shiire_tanka INTEGER,
torokubi DATE,
PRIMARY KEY(shohin_id));

INSERT INTO ShohinCopy (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
SELECT shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi
FROM Shohin;

-- 他のテーブルからGROUP BYを使ってデータをコピーする
CREATE TABLE ShohinBunrui
(shohin_bunrui VARCHAR(32) NOT NULL,
sum_hanbai_tanka INTEGER,
sum_shiire_tanka INTEGER,
torokubi DATE,
PRIMARY KEY(shohin_bunrui));

INSERT INTO ShohinBunrui (shohin_bunrui, sum_hanbai_tanka, sum_shiire_tanka)
SELECT shohin_bunrui, SUM(hanbai_tanka), SUM(shiire_tanka)
FROM Shohin
GROUP BY shohin_bunrui;

-- DELETEの使い方
DELETE FROM Shohin
WHERE hanbai_tanka >= 4000;

-- UPDATEの使い方
UPDATE Shohin
SET torokubi = '2009-10-10';

UPDATE Shohin
SET hanbai_tanka = hanbai_tanka * 10
WHERE shohin_bunrui = 'キッチン用品';

-- NULLクリア
UPDATE Shohin
SET torokubi = NULL
WHERE shohin_id = '0008';

--複数列の更新
UPDATE Shohin
SET hanbai_tanka = hanbai_tanka * 10,
shiire_tanka = shiire_tanka /2
WHERE shohin_bunrui = 'キッチン用品';

--上と同じ処理(使えないDBMSもある)
UPDATE Shohin
SET (hanbai_tanka, shiire_tanka) = (hanbai_tanka * 10, shiire_tanka /2 )
WHERE shohin_bunrui = 'キッチン用品';

-- トランザクションの使い方
BEGIN TRANSACTION;

UPDATE Shohin
SET hanbai_tanka = hanbai_tanka - 1000
WHERE shohin_mei = 'カッターシャツ';

UPDATE Shohin
SET hanbai_tanka = hanbai_tanka + 1000
WHERE shohin_mei = 'Tシャツ';

COMMIT;
