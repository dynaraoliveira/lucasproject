class EquipamentSerializer < ActiveModel::Serializer
  attributes :id, :chave, :nome, :cidade, :estado
end
