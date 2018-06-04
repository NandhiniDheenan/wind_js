class DataviewController < ApplicationController
  def datatable

begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end


 @fromdate = params[:fromdate]
 @todate =params[:todate]
#@controllerid =params[:controllerid]
@controllerid =params[:ctrlr_id]
if @fromdate==nil
@fd = Time.now.strftime(" %Y/%m/%d")
 @fromdate = @fd['updated_date']
#@fromdate=Date.parse(fd['updated_date'])..f
end
if @todate==nil
@ld = Time.now.strftime(" %Y/%m/%d")
  @todate = @ld['updated_date']
#@fromdate=Date.parse(fd['updated_date'])..f
end
@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' ")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time, updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc,updated_time")


@wtvalue1=[];
@timearray=[];
@wtvalue11=[];
@wtvalue12=[];
@datearray=[];

@windmon.each do |tim|
@wtvalue1.push(tim['wtvalue1'])
@timearray.push(tim['updated_time'])
@wtvalue11.push(tim['wtvalue11'])
@wtvalue12.push(tim['wtvalue12'])
@datearray.push(tim['updated_date'])
end


  end





end
