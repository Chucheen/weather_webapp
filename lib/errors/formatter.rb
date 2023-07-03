module Errors
  module Formatter
    def to_error(detail, source)
      { detail: detail, source: source }
    end

    def from_contract_to_errors(contract)
      return if contract.nil? || contract.errors.blank?

      contract.errors.messages.map { to_error(_1.text, _1.path.last) }
    end
  end
end