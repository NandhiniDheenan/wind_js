require 'mysql2'
class ChartController < ApplicationController
begin
# connect to the MySQL server
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

rescue Mysql2::Error => e
puts "error"
ensure
# disconnect from server
end

def graph

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

@controllerid =params[:ctrlr_id]

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date, ' , ', periodic_data_tbl.updated_time) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date asc,updated_time")



@wtvalue1=[];
@timearray=[];
@wtvalue11=[];
@wtvalue12=[];
@datearray=[];
#@dd=@towerems.all.map { |u| { updated_date: u.updated_date, vol: u.vol } }
#puts @dd
@windmon.each do |tim|
@wtvalue1.push(tim['wtvalue1'])
@timearray.push(tim['updated_time'])
@wtvalue11.push(tim['wtvalue11'])
@wtvalue12.push(tim['wtvalue12'])
@datearray.push(tim['updated_date'])
#puts tim['vol']
end
#puts @voltagearray
#puts @timearray
#puts @merged_data

  end



def search_graph

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@fromdate = params[:fromdate]
@todate =params[:todate]
@controllerid =params[:controllerid]



#FETCHING DATA FOR GRAPH
@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date, ' , ', periodic_data_tbl.updated_time) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' AND updated_date >= '#{@fromdate}' AND updated_date <='#{@todate}' order by updated_date asc  ")



#VARIABLE FOR GRAPH
@wtvalue1=[];
@timearray=[];
@wtvalue11=[];
@wtvalue12=[];
@datearray=[];

#PUSHING DATA FOR GRAPH
@windmon.each do |tim|
@wtvalue1.push(tim['wtvalue1'])
@timearray.push(tim['updated_time'])
@wtvalue11.push(tim['wtvalue11'])
@wtvalue12.push(tim['wtvalue12'])
@datearray.push(tim['updated_date'])
end

render 'graph'
end
end
