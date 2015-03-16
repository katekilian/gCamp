class Role < ActiveRecord::Base

  has_many :memberships

  OWNER = 'owner'
  MEMBER = 'member'
  ROLES = [MEMBER, OWNER]

end
