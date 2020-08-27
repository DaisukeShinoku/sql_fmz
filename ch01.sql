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


 BEGIN TRANSACTION;

INSERT INTO Shohin VALUES ('0001', 'Tシャツ' ,'衣服', 1000, 500, '2009-09-20');
INSERT INTO Shohin VALUES ('0002', '穴あけパンチ', '事務用品', 500, 320, '2009-09-11');
INSERT INTO Shohin VALUES ('0003', 'カッターシャツ', '衣服', 4000, 2800, NULL);
INSERT INTO Shohin VALUES ('0004', '包丁', 'キッチン用品', 3000, 2800, '2009-09-20');
INSERT INTO Shohin VALUES ('0005', '圧力鍋', 'キッチン用品', 6800, 5000, '2009-01-15');
INSERT INTO Shohin VALUES ('0006', 'フォーク', 'キッチン用品', 500, NULL, '2009-09-20');
INSERT INTO Shohin VALUES ('0007', 'おろしがね', 'キッチン用品', 880, 790, '2008-04-28');
INSERT INTO Shohin VALUES ('0008', 'ボールペン', '事務用品', 100, NULL, '2009-11-11');

COMMIT;

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



