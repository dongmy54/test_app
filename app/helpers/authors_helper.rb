module AuthorsHelper
  
  # 需要显示依赖
  def render_diff_by_age(author)
    if author.age > 14
      render 'big_age'
    else
      render 'small_age'
    end
  end
  
  # 外部依赖
  def some_method
    "<p>你们好呀! haoah</p>".html_safe
  end

end
