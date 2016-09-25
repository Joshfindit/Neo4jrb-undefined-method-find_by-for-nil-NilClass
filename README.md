# README

To reproduce the issue:

- Clone the repo
- Make/modify config/neo4j.yml

.. etc ..

- Load up http://127.0.0.1:3000/notes
- Create a new note
- Submit

*Error happens here*

`undefined method `find_by' for nil:NilClass`


To resolve, simply change `model_class: false` to `model_class: :Note` on `refersTo` and `isReferredToBy` (The 'working' branch demonstrates this)


