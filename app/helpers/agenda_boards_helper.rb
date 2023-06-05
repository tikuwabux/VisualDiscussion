module AgendaBoardsHelper
  def speaker_name(opinion)
    speaker = User.find(opinion.user_id)
    speaker.name
  end
end
