require 'rails_helper'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { build(:user, username: 'not_you') }
  let!(:registered_application) { create(:registered_application, user: user) }
  let(:not_your_app) { create(:registered_application, user: other_user) }

  context 'unsigned-in user' do
    describe 'GET index' do
      it 'returns http redirect' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET show' do
      it 'returns http redirect' do
        get :show, id: registered_application.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET new' do
      it 'returns http redirect' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST create' do
      it 'returns http redirect' do
        post :create, registered_application: { name: Faker::Company.unique.bs, url: Faker::Internet.unique.url, user_id: user.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET edit' do
      it 'returns http redirect' do
        get :edit, id: registered_application.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PUT update' do
      it 'returns http redirect' do
        new_name = 'hello'
        new_url = 'worldhelloworldhelloworld'

        put :update, id: registered_application.id, registered_application: { name: new_name, url: new_url }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE destroy' do
      it 'returns http redirect' do
        delete :destroy, id: registered_application.id
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'signed-in user accessing their own apps' do
    before do
      sign_in user
    end

    describe 'GET index' do
      it 'returns http success' do
        get :index
        expect(response).to have_http_status(:success)
      end

      # need a test to prove it shows your apps and no one else's apps
    end

    describe 'GET show' do
      it 'returns http success' do
        get :show, id: registered_application.id
        expect(response).to have_http_status(:success)
      end

      it 'renders the #show view' do
        get :show, id: registered_application.id
        expect(response).to render_template :show
      end

      it 'assigns registered_application to @registered_application' do
        get :show, id: registered_application.id
        expect(assigns(:registered_application)).to eq(registered_application)
      end
    end

    describe 'GET new' do
      it 'returns http success' do
        get :new
        expect(response).to have_http_status(:success)
      end

      it 'renders the #new view' do
        get :new
        expect(response).to render_template :new
      end

      it 'instantiates @registered_application' do
        get :new
        expect(assigns(:registered_application)).not_to be_nil
      end
    end

    describe 'POST create' do
      it 'increases the number of RegisteredApplication by 1' do
        expect { post :create, registered_application: { name: Faker::Company.unique.bs, url: Faker::Internet.unique.url, user_id: user.id } }.to change(RegisteredApplication, :count).by(1)
      end

      it 'assigns the new registered_application to @registered_application' do
        post :create, registered_application: { name: Faker::Company.unique.bs, url: Faker::Internet.unique.url, user_id: user.id }
        expect(assigns(:registered_application)).to eq RegisteredApplication.last
      end

      it 'redirects to the new registered_application' do
        post :create, registered_application: { name: Faker::Company.unique.bs, url: Faker::Internet.unique.url, user_id: user.id }
        expect(response).to redirect_to [RegisteredApplication.last]
      end
    end

    describe 'GET edit' do
      it 'returns http success' do
        get :edit, id: registered_application.id
        expect(response).to have_http_status(:success)
      end

      it 'renders the #edit view' do
        get :edit, id: registered_application.id
        expect(response).to render_template :edit
      end

      it 'assigns registered_application to be updated to @registered_application' do
        get :edit, id: registered_application.id
        registered_application_instance = assigns(:registered_application)

        expect(registered_application_instance.id).to eq registered_application.id
        expect(registered_application_instance.name).to eq registered_application.name
        expect(registered_application_instance.url).to eq registered_application.url
      end
    end

    describe 'PUT update' do
      it 'updates registered_application with expected attributes' do
        new_name = 'hello'
        new_url = 'worldhelloworldhelloworld'

        put :update, id: registered_application.id, registered_application: { name: new_name, url: new_url }
        updated_registered_application = assigns(:registered_application)
        expect(updated_registered_application.id).to eq registered_application.id
        expect(updated_registered_application.name).to eq new_name
        expect(updated_registered_application.url).to eq new_url
      end

      it 'redirects to the updated registered_application' do
        new_name = 'hello'
        new_url = 'worldhelloworldhelloworld'
        put :update, id: registered_application.id, registered_application: { name: new_name, url: new_url }
        expect(response).to redirect_to [registered_application]
      end
    end

    describe 'DELETE destroy' do
      it 'deletes the registered_application' do
        delete :destroy, id: registered_application.id
        count = RegisteredApplication.where(id: registered_application.id).size
        expect(count).to eq 0
      end

      it 'redirects to registered_applications index' do
        delete :destroy, id: registered_application.id
        expect(response).to redirect_to registered_applications_path
      end
    end
  end

  context 'signed-in user trying to access apps they do not own' do
    before do
      sign_in user
    end

    describe 'GET show' do
      it 'returns http redirect' do
        get :show, id: not_your_app.id
        expect(response).to redirect_to(registered_applications_index_path)
      end
    end

    describe 'GET edit' do
      it 'returns http redirect' do
        get :edit, id: not_your_app.id
        expect(response).to redirect_to(registered_applications_index_path)
      end
    end

    describe 'PUT update' do
      it 'returns http redirect' do
        new_name = 'hello'
        new_url = 'worldhelloworldhelloworld'

        put :update, id: not_your_app.id, registered_application: { name: new_name, url: new_url }
        expect(response).to redirect_to(registered_applications_index_path)
      end
    end

    describe 'DELETE destroy' do
      it 'returns http redirect' do
        delete :destroy, id: not_your_app.id
        expect(response).to redirect_to(registered_applications_index_path)
      end
    end
  end
end
