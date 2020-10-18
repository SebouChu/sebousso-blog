module WithUid
  extend ActiveSupport::Concern

  included do
    before_validation :generate_uid, on: :create
  end

  def to_param
    uid
  end

  protected

  def generate_uid
    loop do
      self.uid = random_uid
      break unless uid_exists?(uid)
    end
  end

  # 1 099 511 627 776 possibilities
  def random_uid
    SecureRandom.hex 5
  end

  def uid_exists?(uid)
    self.class.unscoped.where(uid: uid).exists?
  end
end