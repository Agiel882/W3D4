class Question < ApplicationRecord
  validates :text, presence: true

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "AnswerChoice"
  
  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: "Poll"

  has_many :responses,
    through: :answer_choices,
    source: :responses
  
    def results_crappy
      res = Hash.new(0)
      self.answer_choices.each do |answer|
        res[answer.text] = answer.responses.count
      end
      res
    end
    
    def results_still_crappy 
      res = Hash.new(0)
      answers = self.answer_choices.includes(:responses)
      answers.each do |answer|
        res[answer.text] = answer.responses.count
      end
      res
    end
    
    def results
      self.answer_choices.select('answer_choices.*, COUNT(answer_choices.id) AS count').left_outer_joins(:responses).group(:id)
    end


end
