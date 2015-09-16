module Joinable
  extend ActiveSupport::Concern

  class JoinableModelMustImplement; end

  included do
    has_many :memberships, as: :joinable
    has_many :users, through: :memberships
  end

  def admin?
    fail JoinableModelMustImplement
  end

  def member?
    fail JoinableModelMustImplement
  end

  def contains?(user)
    admin?(user) || member?(user)
  end
end
