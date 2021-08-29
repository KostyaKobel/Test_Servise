require 'rails_helper'

RSpec.describe 'links/index.html.slim', type: :view do
  context 'when template rendered' do
    it 'infers the controller path' do
      expect(controller.controller_path).to eq('links')
    end

    it 'infers the controller action' do
      expect(controller.request.path_parameters[:action]).to eq('index')
    end
  end
end
