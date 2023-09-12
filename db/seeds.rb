require 'faker'
include I18n

5.times do |i|
  f_email = Faker::Internet.unique.email
  f_password = '123123123'
  f_tel = Faker::PhoneNumber.phone_number

  f_restaurant_name = Faker::Restaurant.name
  f_address = Faker::Address.full_address
  f_description = Faker::Restaurant.description

  user = User.create!(
    email: f_email,
    password: f_password,
    confirmed_at: Time.now
  )

  restaurant = Restaurant.create(
    name: f_restaurant_name,
    url: f_restaurant_name,
    tel: f_tel,
    address: f_address,
    description: f_description,
    user_id: user.id,
    reserve_interval: 15,
    mealtime: 60,
    bookday_advance: 14
  )

  open_time = OpenTime.create(
    start_time: Time.parse("11:00 AM"),
    end_time: Time.parse("8:00 PM"),
    restaurant_id: restaurant.id
  )

  3.times do |j|
    table = Table.create(
      name: "A#{j + 1}",
      seat_num: rand(2..6),
      status: "vacant",
      category: 1,
      site_x: 1,
      site_y: 1,
      restaurant_id: restaurant.id
    )

    puts "建立使用者 #{i + 1}: #{user.email}、餐廳 #{restaurant.name}、開放時間、休假日和桌子"
  end
end

demo_user = User.create(
  email: 'cookichiban2@gmail.com',
  password: 'cookichiban123',
  confirmed_at: Time.now,
  role: 'super_admin'
)

demo_restaurant = demo_user.restaurants.create(
  user_id: demo_user.id,
  name: "陽泉酒家",
  url: "ichiban2",
  tel: "0228825252",
  address: "台北市中正區衡陽路7號5樓",
  description: "一日，法國大廚巴傑魯造訪廣州並貶低中國料理，憤怒的劉昴星與他進行炒飯對決並擊敗了他，巴傑魯心有不甘、縱火燒燬南鮮酒家。為重建餐館，劉昴星參加廣州餃子大賽取得優勝及獎金，餐館重建更名為陽泉酒家。劉昴星依據餃子大賽評審朗文大師的建議參加特級廚師測驗，他在測驗中結交了與自己水準相當的好對手蘭飛鴻，與他一起通過測驗，成為中國史上最年輕的特級廚師。在測驗中發現自己實力尚淺的劉昴星展開修行，他造訪廣西、貴州及雲南的城鎮精進廚藝，旅途中收了四郎為徒。",
  reserve_interval: 60,
  mealtime: 90,
  bookday_advance: 30
)

demo_opentime = demo_restaurant.open_times.create(
  start_time: Time.parse("11:00 AM"),
  end_time: Time.parse("08:00 PM")
)

demo_table = demo_restaurant.tables.create(
  name: "A1",
  seat_num: 4,
  status: "available",
  category: 1,
  site_x: 1,
  site_y: 1,
  restaurant_id: demo_restaurant.id
)

demo_reservation = demo_restaurant.reservations.create!(
  date: Date.parse("2023-10-10"),
  time: Time.parse("06:00 PM"),
  adults: 2,
  kids: 2,
  purpose: "商業聚餐",
  note: '蛋奶素',
  restaurant_id: demo_restaurant.id,
  name: '解師傅',
  gender: 1,
  tel: '0999999999'
)

demo_reservation_2 = demo_restaurant.reservations.create!(
  date: Date.parse("2023-10-10"),
  time: Time.parse("12:00 PM"),
  adults: 2,
  kids: 0,
  purpose: "慶生",
  note: '當天有壽星',
  restaurant_id: demo_restaurant.id,
  name: '嘟嘟',
  gender: 2,
  tel: '0988888888'
)

puts "已建立使用者小當家"
