// ФИО: Меркулов Лев Владимирович

// Число элементов в коллекции tags в bd movies 
db.tags.find().count()

db.tags.count()

// Число фильмов с конкретным тегом - Adventure
db.tags.find({tag_name: 'Adventure'}).count()

// top-3 самых распространённых тегов
db.tags.aggregate(
    [
        {
            $group: {
                _id: "$tag_name", 
                tag_count: { $sum: 1 }
            }
        }, 
        {$sort: {tag_count: -1}}, 
        {$limit: 3}
    ]
)