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
