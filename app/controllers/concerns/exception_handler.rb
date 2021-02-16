module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render(
        json: {
          error_type: 'not_found',
          errors: { details: ErrorMessages.record_not_found, model: e.model, id: e.id }
        },
        status: :not_found
      )
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render(
        json: { error_type: 'record_invalid', errors: e.record.errors.messages },
        status: :unprocessable_entity
      )
    end
  end
end