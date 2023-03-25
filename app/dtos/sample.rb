class Sample
  SAMPLE_DATA = {
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

  def self.extract_keys(data)
    keys = []
    if data.is_a? Hash
      data.each do |k, v|
        keys << k
        keys += extract_keys(v)
      end
    end
    keys
  end
end
