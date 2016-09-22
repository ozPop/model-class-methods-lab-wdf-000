class Boat < ActiveRecord::Base #:nodoc:
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    all.limit(5)
  end

  def self.dinghy
    all.where('length < 20')
  end

  def self.ship
    all.where('length > 20')
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    all.where(captain_id: nil)
  end

  def self.sailboats
    joins(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.boats_by_name(boat_name)
    joins(:classifications).where(classifications: { name: boat_name.to_s.capitalize })
  end

  def self.with_three_classifications
    joins(:boat_classifications).group(:boat_id).having('count(*) = 3')
  end
end
