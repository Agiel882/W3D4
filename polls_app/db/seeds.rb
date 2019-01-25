# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do 
  User.destroy_all
  Poll.destroy_all
  Question.destroy_all
  AnswerChoice.destroy_all
  Response.destroy_all

  aram = User.create!(username: "Aram")
  nick = User.create!(username: "Nick")
  
  poll_one = Poll.create!(user_id: aram.id, title: "Favorite Animal?")

  question_one = Question.create!(text: "Do you like tigers?", poll_id: poll_one.id)
  question_two = Question.create!(text: "Do you like lions?", poll_id: poll_one.id)

  answer_one = AnswerChoice.create!(question_id: question_one.id, text: "Yes")
  answer_two = AnswerChoice.create!(question_id: question_one.id, text: "No")
  answer_three = AnswerChoice.create!(question_id: question_two.id, text: "Yes")
  answer_four = AnswerChoice.create!(question_id: question_two.id, text: "No")
  
  response_aram = Response.create!(user_id: aram.id, answer_choice_id: answer_one.id)
  response_aram_2 = Response.create!(user_id: aram.id, answer_choice_id: answer_four.id)


end