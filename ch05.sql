-- ビューの作成
CREATE VIEW ShohinSum (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui;

-- ビューを使う
SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum;

-- 多段ビュー（非推奨）
CREATE VIEW ShohinSumJim (shohin_bunrui, cnt_shohin)
AS
SELECT shohin_bunrui, cnt_shohin
FROM ShohinSum
WHERE shohin_bunrui = '事務用品';

SELECT shohin_bunrui, cnt_shohin
FROM ShohinSumJim;

-- ビューを更新できるケース
CREATE VIEW ShohinJim (shohin_id, shohin_mei, shohin_bunrui, hanbai_tanka, shiire_tanka, torokubi)
AS
SELECT *
FROM Shohin
WHERE shohin_bunrui = '事務用品';

INSERT INTO ShohinJim VALUES ('0009', '印鑑', '事務用品', 95, 10, '2009-11-30');

-- ビューの削除
DROP VIEW ShohinSum;

-- 多段ビューをまとめて削除
DROP VIEW ShohinSum CASCADE;

-- サブクエリ
SELECT shohin_bunrui, cnt_shohin
FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
      FROM Shohin
      GROUP BY shohin_bunrui) AS ShohinSum;

-- サブクエリの階層をふやす(非推奨)
SELECT shohin_bunrui, cnt_shohin
FROM (SELECT *
      FROM (SELECT shohin_bunrui, COUNT(*) AS cnt_shohin
            FROM Shohin
            GROUP BY shohin_bunrui) AS ShohinSum
      WHERE cnt_shohin = 4) AS ShohinSum2;

-- スカラ・サブクエリ
SELECT shohin_id, shohin_mei, hanbai_tanka
FROM Shohin
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka) FROM Shohin);

-- SELECT句でスカラ・サブクエリ
SELECT shohin_id,shohin_mei, hanbai_tanka,
        (SELECT AVG (hanbai_tanka) FROM Shohin) AS avg_tanka
FROM Shohin;

-- HAVING句でスカラ・サブクエリ
SELECT shohin_bunrui, AVG(hanbai_tanka)
FROM Shohin
GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) > (SELECT AVG(hanbai_tanka) FROM Shohin);

-- 相関サブクエリ
SELECT shohin_bunrui, shohin_mei, hanbai_tanka
FROM Shohin AS S1
WHERE hanbai_tanka > (SELECT AVG(hanbai_tanka)
                      FROM Shohin AS S2
                      WHERE S1.shohin_bunrui = S2.shohin_bunrui
                      GROUP BY shohin_bunrui);