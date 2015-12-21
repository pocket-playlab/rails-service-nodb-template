require 'rails_helper'

RSpec.describe StatusController, type: :controller do
  describe '#check' do
    it 'should render 200 when everything is ok' do
      get :check
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['errors']).to eq({})
    end
  end
end
