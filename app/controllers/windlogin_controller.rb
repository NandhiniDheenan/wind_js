class WindloginController < ApplicationController
layout false
protect_from_forgery with: :null_session

def log
render 'login.html.erb'
end

def login

begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end

@username = params[:username]
@password =params[:password]

@dbuser = client.query("SELECT * FROM userlogin WHERE userlogin.username = '#{@username}' AND userlogin.userpassword = '#{@password}'")

if @dbuser.count==0 
@cus_user =client.query("SELECT * FROM Customer_Details where Customer_Email = '#{@username}' AND cus_password = '#{@password}'")

@controller_id=client.query("select controller_id from installationsetup where cus_mailid = '#{@username}'")

if @cus_user.count==0
puts 'try again'
redirect_to '/login'
else

redirect_to "/cusdashboard?cus_mailid=#{@username}"
end
else
redirect_to '/newdashboard'
end

  end

end
