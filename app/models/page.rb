class Page < ActiveRecord::Base
    belongs_to :user
    validates :date, uniqueness: {scope: :user}

    after_initialize do |page|
	page.date=Date.today if page.date==nil
    end
end
