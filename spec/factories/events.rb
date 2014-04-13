# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    id 123
    blob "{\"properties\":{},\"event\":\"viewed_landing\",\"timestamp\":\"2014-04-10T20:22:29.537Z\",\"userId\":\"1340587\",\"writeKey\":\"aoqc6vja9l\",\"sessionId\":\"f9e64b52-428e-4783-bd74-44dbd719a7ae\",\"requestId\":\"0cf6bee5-7900-4fe5-ab60-65f34f458725\",\"action\":\"Track\",\"channel\":\"client\",\"projectId\":\"4dxxt7fy3m\",\"requestTime\":\"2014-04-10T20:22:29.700Z\",\"version\":1,\"options\":{\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36\",\"library\":\"analytics.js\",\"ip\":\"216.38.152.226\"}}"
  end
end
