# pgライブラリを使用する
require 'pg'
# PG::connect(dbname: "goya")により、rubyからgoyaDBに接続し
# 接続したという情報をconnectionという名前の変数に格納する
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  result = connection.exec("SELECT weight, give_for FROM crops;")
  # 取り出した各行を処理する
  result.each do |record|
      # 各行を取り出し、putsでターミナル上に出力する
      puts "ゴーヤの重さ：#{record["weight"]}　売った相手：#{record["give_for"]}"
  end

  result1 = connection.exec("SELECT * FROM crops WHERE give_for != '自家消費';")
  result1.each do |record1|
      puts "ゴーヤの長さ：#{record1["length"]}　ゴーヤの重さ：#{record1["weight"]} 品質：#{record1["quality"]}  売った相手：#{record1["give_for"] } 日付：#{record1["date"] }"
  end

  result2 = connection.exec("SELECT * FROM crops WHERE quality = false;")
  result2.each do |record2|
      puts "ゴーヤの長さ：#{record2["length"]}　ゴーヤの重さ：#{record2["weight"]}　品質：#{record2["quality"]}　売った相手：#{record2["give_for"] } 日付：#{record2["date"] }"
  end
ensure
  # 最後に.finishでデータベースへのコネクションを切断する
  connection.finish
end
