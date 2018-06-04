class CusdashboardController < ApplicationController
def cusdashboardview

begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end

@cus_mailid=params[:cus_mailid]

#@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}'AND updated_date >= '#{@fromdate}' AND updated_date <='#{@todate}' order by updated_date asc")
#if (@periodic_data_tbl.count == 0)

@installation_id=client.query("select controller_id from installationsetup where cus_mailid = '#{@cus_mailid}'")

@ctrlrid=[];
@installation_id.each do |tim, t|
@ctrlrid.push(tim['controller_id'])
end

@periodic_data_tbl = client.query("SELECT  * FROM report_data_tbl where request_type='periodic' and ctrlrid IN (#{@ctrlrid.join(', ')})")
render layout: 'customerlayout.html.erb'
end

def cusdashboard
#end
end

end
