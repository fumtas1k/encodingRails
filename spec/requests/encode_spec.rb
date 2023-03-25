require 'rails_helper'

RSpec.describe "Encodes", type: :request do
  let(:params) {
    {
      "title": "テスト",
      "customers": [
        {
          "code": "1234",
          "products": [
            {
              "name": "りんご",
              "type": "フルーツ"
            },
            {
              "name": "ワイン",
              "type": "ドリンク"
            }
          ]
        },
        {
          "code": "5678",
          "products": [
            {
              "name": "みかん",
              "type": "フルーツ"
            },
            {
              "name": "日本酒",
              "type": "ドリンク"
            }
          ]
        }
      ]
    }
  }

  describe "POST /" do
    it "レスポンスボディの文字コードがSJISであること" do
      post "/", params: convert_params_to_sjis(params)
      expect(response).to have_http_status(:success)
      expect(response.body.encoding).to be Encoding::SJIS
    end
  end

  describe "GET /get_sample_data" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end
  end

end

private
def convert_params_to_sjis(hash)
  converted_params = {}
  hash.each do | k, v |
    if v.is_a? Hash
      converted_params[k] = convert_params_to_sjis(v)
    elsif v.is_a? Array
      converted_params[k] = v.map { convert_params_to_sjis(_1) }
    else
      converted_params[k] = v.encode(Encoding::SJIS)
    end
  end
  converted_params
end
