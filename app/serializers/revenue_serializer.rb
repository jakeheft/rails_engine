class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  def self.revenue(data)
    {
      "data": {
        "id": nil,
        "attributes": {
          "revenue": data[0][:revenue]
        }
      }
    }
  end
end
