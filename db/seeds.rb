require 'factory_bot_rails'

# Products (5): Burlap Bouquet, Peonies, The Minimalist, Jawbreaker, Reset Button
product_names = ['Burlap Bouquet', 'Peonies', 'The Minimalist', 'Jawbreaker', 'Reset Button']
product_names.each do |product_name|
  FactoryBot.create(:product, name: product_name)
end

# Distribution Centers (3): Sun Valley, Green Valley, and Agrogana
distribution_center_names = ['Sun Valley', 'Green Valley', 'Agrogana']
distribution_center_names.each do |distribution_center_name|
  FactoryBot.create(:distribution_center, name: distribution_center_name)
end

# Fulfillment Centers (1): Watsonville
FactoryBot.create(:fulfillment_center, name: 'Watsonville')

# Sun Valley can only fulfill Peonies
sun_valley = DistributionCenter.find_by_name('Sun Valley')
peonies = Product.find_by_name('Peonies')
FactoryBot.create(:distribution_center_product, product: peonies, distribution_center: sun_valley)

# Green Valley can only fulfill Jawbreaker
green_valley = DistributionCenter.find_by_name('Green Valley')
jawbreaker = Product.find_by_name('Jawbreaker')
FactoryBot.create(:distribution_center_product, product: jawbreaker, distribution_center: green_valley)

# Agrogana can only fulfill The Minimalist and Jawbreaker
minimalist = Product.find_by_name('The Minimalist')
agrogana = DistributionCenter.find_by_name('Agrogana')
FactoryBot.create(:distribution_center_product, product: jawbreaker, distribution_center: agrogana)
FactoryBot.create(:distribution_center_product, product: minimalist, distribution_center: agrogana)
