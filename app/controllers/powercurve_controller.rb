class PowercurveController < ApplicationController
 
begin
# connect to the MySQL server
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
# disconnect from server
end

def powershow


@controllerid =params[:ctrlr_id]

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 ")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time ")


@timearray=[];
@wtvalue11=[];
@wtvalue13=[];
@datearray=[];

@powerwind.each do |tim|
@wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@wtvalue13.push(tim['wtvalue13'])
@timearray.push(tim['updated_time'])
@datearray.push(tim['updated_date'])
end

  end


def search_powercurve

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

@fromdate = params[:fromdate]
@todate =params[:todate]
@controllerid =params[:controllerid]


@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' AND updated_date >= '#{@fromdate}' AND updated_date <='#{@todate}' group by wtvalue11 HAVING countw >= 5 ")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' AND updated_date >= '#{@fromdate}' AND updated_date <='#{@todate}' order by updated_date asc,updated_time ")


@timearray=[];
@wtvalue11=[];
@wtvalue13=[];
@datearray=[];

@powerwind.each do |tim|
@wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@wtvalue13.push(tim['wtvalue13'])
@timearray.push(tim['updated_time'])
@datearr
end
render 'powershow'
end

end
