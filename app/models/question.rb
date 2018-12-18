class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

    def self.search(search)
    if search
      Question.where('(content = ?)', search)
    else
      Question.all
    end
  end
end
