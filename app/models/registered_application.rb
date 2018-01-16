class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events, dependent: :destroy

  validates :user, presence: true
  validates :name, length: { minimum: 5 }, presence: true,
                   uniqueness: { scope: :user,
                                 message: 'You have already used this name' }
  validates :url, length: { minimum: 10 }, presence: true,
                  uniqueness: { scope: :user,
                                message: 'You are already tracking this URL' },
                  format: { with: /\Ahttps?:\/\//i, message: 'must be a valid http or https URL' }
end
