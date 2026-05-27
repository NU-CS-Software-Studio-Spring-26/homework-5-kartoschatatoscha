class Todo < ApplicationRecord
  validates :description, presence: true, length: { maximum: 100 }
  validate :description_must_not_include_blocked_terms

  private

  def description_must_not_include_blocked_terms
    return if description.blank?

    normalized_description = description.downcase
    blocked_term = blocked_terms.find { |term| normalized_description.include?(term) }
    return unless blocked_term

    errors.add(:description, "contains blocked content")
  end

  def blocked_terms
    Array(Rails.application.config_for(:blocked_terms)[:terms])
      .map(&:to_s)
      .map(&:downcase)
      .reject(&:blank?)
  end
end
