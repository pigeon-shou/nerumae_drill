class ReviewType < ActiveHash::Base
  self.data = [
    { id: 1, name: '----'},
    { id: 2, name: '想起' }, 
    { id: 3, name: '理解' },
    { id: 4, name: '応用' }
  ]
  include ActiveHash::Associations
  has_many :reviews
  # 想起というタイプにはたくさんのレビューがつくからhas_many
end