class ContractTurn < ApplicationRecord
    belongs_to :user
    belongs_to :game
    has_one :contract
end
