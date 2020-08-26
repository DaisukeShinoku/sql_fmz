-- COUNTの基本
SELECT COUNT(*)
FROM Shohin;

-- NULLを除外して数える
SELECT COUNT(shiire_tanka)
FROM Shohin;

-- SUMの基本
SELECT SUM(hanbai_tanka)
FROM Shohin;

-- AVGの基本
SELECT AVG(hanbai_tanka)
FROM Shohin;

-- MAX MINの基本
SELECT MAX(hanbai_tanka), MIN(shiire_tanka)
FROM Shohin;

-- 日付にも使えるよ
SELECT MAX(torokubi), MIN(torokubi)
FROM Shohin;

-- 重複値を除いた集約関数
SELECT COUNT(DISTINCT shohin_bunrui)
FROM Shohin;

-- GROUP BYの基本
SELECT shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui;

--GROUP BYでNULLがあるとそれも数えられえる
SELECT shiire_tanka, COUNT(*)
FROM Shohin
GROUP BY shiire_tanka;

-- WHEREとGROUP BYを併用
SELECT shiire_tanka, COUNT(*)
FROM Shohin
WHERE shohin_bunrui = '衣服'
GROUP BY shiire_tanka;

-- HAVINGの基本
SELECT shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui
HAVING COUNT(*) = 2;

SELECT shohin_bunrui, AVG(hanbai_tanka)
FROM Shohin
GROUP BY shohin_bunrui
HAVING AVG(hanbai_tanka) >= 2500;

-- ORDER BYの基本
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
ORDER BY hanbai_tanka;

--降順にする
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
ORDER BY hanbai_tanka DESC;

--複数のソートキー
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
ORDER BY hanbai_tanka, shohin_id;

--NULLを含む場合
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
ORDER BY shiire_tanka;

--別名でソート
SELECT shohin_id AS id, shohin_mei, hanbai_tanka AS ht, shiire_tanka
FROM Shohin
ORDER BY ht, id;

--SELECT外でソート
SELECT shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
ORDER BY shohin_id;

--集約関数でソート
SELECT shohin_bunrui, COUNT(*)
FROM Shohin
GROUP BY shohin_bunrui
ORDER BY COUNT(*);

-- 列番号を使う（非推奨）
SELECT shohin_id, shohin_mei, hanbai_tanka, shiire_tanka
FROM Shohin
ORDER BY 3 DESC, 1;