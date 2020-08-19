class Post < ApplicationRecord
  validates :title, {presence: true, length: {maximum: 40}}
  validates :content, {presence: true, length: {maximum: 500}}
  validates :user_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
  
end
