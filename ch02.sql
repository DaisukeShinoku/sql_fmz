-- SELECT文の基本

SELECT shohin_id, shohin_mei, shiire_tanka
FROM Shohin;

-- *で全ての列を表示

SELECT *
FROM Shohin;


-- 別名をつけて出力
SELECT shohin_id AS "商品ID",
      shohin_mei AS "商品名",
      shiire_tanka AS "仕入単価"
FROM Shohin;

-- 定数の出力
SELECT '商品' AS mojiretsu, 38 AS kazu, '2009-02-24' AS hizuke,
shohin_id, shohin_mei
FROM Shohin;

-- 重複を省く(DISTINCT)
SELECT DISTINCT shohin_bunrui
FROM Shohin;

SELECT DISTINCT shiire_tanka
FROM Shohin;

-- 複数の列でDISTINCTを適用する
SELECT DISTINCT shohin_bunrui, torokubi
FROM Shohin;

-- WHEREで行を選択する
SELECT shohin_mei, shohin_bunrui
FROM Shohin
WHERE shohin_bunrui = '衣服';


-- コメントを１行で書くときの記号

/*
コメントを
複数行に渡って
書くときの記号
*/

-- 計算式を書ける
SELECT shohin_mei, hanbai_tanka,
hanbai_tanka * 2 AS "hanbai_tanka x2"
FROM Shohin;

-- 販売単価が500円
SELECT shohin_mei, shohin_bunrui
FROM Shohin
WHERE hanbai_tanka = 500;

-- 販売単価が500円以外
SELECT shohin_mei, shohin_bunrui
FROM Shohin
WHERE hanbai_tanka <> 500;

-- 販売単価が1000円以上
SELECT shohin_mei, shohin_bunrui, hanbai_tanka
FROM Shohin
WHERE hanbai_tanka >= 1000;

-- 登録日が2009年9月27日以前
SELECT shohin_mei, shohin_bunrui, torokubi
FROM Shohin
WHERE torokubi < '2009-09-27';

-- 販売単価が仕入単価より500円以上高い
SELECT shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
WHERE hanbai_tanka - shiire_tanka >= 500;

-- 文字列で不等号を使う(辞書式順序で判断される)
SELECT chr
FROM Chars
WHERE chr > '2';

-- NULLに比較演算子は使えない
SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka = 2800;

SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka <> 2800;

-- NULLを選択、NULL以外を選択
SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka IS NULL;

SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shiire_tanka IS NOT NULL;

-- NOTの使い方
SELECT shohin_mei, shohin_bunrui, hanbai_tanka
FROM Shohin
WHERE NOT hanbai_tanka >= 1000;

-- ANDの使い方
SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shohin_bunrui = 'キッチン用品'
AND hanbai_tanka >= 3000;

-- ORの使い方
SELECT shohin_mei, shiire_tanka
FROM Shohin
WHERE shohin_bunrui = 'キッチン用品'
OR hanbai_tanka >= 3000;

-- ()の使い方、()がないとANDが優先されてしまう
SELECT shohin_mei, shohin_bunrui, torokubi
FROM Shohin
WHERE shohin_bunrui = '事務用品'
AND
      torokubi = '2009-09-11'
      OR torokubi = '2009-09-20'
;



SELECT shohin_mei, shohin_bunrui, torokubi
FROM Shohin
WHERE shohin_bunrui = '事務用品'
AND (
      torokubi = '2009-09-11'
      OR torokubi = '2009-09-20'
);
