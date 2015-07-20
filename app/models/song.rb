class Song < ActiveRecord::Base
  have_many :genres
  belongs_to :bands

   



end
