
class RegionmapController < ApplicationController

  def map
begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end

@mapdata = client.query("SELECT * FROM map")

  end
end
