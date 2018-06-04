class HelpdeskController < ApplicationController
  def helpdeskshow
#connect to the MYSQL server 
begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end
@helpdesk_data =client.query("SELECT * FROM helpdesk")

  end
end
