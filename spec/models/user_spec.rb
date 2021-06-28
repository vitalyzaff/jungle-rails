require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create new user if all fields are valid' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: '12345qwerty')
      @user.save
      expect(@user).to be_valid
    end

    it 'should NOT create new user if password and password_confirmation do NOT match' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: 'qwerty')
      @user.save
      expect(@user).not_to be_valid
    end

    it 'should NOT create new user if password and password_confirmation are BLANK' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: nil, password_confirmation: nil)
      @user.save
      expect(@user).not_to be_valid
    end

    it 'should NOT create new user if name is NOT valid' do
      @user = User.create(name: nil, email: 'joe@gmail.com', password: 'qwerty', password_confirmation: 'qwerty')
      @user.save
      expect(@user).not_to be_valid
    end

    it 'should NOT create new user if email is NOT valid' do
      @user = User.create(name: 'Joe', email: nil, password: 'qwerty', password_confirmation: 'qwerty')
      @user.save
      expect(@user).not_to be_valid
    end

    it 'should NOT create new user if email already exists in DB' do
      @user1 = User.create(name: 'Joe', email: 'joe@gmail.com', password: 'qwerty', password_confirmation: 'qwerty')
      @user2 = User.create(name: 'Joe', email: 'joe@gmail.com', password: 'qwerty', password_confirmation: 'qwerty')
      @user1.save
      @user2.save
      expect(@user2).not_to be_valid
    end

    it 'email should NOT be case sensitive' do
      @user1 = User.create(name: 'Joe', email: 'joe@gmail.com', password: 'qwerty', password_confirmation: 'qwerty')
      @user2 = User.create(name: 'Joe', email: 'JOE@gmail.com', password: 'qwerty', password_confirmation: 'qwerty')
      @user1.save
      @user2.save
      expect(@user2).not_to be_valid
    end

    it 'should NOT create new user if password is less than 5 characters long' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '123', password_confirmation: '123')
      @user.save
      expect(@user).not_to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should login user if credentials are valid' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: '12345qwerty')
      @user.save
      expect(User.authenticate_with_credentials('joe@gmail.com', '12345qwerty')).to eq(@user)
    end

    it 'should NOT login user if email is NOT valid' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: '12345qwerty')
      @user.save
      expect(User.authenticate_with_credentials('joe1993@gmail.com', '12345qwerty')).not_to eq(@user)
    end

    it 'should NOT login user if password does NOT match' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: '12345qwerty')
      @user.save
      expect(User.authenticate_with_credentials('joe@gmail.com', 'qwerty')).not_to eq(@user)
    end

    it 'should login user if email is in UPPERCASE' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: '12345qwerty')
      @user.save
      expect(User.authenticate_with_credentials('JOE@GMAIL.COM', '12345qwerty')).to eq(@user)
    end

    it 'should login user if space before email input' do
      @user = User.create(name: 'Joe', email: 'joe@gmail.com', password: '12345qwerty', password_confirmation: '12345qwerty')
      @user.save
      expect(User.authenticate_with_credentials(' joe@gmail.com', '12345qwerty')).to eq(@user)
    end

  end
end
