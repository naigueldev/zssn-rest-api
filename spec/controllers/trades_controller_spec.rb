require 'rails_helper'
describe TradesController, type: :controller do
  describe '#trade' do
    let(:survivor_1) {
      FactoryGirl.create :survivor_one,
      inventories_attributes: [
        {
          item: 'Water',
          quantity: 1
        },
        {
          item: 'Food',
          quantity: 2
        }
      ]
    }
    let(:survivor_2) {
      FactoryGirl.create :survivor_two,
      inventories_attributes:[
        {
          item: 'Medication',
          quantity: 2
        },
        {
          item: 'Ammunition',
          quantity: 6
        }
      ]
    }
    let(:survivor_1_resources_params) do
      [
        {
          item: 'Water',
          quantity: 1
        },
        {
          item: 'Food',
          quantity: 2
        }
      ]
    end
    let(:survivor_2_resources_params) do
      [
        {
          item: 'Medication',
          quantity: 2
        },
        {
          item: 'Ammunition',
          quantity: 6
        }
      ]
    end
    let(:trade_params) do
      {
        trade: {
          survivor_one: {
            id: survivor_1.id,
            inventories: survivor_1_resources_params
          },
          survivor_two: {
            id: survivor_2.id,
            inventories: survivor_2_resources_params
          }
        }
      }
    end
    it 'should not allow trade when a survivor is infected' do
      survivor_2.update_attribute(:is_infected, 4)
      post :trade, trade_params
      expect(response).to have_http_status(:conflict)
    end
  end
end
