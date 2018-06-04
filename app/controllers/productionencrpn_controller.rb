class ProductionencrpnController < ApplicationController

def encrpnhome

end

def authendicate
ctrlrid =params[:ctrlrid]
#puts generateKey(ctrlrid);
# @first_value = params[:passed_parameter]
@get_value = generateKey(ctrlrid);
puts "hi"
puts @get_value
puts "hi"
render 'encrpnhome'
end
def generaterandon()
array = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    randtemp =[];
    randtemp.push(array[rand(0..35)]);
    randtemp.push(array[rand(0..35)]);
    randtemp.push(array[rand(0..35)]);
    randtemp.push(array[rand(0..35)]);
    randtemp.push(array[rand(0..35)]);

return randtemp[rand(0..4)];
  end
def generateKey(ctrlrid)
  finalkey='';
  index_c = 0;
  randomkey=[6,9,2,4,1,8,10,3,7,5];
  keyplaceholder=[0,1,1,0,1,0,1,0,0,1,0,1,1,1,0,0,0,0,1,1];
  keyplaceholder.each do |p|
    if(p==0)
      finalkey+=generaterandon();
    else
     # puts 'randomkey  %d' % randomkey[index_c];
      finalkey+=ctrlrid[randomkey[index_c]-1];
  index_c=index_c+1;
  
    end
#puts finalkey;
  end
  return finalkey;

  end

end
