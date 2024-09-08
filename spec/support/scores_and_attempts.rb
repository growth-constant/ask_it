# frozen_string_literal: true

module Support
  module ScoresAndAttempts
    def number_of_current_attempts(participant, survey)
      participant.for_survey(survey).size if participant.respond_to?(:for_survey)
    end

    def participant_score(user, survey)
      survey.attempts.for_participant(user).high_score
    end

    def participant_with_more_right_answers(survey)
      survey.attempts.scores.first.participant
    end

    def participant_with_more_wrong_answers(survey)
      survey.attempts.scores.last.participant
    end
  end
end
