namespace :user do
  desc "Sends consolidate email to user"
  task send_consolidate_email: :environment do
    users = User.all
    users.each do |user|
      puts '=' * 80
      puts "Sending consolidate orders for #{user.name}"
      UserMailer.consolidate_orders(user).deliver_now
      puts '=' * 80
    end
  end
end
