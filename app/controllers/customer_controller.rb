
class CustomerController < ApplicationController

def customer
render 'customerDetails.html.erb'
end

  def customerDetails
begin
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sql123", :database => "windmon")
rescue Mysql2::Error => e
puts "error"
ensure
#disconnect from server
end

@Customer_Name=params[:cusname]
@Customer_Address=params[:cusAddr]
@Customer_City=params[:cuscity]
@Customer_State=params[:cusstate]
@Customer_Country=params[:cuscountry]
@Customer_ZipCode=params[:cuszip]
@Customer_ContactNo=params[:cuscontact]
@Customer_Email=params[:email]
@customer_password="apex@123"
@customer_details = client.query("INSERT INTO Customer_Details (cus_id, Customer_Name, Customer_Address, Customer_City, Customer_State, Customer_Country, Customer_Zipcode, Customer_ContactNo, Customer_Email, cus_password) VALUES(null,'#{@Customer_Name}','#{@Customer_Address}','#{@Customer_City}','#{@Customer_State}','#{@Customer_Country}','#{@Customer_ZipCode}','#{@Customer_ContactNo}','#{@Customer_Email}','#{@customer_password}')")
redirect_to '/customer'
  end

end
