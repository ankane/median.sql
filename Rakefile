require "rake/testtask"

task :default => :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

task :benchmark do
  require "pg"
  require "benchmark/ips"

  Benchmark.ips do |x|
    conn = PG.connect(:dbname => "median_test")
    conn.query File.read("postgresql.sql")

    x.report("median") { conn.query("SELECT median(n) FROM generate_series(1, 10000, 1) n") }
  end
end
