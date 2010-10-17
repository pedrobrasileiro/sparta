class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :tickets
  
  def project_users
    users
  end
  
  def user
    
  end
    
  def user=(email)
    self.users << User.where('email = ?', email)
  end
end
