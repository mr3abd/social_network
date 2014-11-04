=begin
  
  DESCRIPTION 
  
  - The  "before" block, run the code inside the block before each example -  in thi  case, creating a new @user instance variable usin User.new and a valid initializat  ion hash.
  
  - "subject { @user }" makes @user the default subject of the example.
  
  - the two example:
    it {should respond_to(:name)}
    it { should respond_to(:email)} 
    test the existence of name and email attributes

    The respnd_to methods implicitly use the ruby method respond_to?, which accepts     a symbol and returns true if the object responds to the given method  or attribu    te or attribute and false otherwise 
    
=end

require 'spec_helper'

describe User do
  before { @user = User.new(name: "Examle User", email: "user@exapmle.com", password: "foobar", password_confirmation: "foobar")} 
  
  subject {@user}
  
  it { should respond_to(:name)}
  it { should respond_to(:email)}
  it { should respond_to(:password_digest)} 
  it { should respond_to(:password)}
  it { should respond_to(:password_confirmation)} 

  it {should be_valid} 
  #it {should_not be_valid } 

=begin
  it "@user have name attribute"do
    expect(@user).to respond_to(:name)
  end
  
  it "@user have email attribute"do
    expect(@user).to respond_to(:password)  
  end
=end  


  # test validation presence field name
  describe "When name is not present" do
    before {@user.name = " "} 
    it { should_not be_valid}  
  end 

  # test validation length field name
  describe "When name is too long " do
    before {@user.name = "a" * 51}
    it {should_not be_valid}
  end 



  # test validation presence field email
  describe "When email is not present" do
    before {@user.email = " "}
    it { should_not be_valid }
  end
   
  #test format validation fiels email
  describe "when email format is invalid" do  
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end  
  end 
  
  describe "When email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        #expect(@user).not_to be_valid
        expect(@user).to be_valid
      end
    end
  end 
 
  #Uniqueness email validation 
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup #@user.dup create a duplicate user with the same attribute
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    it {should_not be_valid}
  end

  #Validation password
  describe "when password is not present" do
    before do
      @user = User.new(name: "Example User", email: "user@example.com", password:" ", password_confirmation: " ")
    end
      it { should_not be_valid }
  end

  describe " when password doesn't mach confirmation" do
    before { @user.password_confirmation = "mismatch"}
    it { should_not be_valid}
  end
 
  describe "with a password that's too short" do
    before {@user.password = @user.password_confirmation = "a" * 5}
    it { should be_invalid}
  end
 

  #Test user uthentication
  describe "return value of authenticate method" do
    
    before {@user.save}
    let(:found_user) {User.find_by(email: @user.email)}
    
    describe "with valid password"  do
      it {should eq found_user.authenticate(@user.password)}
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) {found_user.authenticate("invalid")}
      it {should_not eq user_for_invalid_password}
      specify {expect(user_for_invalid_password).to be_false}
    end
  end
 
end
