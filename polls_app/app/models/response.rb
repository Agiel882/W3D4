class Response < ApplicationRecord

  validate :validate_resopndent_answered
  validate :validate_author


  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"
  
  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question = self.question
    question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.pluck(:user_id).include?(self.user_id)
  end

  def validate_resopndent_answered
    if respondent_already_answered?
      errors[:already_answered] << "Already answered!"
    end
  end

  def respondent_is_author?
    poll = self.question.poll 
   self.user_id == poll.user_id
  end

  def validate_author
    if respondent_is_author?
      errors[:fraud] << "Author cannot answer"
    end
  end

end
