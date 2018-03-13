class Challenge < ApplicationRecord

  validates :title, :description, :closing_date, :expiration_date, :block_size, :creator_id, presence: true
  validates :min_honor, :capped, :block_size, numericality: {greater_than_or_equal_to: 0}
  belongs_to :language
  belongs_to :party, foreign_key: 'winner_side_id', optional: true
  belongs_to :creator, class_name: 'Player', foreign_key: 'creator_id'
  has_one :wallet, as: :owner
  has_many :challenge_tags, dependent: :destroy
  has_many :tags, through: :challenge_tags
  has_many :verifiers, dependent: :destroy
  has_many :parties, dependent: :destroy
  accepts_nested_attributes_for :verifiers
  accepts_nested_attributes_for :parties
  mount_uploader :picture, ChallengePictureUploader
  enum status:{
    pending: 0,
    open: 1,
    closed: 2,
    confirming_results: 3,
    on_case: 4,
    archived: 5
  }
  validate :datetime, on: :create

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
        Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  private

  def datetime
    now = DateTime.now
    if expiration_date < now
      errors.add(:expiration_date, "can't be in the past")
    elsif closing_date < now
      errors.add(:closing_date, "can't be in the past")
    elsif expiration_date < closing_date
      errors.add(:expiration_date, "can't occur before the closing date")
    end
  end
end
