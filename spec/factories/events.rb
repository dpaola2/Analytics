# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    id 123
    blob "{\"traits\":{\"name\":\"\",\"firstName\":null,\"lastName\":null,\"email\":\"\",\"created\":\"2014-04-10 13:21:19 -0700\",\"lastSeen\":\"2014-04-10T20:22:29.248Z\",\"role\":\"visitor\",\"status\":\"visitor\",\"Experiment: Homepage v2\":\"Variation #1\"},\"timestamp\":\"2014-04-10T20:22:29.627Z\",\"writeKey\":\"aoqc6vja9l\",\"sessionId\":\"bfb33011-e7ab-4adc-b49e-15685d6be274\",\"requestId\":\"7dc6dbd2-abb2-425a-9068-af8f99a7890e\",\"action\":\"Identify\",\"channel\":\"client\",\"projectId\":\"4dxxt7fy3m\",\"requestTime\":\"2014-04-10T20:22:29.704Z\",\"version\":1,\"options\":{\"userAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/34.0.1847.116 Safari/537.36\",\"library\":\"analytics.js\",\"ip\":\"216.38.152.226\"}}" 
  end
end
