class Article < ApplicationRecord
  include WithUid

  belongs_to :author, class_name: 'User', counter_cache: true

  before_validation :sanitize_fields

  validates :title, :published_at, presence: true

  after_save_commit :denormalize_search, if: :should_denormalize_search?

  scope :ordered, -> { order(pinned: :desc, published_at: :desc, updated_at: :desc) }
  scope :search, -> (term) { where("unaccent(#{table_name}.search) ILIKE unaccent(?)", "%#{sanitize_sql_like(term)}%") }
  scope :published_in_the_past, -> { where("published = true AND published_at <= ?", DateTime.now) }

  def to_s
    "#{title}"
  end

  def excerpt
    strip_tags(content&.gsub(/<\/[a-z0-9]+>/, ' \1'))&.squish&.truncate(150, separator: ' ')&.html_safe
  end

  private

  def sanitize_fields
    self.title = Sanitizer.sanitize(title, 'string')
    self.content = Sanitizer.sanitize(content, 'text')
  end

  def denormalize_search
    update_column :search, "#{title} #{strip_tags(content)}"
  end

  def should_denormalize_search?
    # Looks for searchable attributes' keys in last save's changes.
    (saved_changes.keys & ['title', 'content']).any?
  end
end
