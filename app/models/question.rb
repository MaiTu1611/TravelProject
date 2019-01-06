class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

    def self.search(search)
    if search
      Question.where("questions.content LIKE ?", "%#{search}%")
    else
      Question.all
    end
  end
end
