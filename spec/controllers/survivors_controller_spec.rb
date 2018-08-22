require 'rails_helper'
describe SurvivorsController, type: :controller do
  let(:survivor_params_factory) {
    FactoryGirl.attributes_for :survivor
  }
  let(:survivor_params) do
    {
      name: "Naiguel Santos",
      age: 28,
      gender: "M",
      latitude: -28.28438608,
      longitude: -52.3664415,
      inventories_attributes: [
        {
          item: "Water",
          quantity: "6"
        },
        {
          item: "Medication",
          quantity: "3"
        }
      ]
    }
  end
  let(:inventories_attributes) do
    [
      {
        item: "Water",
        quantity: "6"
      },
      {
        item: "Medication",
        quantity: "3"
      }
    ]
  end
  let(:survivor) { create :survivor }
  describe '#create - Adding a survivor' do
    context 'with valid parameters' do
      it 'creates a new survivor' do
        post :create, survivor_params
        expect(response.status).to eq(201)
        expect(response).to have_http_status(:created)
      end
    end

  end
  describe '#show' do
    context 'with a valid id' do
      it 'returns the survivor model' do
        get :show, id: survivor.id
        expect(response.status).to eq(200)
      end
    end
  end
  describe "#index Listing survivors" do
    it "should returns all survivors" do
      survivor = FactoryGirl.create(:survivor)
      get :index
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(json_response.count).to eq 1
    end
  end


  describe "#update - Updating survivor's location" do
    let(:last_location) do
      {
        latitude: 40.730610,
        longitude: -73.935242
      }
    end
    let(:update_params) do
      {
        latitude: '-16.6868824',
        longitude: '-49.2647885'
      }
    end
    context 'with valid parameters' do
      it 'updates the survivor location' do
        put :update, id: survivor.id, survivor: last_location
        expect(response.status).to eq(204)
        expect(assigns(:survivor).latitude).to eq(last_location[:latitude])
        expect(assigns(:survivor).longitude).to eq(last_location[:longitude])
      end
    end
    context 'with invalid parameters' do
      let(:invalid_values) do
        {
          latitude: 40.730610,
          longitude: nil
        }
      end

      it 'returns the request errors' do
        put :update, id: survivor.id, survivor: invalid_values
        expect(response.status).to eq(422)
        json = JSON.parse(response.body)
        expect(json).to be_a(Hash)
        expect(json.keys).to eq(%w(longitude))
        expect(json['longitude']).to eq(["can't be blank"])
      end
    end
  end

  describe '#report_infection' do
    context 'with a valid id' do
      context 'for a not infected survivor' do
        it 'increment the infection counter and returns the regular message' do
          post :report_infection, id: survivor.id
          expect(response.status).to eq(200)
          json = JSON.parse(response.body)
          expect(json['message']).to eq('Survivor reported as infected 1 times')
        end
      end
    end
  end


end
