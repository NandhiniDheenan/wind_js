require 'date'

class ReportController < ApplicationController

def showreport

begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end

@controllerid =params[:ctrlr_id]

#FETCHING DATA FOR DATATABLE
@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

#FETCHING DATA FOR GRAPH
@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")

#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")

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


#VARIABLE FOR POWERCURVE
@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end
end


def oneday
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]

@d = Date.today
@d.to_s
@w= (@d+6).to_s
@m=@d + 1.month
@sixmonth = @d + 6.month
@y=@d+1.year

@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,periodic_data_tbl.updated_date AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where updated_date = '#{@d}'   order by updated_date asc,updated_time")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end


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


render 'showreport'


end


def oneweek
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s
@w= (@d-6).to_s

@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time, periodic_data_tbl.updated_date AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@w}'  order by updated_date asc,updated_time")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end


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


render 'showreport'


end

def onemonth
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s
@m=@d - 1.month


@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,periodic_data_tbl.updated_date AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@m}'  order by updated_date asc,updated_time")

#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end

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

render 'showreport'

end

def sixmonths
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s
@sixmonth = @d - 6.month


@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@sixmonth}'  order by updated_date asc,updated_time")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end

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
#puts tim['vol']
end


render 'showreport'
end

def oneyear
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s

@y=@d-1.year

@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@y}'  order by updated_date asc,updated_time")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end


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


render 'showreport'


end


def searchrep

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@fromdate = params[:fromdate]
@todate =params[:todate]
@controllerid =params[:controllerid]


@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' AND updated_date >= '#{@fromdate}' AND updated_date <='#{@todate}' order by updated_date asc")


#FETCHING DATA FOR GRAPH
@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")

#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  ctrlrid = '#{@controllerid}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where ctrlrid = '#{@controllerid}' order by updated_date desc,updated_time limit 100")

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


#VARIABLE FOR POWERCURVE
@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end

#puts @ctrlrid
#puts @fromdate
#puts @todate

render 'showreport'
end



def pc_oneday

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]

@d = Date.today
@d.to_s
@w= (@d+6).to_s
@m=@d + 1.month
@sixmonth = @d + 6.month
@y=@d+1.year

@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where updated_date = '#{@d}' group by wtvalue11 HAVING countw >= 5 ")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where updated_date = '#{@d}' order by updated_date asc,updated_time ")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end


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


render 'showreport'


end


def pc_oneweek
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s
@w= (@d-6).to_s

@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  updated_date <= '#{@d}' AND updated_date >='#{@w}' group by wtvalue11 HAVING countw >= 5 ")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@w}' order by updated_date desc,updated_time ")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end


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

render 'showreport'

end

def pc_onemonth

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")

@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s
@m=@d - 1.month


@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")

#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  updated_date <= '#{@d}' AND updated_date >='#{@m}' group by wtvalue11 HAVING countw >= 5 limit 100")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@m}' order by updated_date asc,updated_time ")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end

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

render 'showreport'

end


def pc_sixmonths
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s
@sixmonth = @d - 6.month


@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")

#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where  updated_date <= '#{@d}' AND updated_date >='#{@sixmonth}' group by wtvalue11 HAVING countw >= 5")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@sixmonth}' order by updated_date asc,updated_time ")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end

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


render 'showreport'
end

def pc_oneyear
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
@controllerid =params[:ctrlr_id]
@d = Date.today
@d.to_s

@y=@d-1.year

@periodic_data_tbl =client.query("SELECT  * FROM periodic_data_tbl where ctrlrid='#{@controllerid}' order by updated_date asc")

@windmon = client.query("select DATE_FORMAT(updated_time, '%H:%i,:%s') as updated_time,CONCAT(periodic_data_tbl.updated_date) AS updated_date,wtvalue1,wtvalue11,wtvalue12 from periodic_data_tbl where  ctrlrid = '#{@controllerid}' order by updated_date desc limit 100  ")


#FETCHING DATA FOR POWERCURVE
@powerwind =client.query("select wtvalue11,  count(*) as countw, sum(wtvalue11) as sumw ,Round(avg(wtvalue11),2) as avgw  from periodic_data_tbl  where updated_date <= '#{@d}' AND updated_date >='#{@y}'  group by wtvalue11 HAVING countw >= 5 ")  

@powerkw=client.query("select DATE_FORMAT(updated_time,'%H:%i:%s') as updated_time,DATE_FORMAT(updated_date, '%Y-%m-%d') as updated_date,wtvalue13 from periodic_data_tbl where updated_date <= '#{@d}' AND updated_date >='#{@y}'  order by updated_date asc,updated_time ")


@pc_timearray=[];
@pc_wtvalue11=[];
@pc_wtvalue13=[];
@pc_datearray=[];

@powerwind.each do |tim|
@pc_wtvalue11.push(tim['avgw'])
end

@powerkw.each do |tim|
@pc_wtvalue13.push(tim['wtvalue13'])
@pc_timearray.push(tim['updated_time'])
@pc_datearray.push(tim['updated_date'])
end


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


render 'showreport'


end

end
