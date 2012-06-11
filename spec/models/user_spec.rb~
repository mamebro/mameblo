require 'spec_helper'

describe User do

  before do
   @user = User.new(name: "Example User",
             password: "foobar", password_confirmation: "foobar")
  end

  subject{ @user }

  it { should respond_to(:name) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }

   describe "when password is not present" do
       before { @user.password = @user.password_confirmation = " " }
           it { should_not be_valid }
             end

               describe "when password doesn't match confirmation" do
                   before { @user.password_confirmation = "mismatch" }
                       it { should_not be_valid }
                         end

                           describe "when password confirmation is nil" do
                               before { @user.password_confirmation = nil }
                                   it { should_not be_valid }
                 end


  
end