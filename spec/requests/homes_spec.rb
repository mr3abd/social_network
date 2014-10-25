require 'spec_helper'

describe "Home Controller" do
  
  subject {page}

  describe "Home Page" do
    before {visit root_path}
    it {should have_content('Social Network')} 
    #it {should have_title('Ruby on Rails Social Network 2014 | Home')}   
    it {should have_title(full_title(''))} 

=begin
    it "should have the content 'Social Network'" do
      #visit root_path
      expect(page).to have_content('Social Network')
    end
  
    it "should have the title 'Home'" do
      #visit root_path
      expect(page).to have_title("Ruby on Rails Social Network 2014 | Home")
    end
=end  

  end
end
