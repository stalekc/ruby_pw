require 'rails_helper'

RSpec.describe SessController, type: :controller do

  describe "GET #login" do
    it "returns http success" do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #logout" do
    it "returns http success" do
      get :logout
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #middle" do
    it "returns http success" do
      get :middle
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #out" do
    it "returns http success" do
      get :out
      expect(response).to have_http_status(:success)
    end
  end

end
