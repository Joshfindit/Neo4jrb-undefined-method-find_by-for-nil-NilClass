json.extract! note, :id, :name, :content, :tags_id, :absoluteDatetimeOccurredAt, :refersTo_id, :isReferredToBy_id, :created_at, :updated_at
json.url note_url(note, format: :json)