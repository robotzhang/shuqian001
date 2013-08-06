#coding=utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :username, presence: true, uniqueness: {case_sensitive: false}, :length => {:in => 3..20}
            #:format => {:with => /\A\w+\z/, :message => '只允许数字、大小写字母和下划线'}, :length => {:in => 3..20}

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :avatar, :username
  mount_uploader :avatar, AvatarUploader
  acts_as_commentable
  acts_as_tagger

  has_many :collections

  def has_role?(role)
    self.role == role.to_s
  end
end
