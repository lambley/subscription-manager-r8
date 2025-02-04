require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get new_registration_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let (:user) { build(:user) }

      it "returns http success" do
        post registration_path, params: { user: { first_name: user.first_name, last_name: user.last_name, locale: user.locale, email_address: user.email_address, password: user.password, password_confirmation: user.password_confirmation } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:user) { build(:user) }

      it "returns http unprocessable entity" do
        post registration_path, params: { user: { first_name: user.first_name, last_name: user.last_name, locale: user.locale, email_address: nil, password: user.password, password_confirmation: user.password_confirmation } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        post registration_path, params: { user: { first_name: user.first_name, last_name: user.last_name, locale: user.locale, email_address: nil, password: user.password, password_confirmation: user.password_confirmation } }

        expect(assigns(:user).errors.full_messages).to include("Email address can't be blank")
      end

      it "handles duplicate email addresses" do
        create(:user, email_address: user.email_address)
        post registration_path, params: { user: { first_name: user.first_name, last_name: user.last_name, locale: user.locale, email_address: user.email_address, password: user.password, password_confirmation: user.password_confirmation } }

        expect(assigns(:user).errors.full_messages).to include("Email address has already been taken")
      end
    end

    context "on rescue" do
      let(:user) { build(:user) }

      it "returns http unprocessable entity" do
        allow_any_instance_of(User).to receive(:save).and_raise(ActiveRecord::RecordNotUnique)
        post registration_path, params: { user: { first_name: user.first_name, last_name: user.last_name, locale: user.locale, email_address: user.email_address, password: user.password, password_confirmation: user.password_confirmation } }

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        allow_any_instance_of(User).to receive(:save).and_raise(ActiveRecord::RecordNotUnique)
        post registration_path, params: { user: { first_name: user.first_name, last_name: user.last_name, locale: user.locale, email_address: user.email_address, password: user.password, password_confirmation: user.password_confirmation } }

        expect(assigns(:user).errors.full_messages).to include("Email address has already been taken")
      end
    end
  end
end
