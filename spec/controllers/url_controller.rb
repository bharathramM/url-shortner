# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe UrlController, type: :controller do
  let(:valid_url) { create(:url, :valid) }

  describe 'Create shorten url #create' do
    context 'Valid' do
      it 'Should Create successfully' do
        param = { url: { source: 'www.google.com' } }
        post :create, xhr: true, params: param
        expect(assigns(:url)).not_to eq nil
      end
    end

    context 'InValid' do
      it 'Should raise error if url is in incorrect format' do
        param = { url: { source: 'google' } }
        expect { post :create, xhr: true, params: param }
          .to raise_error(RuntimeError, 'Invalid URL')
      end

      it 'Should raise error if params is incorrect' do
        param = { source: 'google' }
        expect { post :create, xhr: true, params: param }
          .to raise_error
      end
    end
  end

  describe 'Url Redirector for provided shorten url #redirector' do
    context 'Valid' do
      it 'Should Redirect successfully' do
        (get :redirector, params: { shorten: valid_url.shorten })
          .should redirect_to valid_url.source
      end
    end
  end
end
