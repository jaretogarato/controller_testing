require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  # spec/support/controller_macros.rb
  login_user

  let(:valid_attributes) {
    { institution: 'Chase', amount: 200, active: true }
  }

  let(:invalid_attributes) {
    { institution: '' , amount: 200, active: true }
  }

  describe "GET #index" do
    it "returns http success" do
      FactoryGirl.create(:bank_account, user: @user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      bank_account = FactoryGirl.create(:bank_account, user: @user)
      get :show, params: { id: bank_account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      bank_account = FactoryGirl.create(:bank_account, user: @user)
      get :edit, params: { id: bank_account.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it 'creates a new bank account' do
      post :create, params: { bank_account: valid_attributes }
      expect(@user.bank_accounts.count).to eq(1)
    end

    it 'does not create a new bank account with invalid params' do
      # post :create, params: { invalid_attributes }
      expect(@user.bank_accounts.count).to eq(0)
    end
  end

  describe "PUT / PATCH #update" do
    let(:new_attributes){
      { institution: 'Wells Fargo'}
    }
    let(:invalid_update_attributes){
      { email: '' }
    }
    before(:each) do
      @bank_account = FactoryGirl.create(:bank_account, user: @user)
    end
    it 'updates the bank account with valid attributes' do
      put :update, params: { id: @bank_account.id, bank_account: new_attributes }
      # we now have a stale varible. only need to reload in update so:
      @bank_account.reload
      expect(@bank_account.institution).to eq(new_attributes[:institution])
    end
    it 'does not update the bank account with invalid attributes' do
      put :update, params: { id: @bank_account.id, bank_account: invalid_attributes}
      @bank_account.reload 
      expect(@bank_account.institution).to_not eq(invalid_attributes[:institution])
    end

  end

end
