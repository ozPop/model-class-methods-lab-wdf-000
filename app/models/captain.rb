class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # Solution v1 using helper method in Boat class
    boats = Boat.boats_by_name('catamaran')
    captain_ids = boats.map(&:captain_id)
    where(id: captain_ids)

    # Solution v2 using raw SQL statements

    # joins("
    #   INNER JOIN boats
    #     ON boats.captabin_id = captains.id
    #   INNER JOIN boat_classifications
    #     ON boat_classifications.boat_id = boats.id
    #   INNER JOIN classifications
    #     ON classifications.id = boat_classifications.classification_id
    #   ").where(classifications: { name: 'Catamaran' })

    # Soluton v3 using AR joins
    # duplicated hey in hash
    # joins(boats: :boat_classifications, boats: :classifications).where(classifications: { name: 'Catamaran' })
  end

  def self.sailors
    # Solution v1 using helper method in Boat class

    # boats = Boat.sailboats
    # captain_ids = boats.map(&:captain_id)
    # where(id: captain_ids)

    # Solution v2 using includes & Left outer Join

    # includes(boats: :classifications).where(classifications:
    # {
    #   name: 'Sailboat'
    # }).distinct

    # Solution v3 using joins & Inner Join

    joins(boats: :classifications).where(classifications:
    {
      name: 'Sailboat'
    }).distinct
  end

  def self.talented_seamen

  end
end
