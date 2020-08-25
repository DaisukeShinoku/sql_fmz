-- データベースの作成

CREATE DATABASE Shop;

-- Shohinテーブルを作成
  -- CHARは固定長文字列、足りない文字数を空白で埋める
  -- VARCHARは可変長文字列、文字数そのまま
  -- NOT NULLで空白を禁止
  -- PRIMARY KEY(XXXX)で主キーとして設定

CREATE TABLE Shohin
(shohin_id     CHAR(4)      NOT NULL,
 shohin_mei    VARCHAR(100) NOT NULL,
 shohin_bunrui VARCHAR(32)  NOT NULL,
 hanbai_tanka  INTEGER ,
 shiire_tanka  INTEGER ,
 torokubi      DATE ,
 PRIMARY KEY (shohin_id));

-- Shohinテーブルを削除
DROP TABLE Shohin;

-- ShoinテーブルをShohinテーブルに名前変更
ALTER TABLE Shoin RENAME TO Shohin;

-- ShohinテーブルにShohin_mei_kana列を追加
ALTER TABLE Shohin ADD COLUMN Shohin_mei_kana VARCHAR(100);

-- ShohinテーブルにShohin_mei_kana列を削除
ALTER TABLE Shohin DROP COLUMN Shohin_mei_kana;

-- SELECT文の基本

SELECT shohin_id, shohin_mei, shiire_tanka
FROM Shohin;

-- *で全ての列を表示

SELECT *
FROM Shohin;



