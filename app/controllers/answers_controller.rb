class AnswersController < ApplicationController
	def create
		# Add comment for question with question id and current_user
		@question = Question.find(params[:question_id])
		@answer   = @question.answers.build(answers_params)
		@answer.user = current_user
		# Save answer
		@answer.save

		# Redirect to question page
		redirect_to questions_url
	end	

	def destroy
		@question = Question.find(params[:question_id])
		# Destroy answer
		@answer   = @question.answers.find(params[:id]).destroy
		# Redirect to question page
		redirect_to questions_url
	end

	private
		# Check answer empty client
		def answers_params
			params.require(:answer).permit(:content)
		end
end