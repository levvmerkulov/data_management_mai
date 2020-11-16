# hw_5_screenshots

**Подключиться к Mongo из командной строки Linux и загрузить в Mongo текстовый JSON-файл raw_data\tags.json**

Подключение к Mongo и экспорт tags.json извне
> ![](https://i.imgur.com/0LP664n.png)

Проверка новых данных
> ![](https://i.imgur.com/sBgOBof.png)


**Выполнить запросы к Mongo через консоль:**
- подсчитайте число элементов в созданной коллекции tags в bd movies
```
db.tags.find().count()
db.tags.count()
```
> ![](https://i.imgur.com/ABTBduY.png)

- подсчитайте число фильмов с конкретным тегом - Adventure
```
db.tags.find({tag_name: 'Adventure'}).count()
```
> ![](https://i.imgur.com/bHna4ZQ.png)

- используя группировку данных ($group) вывести top-3 самых распространённых тегов

```
db.tags.aggregate([{$group: {_id: "$tag_name", tag_count: { $sum: 1 }}}, {$sort: {tag_count: -1}} , {$limit: 3}])
```
> ![](https://i.imgur.com/VeD8NRI.png)
