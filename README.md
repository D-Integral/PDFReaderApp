Завдання: реалізувати додавання pdf файлів зі своїх документів у додаток і зберігання їх локально, а також перегляд файлу з використанням PDFKit. Додати логін через Google за допомогою FirebaseAuth.

Логіка: при натисканні на кнопку “+” відкривається UIDocumentPickerViewController, де ми можемо вибрати PDF-файл і зберегти у наш застосунок. На екрані “My Files” при натисканні на файл ми переходимо на інший екран, у якому можемо переглянути цей PDF-документ. Якщо натиснути “...”, яке знаходиться у cell, то відкривається модальне вікно знизу у якому при натисканні на “Delete” ми видаляємо файл. При написанні тексту у search bar відбувається фільтрація файлів на збіг з назвою.

Важливі деталі:
1. Зображення у cell повинно бути мініатюрою першої сторінки PDF-документа.
2. Буде плюсом використання Diffable Data Source для роботи з Collection View.
3. UI має бути описаний в коді, за допомогою Auto Layout. Без використання Storyboard.