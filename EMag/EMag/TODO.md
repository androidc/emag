"${PODS_ROOT}/SwiftLint/swiftlint" --config .swiftlint.yml


1. Реализовать получение списка отзывов о товаре.
2. Реализовать добавление отзыва о товаре.
3. Реализовать удаление отзыва.

Примера списка отзывов нет

запрос: 
{
 "id_product": "123"
}
Ответ: 

[
 {
   "id_user": 1,
   "id_comment": 1,
   "text":"Норм товар"
 },
  {
   "id_user": 2,
   "id_comment": 1,
   "text":"Полный отстой"
 }
]

getReviews

