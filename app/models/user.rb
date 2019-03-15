class User < ApplicationRecord

  validates :login, uniqueness: true

  def self.authenticate(login, password)
    user = find_by_login(login)
    return user if user.password == password
  end
end
