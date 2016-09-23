class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    all
  end

  def self.longest
    Boat.all.order(length: :desc).limit(1).first.classifications
    # joins(:boats).order("length DESC").limit(2)
  end
end
