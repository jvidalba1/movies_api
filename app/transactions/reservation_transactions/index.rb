require_relative '../base_transaction.rb'

module ReservationTransactions
  class Index < BaseTransaction
    tee :params
    step :get_reservations

    def params(input)
      params = input.fetch(:params)
      @star_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
    end

    def get_reservations
      @reservations = Reservation.where(date: (@star_date)..(@end_date)).all

      Success(@reservations)
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
