require 'spec_helper'

describe User do
  before { @user User.new(name: "Examle User", email: "user@exapmle.com")} 
  
  subject {@user}
  
  it {respond_to(:name)}
  it {respond_to(:email)}

end
