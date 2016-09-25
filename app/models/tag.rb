class Tag 
  include Neo4j::ActiveNode
  property :name, type: String

  id_property :uuid, auto: :uuid

  property :updated_at
  property :created_at


  property :normalized_name, type: String
  validates_presence_of :name
  validate :set_normalized_name

  private
  def set_normalized_name
    self.normalized_name = self.name.downcase if self.name
  end

  public
#  has_many :in, :tagged, type: :CONCEPTUAL_TAG, model_class: :Artefact
  has_many :in, :tagged, type: :CONCEPTUAL_TAG, model_class: :Tag
end

