class Subscription < ApplicationRecord
  belongs_to :user

  VALID_BILLING_FREQUENCIES = %w[monthly annual].freeze
  SUBSCRIPTION_NAMES = %w[
    netflix amazon_prime_video disney_plus hbo_max hulu apple_tv_plus peacock paramount_plus discovery_plus youtube_premium cruncyroll starz showtime britbox acorn_tv amc_plus mubi sling_tv fubo_tv philo
  ].freeze

  validates :name, presence: true, inclusion: { in: SUBSCRIPTION_NAMES }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :billing_frequency_case_insensitive_inclusion

  validate :started_at_not_nil
  validate :expires_at_not_nil
  validate :started_at_before_expires_at

  def active?
    return true if expires_at.nil?
    Time.current <= expires_at
  end

  def self.subscription_names
    SUBSCRIPTION_NAMES
  end

  private

  def billing_frequency_case_insensitive_inclusion
    unless VALID_BILLING_FREQUENCIES.include?(billing_frequency.to_s.downcase)
      errors.add(:billing_frequency, :inclusion, message: "is not included in the list")
    end
  end

  # start date or expire date are optional but cannot be nil
  def started_at_not_nil
    errors.add(:started_at, "cannot be nil") if started_at.nil?
  end

  def expires_at_not_nil
    errors.add(:expires_at, "cannot be nil") if expires_at.nil?
  end

  def started_at_before_expires_at
    return if started_at.nil? || expires_at.nil?
    errors.add(:expires_at, "must be after the start date") if started_at > expires_at
  end
end
