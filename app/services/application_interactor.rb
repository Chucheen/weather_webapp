class ApplicationInteractor
  include ::Interactor
  include ::Errors::Formatter
  CONTRACT_CLASS = nil

  private

  def handle_error(error, status = 400)
    return if context.failure?

    context.fail!(error: error, status: status)
  end

  def validate_contract!
    contract = contract_class.new.call(context.params.to_h)
    handle_error(from_contract_to_errors(contract), :unprocessable_entity) if contract.errors.any?
    @validated_params = contract.to_h
  rescue ::Errors::Base => e
    handle_error(e)
  end

  def contract_class
    unless self.class::CONTRACT_CLASS
      raise NotImplementedError, "Please declare CONTRACT_CLASS = 'Your::Contract::Class' on #{self.class} or"\
                                 " overwrite #{self.class}#contract_class"
    end
    self.class::CONTRACT_CLASS
  end

  def validated_params
    if @validated_params.nil?
      raise RuntimeError, 'You should run `validate_contract!` before use `validated_params`'
    end
    @validated_params
  end
end
