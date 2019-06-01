json.status 200
json.data do
  json.average_buy @average_rate[:buy]
  json.average_sell @average_rate[:sell]
end