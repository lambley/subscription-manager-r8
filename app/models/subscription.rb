class Subscription < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validate :billing_frequency_case_insensitive_inclusion


  # Date validations
  validate :started_at_not_nil
  validate :expires_at_not_nil
  validate :started_at_before_expires_at

  def active?
    return true if expires_at.nil?
    Time.current <= expires_at
  end

  private

  def billing_frequency_case_insensitive_inclusion
    valid_frequencies = %w[monthly annual]
    unless valid_frequencies.include?(billing_frequency.to_s.downcase)
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
