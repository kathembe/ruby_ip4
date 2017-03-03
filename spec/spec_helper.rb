require("rspec")
  require("pg")
  require("brand")
  require("store")

  DB = PG.connect({:dbname => "shoes_test"})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM brands *;")
      DB.exec("DELETE FROM stores *;")
    end
  end
