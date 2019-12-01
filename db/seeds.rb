# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Article.destroy_all
Author.destroy_all
puts "======================= 文章 作者全部清空============================"

100.times do
  name = ('a'..'z').to_a.sample(5).join('')
  age = rand(100)

  author = Author.create(name: name, age: age)
  puts "============已创建作者：#{name}================"

  12.times do |i|
    author.articles.create!(title: "#{name}的第#{i}篇文章", content: "#{name}#{i}" * 100)
  end
  puts "============#{name}作者文章创建完成==============="
end

