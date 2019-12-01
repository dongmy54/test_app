# 文章
# author_id
# title
# content
class Article < ActiveRecord::Base
  belongs_to :author, touch: true # 一定要加 俄罗斯套娃缓存
end


