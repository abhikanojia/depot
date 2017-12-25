namespace :user do
  desc "Change user's role to admin (requires user's email.)"
  task :set_role_to_admin, [:user_email] => :environment do |task, argument|
    user_email = argument.user_email
    begin
      user = User.find_by_email!(user_email)
      puts '=' * 80
      puts "Setting user role to admin of user: #{user_email}"
      user.role = 'admin'
      user.save
      puts '=' * 80
      puts "Successfully assigned role."
    rescue ActiveRecord::RecordNotFound => error
      puts error.message.concat('!! Please try with different email.')
    end
  end
end
