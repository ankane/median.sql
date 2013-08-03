require "test_helper"

class TestPostgresql < Minitest::Test

  def test_empty
    assert_sql nil, "SELECT median(n) FROM generate_series(1, 0) n"
  end

  def test_odd
    assert_sql 3, "SELECT median(n) FROM generate_series(1, 5, 1) n"
  end

  def test_even
    assert_sql 3.5, "SELECT median(n) FROM generate_series(1, 6, 1) n"
  end

  protected

  def conn
    @@conn ||=
      begin
        conn = PG.connect(:dbname => "median_test")
        conn.query File.read("postgresql.sql")
        conn
      end
  end

  def assert_sql(expected, sql)
    assert_equal [[expected]], conn.query(sql).map(&:values)
  end

end
