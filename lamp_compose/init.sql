-- auth_testというデータベースを作成

-- データベース auth_test の中に test テーブルを作成
CREATE TABLE auth_test.test (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(20),
	age INT
);

-- ユーザ sample_user に外部アクセス権を付与
GRANT ALL PRIVILEGES ON auth_test.* TO 'sample_user'@'%';
FLUSH PRIVILEGES;

-- テーブル test にサンプルデータを格納
INSERT INTO auth_test.test (name, age) VALUES
	('abc', '25'),
	('def', '26'),
	('ghi', '27');

