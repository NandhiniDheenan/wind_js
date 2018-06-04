class ProfileController < ApplicationController
  def showprofile
#connect to the MYSQL server 
begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end
@profile_data =client.query("SELECT * FROM profile_details")

  end
end
