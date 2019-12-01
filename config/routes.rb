Rails.application.routes.draw do
  
  root "articles#index"


  resources :articles do
  end

  resources :authors do
    collection do
      get 'frag_test'  # 片段缓存测试 
      get 'frag_test1' # 
      get 'frag_test2' 
      get 'frag_test3'
      get 'frag_test4'

      get 'russia_cache' # 俄罗斯套娃缓存
      get 'russia_cache1'

      get 'sql_cache' # sql缓存
    end

    member do
      get 'condition_get'  # 条件get缓存
      get 'condition_get1' 
      get 'condition_get2'

      get 'explicit_dependence'  # 显示依赖
      get 'external_dependence' # 外部依赖
    end
  end

end


