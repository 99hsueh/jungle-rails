require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @emailUnique = User.new(
      first_name: 'Zzzz',
      last_name: 'ehhh',
      email: 'abcdefg@gmail.com',
      password: 'aaaaaa',
      password_confirmation: 'aaaaaa'
    )
    @emailUnique.save
  end

  describe 'Validations' do
    # validation examples here
    it 'password must equal password_confirmation' do
      @passNoMatch = User.new(
        first_name: 'abcd',
        last_name: 'efgh',
        email: 'abcdefgh@gmail.com',
        password: 'ccccc',
        password_confirmation: 'bbbbb'
      )
      expect(@passNoMatch).to_not be_valid
      expect(@passNoMatch.save).to be false
    end

    it 'password/password_confirmation must not be empty' do
      @passEmpty = User.new(
        first_name: 'abcd',
        last_name: 'efgh',
        email: 'abcdefgh@gmail.com',
        password: '',
        password_confirmation: ''
      )
      expect(@passEmpty).to_not be_valid
      expect(@passEmpty.save).to be false
    end

    it 'email must be unique' do

      @emailDup = User.new(
        first_name: 'abcd',
        last_name: 'efgh',
        email: 'abcdefG@gmail.com',
        password: 'bbbabab',
        password_confirmation: 'bbbabab'
      )
      expect(@emailDup).to_not be_valid
      expect(@emailDup.save).to be false
    end

    it 'password must be at least 5 characters' do
      @passwordLength = User.new(
        first_name: 'Chuck',
        last_name: 'efgh',
        email: 'ffffff@gmail.com',
        password: 'bbab',
        password_confirmation: 'bbab'
      )
      expect(@passwordLength).to_not be_valid
      expect(@passwordLength.save).to be false
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should ignore spaces for username input when logging in" do
      @user = User.authenticate_with_credentials(' abcdefg@gmail.com ', @emailUnique.password)
      expect(@user).to be_truthy
    end

    it "should ignore case sensitivity for username input when logging in" do
      @user = User.authenticate_with_credentials('ABcdefg@gmail.com', @emailUnique.password)
      expect(@user).to be_truthy
    end
  end

end