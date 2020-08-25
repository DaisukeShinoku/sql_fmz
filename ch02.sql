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