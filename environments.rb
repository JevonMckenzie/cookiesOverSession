require 'pony'

configure :development do
  set :database, 'sqlite3:db/dev.db'
  set :show_exception, true
end

configure :test do
  set :database, 'sqlite3:db/test.db'
  set :show_exception, true
end

configure :production do
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

  ActiveRecord::Base.establish_connection(
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8'
  )
end

configure do
  Pony.options = {
    from: "noreply@#{ENV['SENDGRID_DOMAIN']}",
    via: :smtp,
    via_options: {
      address: 'smtp.sendgrid.net',
      port: '587',
      domain: ENV['SENDGRID_DOMAIN'],
      user_name: ENV['SENDGRID_USERNAME'],
      password: ENV['SENDGRID_PASSWORD'],
      authentication: :plain,
      enable_starttls_auto: true
    }
  }
end
