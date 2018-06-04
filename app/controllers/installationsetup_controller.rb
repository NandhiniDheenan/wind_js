class InstallationsetupController < ApplicationController
 

def install
render 'customerinstallation.html.erb'
end


def customerinstallation
begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end
@ctrlid=params[:ctrlrid]
@sim_card_no=params[:simno]
@product_mdl_name=params[:prodictmdl]
@mobile_no=params[:mobno]
@product_unit_serial_no=params[:productunit]
@date_of_commissioning=params[:date]
@panel_no=params[:panelno]
@installed_location=params[:installedlocation]
@alternator_make=params[:alternatormake]
@installed_addrs=params[:installedaddr]
@alternator_no=params[:alternatorno]
@customer_name=params[:cusname]
@cus_mailid =params[:cus_mailid]
@engine_no=params[:Engineno]
@technician_name=params[:techname]
@site_manager_name=params[:managername]
@controller_type=params[:ctrlrtype]
@site_type=params[:sitetype]
@latitue=params[:latitude]
@longitude=params[:Longitude]
@authorization_code= params[:code1]
@installation_details = client.query("INSERT INTO installationsetup (installation_id, controller_id, sim_no, product_mdl_name, mobile_no, product_unit_srl_no, Date_of_commissioning, panel_no, installed_location, alternatormake, installed_addr, alternator_no, customer_name,cus_mailid, engine_no, technician_name, site_manager_name, ctrlr_type, site_type, latitude, longitude, authorization_code) VALUES(null,'#{@ctrlid}','#{@sim_card_no}','#{@product_mdl_name}','#{@mobile_no}','#{@product_unit_serial_no}','#{@date_of_commissioning}','#{@panel_no}','#{@installed_location}','#{@alternator_make}','#{@installed_addrs}','#{@alternator_no}','#{@customer_name}','#{@cus_mailid}','#{@engine_no}','#{@technician_name}','#{@site_manager_name}','#{@controller_type}','#{@site_type}','#{@latitue}','#{@longitude}','#{@authorization_code}')")
redirect_to '/customerinstallation'
  end
end
