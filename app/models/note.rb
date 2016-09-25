class Note 
  include Neo4j::ActiveNode
  include Neo4jrb::Paperclip

  property :name, type: String
  property :content, type: String
  property :absoluteDatetimeOccurredAt, type: DateTime


  property :normalized_name, type: String
  validates_presence_of :name
  validate :set_normalized_name

  private # Everything below 'private' becomes private, including all instance and class methods
  def set_normalized_name
    self.normalized_name = self.name.downcase if self.name
  end

  public
  has_neo4jrb_attached_file :ingestedFile
  do_not_validate_attachment_file_type :ingestedFile

  has_neo4jrb_attached_file :ingestedFileMetadata
#  validates_attachment_content_type :ingestedFileMetadata, content_type: ["/\Atext\/.*\Z/", "application/json"]
  do_not_validate_attachment_file_type :ingestedFileMetadata

  has_neo4jrb_attached_file :ingestedFileRelationshipList
#  validates_attachment_content_type :ingestedFileRelationshipList, content_type: ["/\Atext\/.*\Z/", "application/json"]
  do_not_validate_attachment_file_type :ingestedFileRelationshipList

  Paperclip.options[:content_type_mappings][:json] = ["application/json", "text/plain"]
  Paperclip.options[:content_type_mappings][:cql] = "text/plain"
  Paperclip.options[:content_type_mappings][:doentry] = "application/xml"


  has_many :out, :tags, rel_class: :Conceptually_Tagged
  has_many :out, :refersTo, type: :REFERS_TO, model_class: false
  has_many :in, :isReferredToBy, type: :REFERS_TO, model_class: false

end


class Conceptually_Tagged
  include Neo4j::ActiveRel
#  before_save :do_this

  from_class :Note
  to_class   :Tag
  type 'CONCEPTUAL_TAG'

  creates_unique :all #only count it as a unique relationship when all properties match (and therefore don't duplicate it)
#  property :since, type: Integer
#  property :grade, type: Integer
#  property :notes

#  validates_presence_of :since

#  def do_this
    #a callback
#  end
end
