namespace :db do
  desc "Assign first Category to all products"
  task port_legacy_products: :environment do
    puts "Assigning category to products"
    puts '=' * 80
    category_id = Category.first.id
    product_ids = Product.where(category_id: nil).ids
    Product.where(id: product_ids).update_all(category_id: category_id)
    puts '=' * 80
    puts "Status: #{product_ids.count} products assigned category : #{Category.first.name}"
  end

end
