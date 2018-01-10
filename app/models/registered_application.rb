class RegisteredApplication < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :name, length: { minimum: 5 }, presence: true
  validates :url, length: { minimum: 10 }, presence: true
end
