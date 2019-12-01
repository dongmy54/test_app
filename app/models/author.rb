# 作家
# name
# age
class Author < ActiveRecord::Base
  has_many :articles


  # 低层缓存
  # 实用于比较耗费的查询
  def level_cache_example
    Rails.cache.fetch self do
      puts '========本次从块中获取'
      self.articles.pluck(:title).join('|')
    end
  end

end
