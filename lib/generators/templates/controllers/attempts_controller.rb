class <%= get_scope.capitalize %>::AttemptsController < AskIt::AttemptsController 
  # GET /resource/attempts/new
  # def new
  #   @survey =  AskIt::Survey.active.last
  #   @attempt = @survey.attempts.new
  #   @attempt.answers.build
  #   @participant = current_user # you have to decide what to do here
  # end

  # POST /resource/attempts
  # def create
  #   @survey = AskIt::Survey.active.last
  #   @attempt = @survey.attempts.new(attempt_params)
  #   @attempt.participant = current_user  # you have to decide what to do here
  #   if @attempt.valid? and @attempt.save
  #     redirect_to view_context.new_attempt_path, alert: I18n.t("attempts_controller.#{action_name}")
  #   else
  #     flash.now[:error] = @attempt.errors.full_messages.join(', ')
  #     render :action => :new
  #   end
  # end
end