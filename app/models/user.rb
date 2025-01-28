class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  VALID_LOCALES = %w[gb us].freeze

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :locale, presence: true, inclusion: { in: VALID_LOCALES }
  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :budget, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def self.valid_locales
    VALID_LOCALES
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
