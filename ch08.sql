-- RANK関数を利用してレコードのランキングをつける、商品分類ごとに単価でランク付

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
RANK () OVER (PARTITION BY shohin_bunrui
ORDER BY hanbai_tanka) AS ranking
FROM shohin;

-- PARTITION BY を指定しないと全範囲で比較される

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
RANK () OVER (ORDER BY hanbai_tanka) AS ranking
FROM shohin;

-- RANK DENSE_RANK ROW_NUMBER を比較する

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
RANK () OVER (ORDER BY hanbai_tanka) AS ranking,
DENSE_RANK () OVER (ORDER BY hanbai_tanka) AS dense_ranking,
ROW_NUMBER () OVER (ORDER BY hanbai_tanka) AS row_num
FROM Shohin;

-- SUM関数をウィンドウ関数で使う

SELECT shohin_id, shohin_mei, hanbai_tanka,
SUM (hanbai_tanka) OVER (ORDER BY shohin_id) AS current_sum
FROM Shohin;

-- AVG関数をウィンドウ関数として使う

SELECT shohin_id, shohin_mei, hanbai_tanka,
AVG(hanbai_tanka) OVER (ORDER BY shohin_id) AS current_avg
FROM Shohin;

-- 移動平均を算出する

SELECT shohin_id, shohin_mei, hanbai_tanka,
AVG(hanbai_tanka) OVER (ORDER BY shohin_id
                        ROWS 2 PRECEDING) AS moving_avg
FROM Shohin;

-- カレントレコードの前後の行を集計対象に含める

SELECT shohin_id, shohin_mei, hanbai_tanka,
AVG (hanbai_tanka) OVER (ORDER BY shohin_id
                        ROWS BETWEEN 1 PRECEDING AND
                        1 FOLLOWING) AS moving_avg
FROM Shohin;

-- 以下のSELECT文で結果の並び順は保証されない(PostgreSQLでは順番通りにはなる)

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
RANK () OVER (ORDER BY hanbai_tanka) AS ranking
FROM Shohin;


-- 文末の ORDER BY によって結果の並び順が保証される 

SELECT shohin_mei, shohin_bunrui, hanbai_tanka,
RANK () OVER (ORDER BY hanbai_tanka) AS ranking
FROM Shohin
ORDER BY ranking;

-- 合計行と集約結果を個別に求めUNION ALLでくっつける

SELECT '合計' AS shohin_bunrui, SUM(hanbai_tanka)
FROM Shohin
UNION ALL
SELECT shohin_bunrui, SUM(hanbai_tanka)
FROM Shohin
GROUP BY shohin_bunrui;

-- 上と同じ結果を、ROLLUP で合計行と小計を一度に求める

SELECT shohin_bunrui, SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY ROLLUP (shohin_bunrui);

-- GROUP BY で「登録日」を追加(ROLLUPなし)

SELECT shohin_bunrui, torokubi, SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY shohin_bunrui, torokubi;

-- GROUP BY で「登録日」を追加(ROLLUPあり)

SELECT shohin_bunrui, torokubi, SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY ROLLUP(shohin_bunrui, torokubi);

-- GROUPING関数でNULLを判明する

SELECT GROUPING(shohin_bunrui) AS shohin_bunrui,
        GROUPING(torokubi) AS torokubi, SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY ROLLUP(shohin_bunrui, torokubi);

-- 超集合行キー値に適当な文字列を埋め込む

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1
              THEN '商品分類 合計'
              ELSE shohin_bunrui END AS shohin_bunrui,
              CASE WHEN GROUPING(torokubi) = 1
              THEN '登録日 合計'
              ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY ROLLUP(shohin_bunrui, torokubi);

-- CUBE で可能な全ての組み合わせを取得する

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1
        THEN '商品分類 合計'
        ELSE shohin_bunrui END AS shohin_bunrui,
        CASE WHEN GROUPING(torokubi) = 1
        THEN '登録日 合計'
        ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
        SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY CUBE(shohin_bunrui, torokubi);

-- GROUPING SETS で部分的な組み合わせを取得する

SELECT CASE WHEN GROUPING(shohin_bunrui) = 1
            THEN '商品分類 合計'
            ELSE shohin_bunrui END AS shohin_bunrui,
            CASE WHEN GROUPING(torokubi) = 1
            THEN '登録日 合計'
            ELSE CAST(torokubi AS VARCHAR(16)) END AS torokubi,
            SUM(hanbai_tanka) AS sum_tanka
FROM Shohin
GROUP BY GROUPING SETS (shohin_bunrui, torokubi);