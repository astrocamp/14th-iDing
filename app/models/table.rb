class Table < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :seat, presence: true, numericality:{ greater_than: 0}

    enum category: {'一般座位':0, '包廂':1}
end
