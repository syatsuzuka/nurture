module TargetHelper
  def show_score_type(target)
    return t('label.form.score_float') if target.score_type == "float"
    return t('label.form.score_integer') if target.score_type == "integer"
    return t('label.form.score_boolean') if target.score_type == "boolean"
  end

  def show_target_score(target)
    case target.score_type
    when "boolean"
      if target.score.positive?
        return t('label.progress.score_true')
      else
        return t('label.progress.score_false')
      end
    when "integer"
      return target.score.floor
    else
      return target.score
    end
  end

  def show_score(progress)
    case progress.target.score_type
    when "boolean"
      if progress.score.positive?
        return t('label.progress.score_true')
      else
        return t('label.progress.score_false')
      end
    when "integer"
      return progress.score.floor
    else
      return progress.score
    end
  end
end
