
# Quiz_App
Flutter quiz aplication with firebase (firestore)

it is a quiz app with firestore. We take all the question , category etc. data from the database.
you shoulld fill  firebase_options.dart with the databse info 

databse model

Kategoriler (Collection)
  |
  |-- <kategori> (Document)
  |     |-- id: <kategori_id> (Field)
  |     |-- name: <kategori_name> (Field)
  |     |-- ikon: <ikon_url> (Field)
  |     |-- altkategori: <altkategori_name> (Field)
  |     |
  |     |-- <altkategori_name> (Subcollection)
  |           |-- soru1 (Document)
  |           |     |-- soru: <soru_metni> (Field)
  |           |     |-- cevap: <doğru_cevap> (Field)
  |           |     |-- seçenekler: [<seçenek1>, <seçenek2>, <seçenek3>, <seçenek4>] (Field)
  |           |
  |           |-- soru2 (Document)
  |           |-- soru3 (Document)
  |           |-- ...
=======

