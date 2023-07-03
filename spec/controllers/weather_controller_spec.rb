require 'rails_helper'

RSpec.describe ::WeatherController, type: :controller do
  describe "#result" do
    context 'with correct parameters' do
      before(:each) do
        stub_request(:get, 'https://api.openweathermap.org/data/2.5/weather').
          with(query: open_weather_params).
          to_return(body: File.open('./spec/fixtures/weather_success.json'))
      end

      context 'by lat and long' do
        let(:params) {{lat: '20.97', lon: '89.61', city_name: ""}}
        let(:open_weather_params) {{lat: '20.97', lon: '89.61', appid: ENV['OPEN_WEATHER_API_KEY']}}

        it 'renders result correctly' do
          get :result, params: params
          expect(response).to render_template(:result)
        end
      end

      context 'by city_name' do
        let(:params) {{lat: '', lon: '', city_name: "merida"}}
        let(:open_weather_params) {{q: 'merida', appid: ENV['OPEN_WEATHER_API_KEY']}}

        it 'renders result correctly' do
          get :result, params: params
          expect(response).to render_template(:result)
        end
      end
    end

    context 'validating contract' do
      context 'when providing lat, lon and city_name' do
        let(:params) {{lat: '20.97', lon: '89.61', city_name: "merida"}}

        it 'has a flash error and redirects' do
          get :result, params: params
          expect(response).to redirect_to(root_url)
          expect(flash['error']).to include('Only set lat and lon together or city_name alone')
        end
      end

      context 'when providing non-float values values for lat and lon' do
        let(:params) {{lat: 'lat', lon: 'lon', city_name: ""}}

        it 'has a flash error and redirects' do
          get :result, params: params
          expect(response).to redirect_to(root_url)
          expect(flash['error']).to include('must be a float').twice
        end
      end
    end

    context 'with incorrect openweather paramaters' do
      before(:each) do
        stub_request(:get, 'https://api.openweathermap.org/data/2.5/weather').
          with(query: open_weather_params).
          to_return(body: response_body.to_json)
      end

      context 'providing non-valid lat and lon' do
        let(:open_weather_params) {{lat: '20.97', lon: '4654654654', appid: ENV['OPEN_WEATHER_API_KEY']}}
        let(:response_body) { {"cod":"400","message":"wrong longitude"} }

        it 'renders a bad_request response' do
          get :result, params: {lat: '20.97', lon: '4654654654', city_name: ""}
          expect(response).to redirect_to(root_url)
          expect(flash['error']).to include('wrong longitude')
        end
      end
    end
  end
end