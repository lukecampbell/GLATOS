class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :organization, :password, :password_confirmation, :remember_me, :role, :requested_role, :approved

  validates_presence_of :name, :email
  validates_uniqueness_of :name, :email, :case_sensitive => false

  ROLES = %w[guest public researcher investigator admin]
  REGISTERABLE_ROLES = ROLES - %w[guest]
  ROLE_MAP = {
    :guest => "Unregistered visitor to the site",
    :public => "Registered user of the GLATOS website",
    :researcher => "Researcher interested in GLATOS data",
    :investigator => "Contributor to the GLATOS database",
    :admin => "Administrator of the GLATOS website"
  }

  def DT_RowId
    self.id
  end

  def approve!
    self.approved = true
    self.save!
  end

  # Accounts need to be approved
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    if !approved?
      I18n.t("devise.failure.not_approved")
    else
      super # Use whatever other message
    end
  end

  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved? && recoverable.errors.blank?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end

end
# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null, indexed
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)     indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)     indexed
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :string(255)
#  approved               :boolean         default(FALSE), not null, indexed
#  name                   :string(255)
#  organization           :string(255)
#  requested_role         :string(255)
#

