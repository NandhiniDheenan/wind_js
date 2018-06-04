Rails.application.routes.draw do


  #get 'cusdashboard/cusdashboardview'

get 'cusdashboard' => 'cusdashboard#cusdashboardview'
  get 'cuslogin/cusloginview'

  get 'newdashboard' =>  'newdashboard#dashboardshow'


 # get 'helpdesk/helpdeskshow'

#  get 'profile/showprofile'

 # get 'powercurve/powershow'

 # get 'regionmap/map'

  #get 'productionencrpn/encrpnhome'

 # get 'installationsetup/customerinstallation'
#get 'login' = > 'windlogin#log'


get 'customer' => 'customer#customer'
get 'customerpost' => 'customer#customerDetails'
#get 'dataview/datatable'
get 'dataview' => 'dataview#datatable'
# get 'chart/graph'
get 'graph' => 'chart#graph'
get 'home' => 'homepage#home'
get 'powershow' => 'powercurve#powershow'
get 'authendicate' => 'productionencrpn#authendicate'

#get 'windlogin/login'
get 'login' => 'windlogin#log'
post 'loginpost' => 'windlogin#login'

get 'customerinstallation' => 'installationsetup#install'
get 'customerinstallationpost' => 'installationsetup#customerinstallation'

get 'reports' =>'report#showreport'
get 'windmon/c_operations/store_data' => 'windmon#wind' 
get 'chart' => 'chart#graph'

get 'production' => 'productionencrpn#encrpnhome'
get 'powercurve' =>  'powercurve#powershow'
get 'regionmap' =>'regionmap#map'
get 'profile' => 'profile#showprofile'
get 'helpdesk' => 'helpdesk#helpdeskshow'


get 'searchrep' => 'report#searchrep'
get 'oneday' => 'report#oneday'
get 'oneweek' => 'report#oneweek'
get 'onemonth' => 'report#onemonth'
get 'sixmonths' => 'report#sixmonths'
get 'oneyear' => 'report#oneyear'

get 'pc_oneday' => 'report#pc_oneday'
get 'pc_oneweek' => 'report#pc_oneweek'
get 'pc_onemonth' => 'report#pc_onemonth'
get 'pc_sixmonths' => 'report#pc_sixmonths'
get 'pc_oneyear' => 'report#pc_oneyear'

get 'search_graph' =>'chart#search_graph'

get 'search_powercurve' => 'powercurve#search_powercurve'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
