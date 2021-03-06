require_relative '../base_transaction.rb'

module ReservationTransactions
  class Index < BaseTransaction
    tee :params
    step :get_reservations

    def params(input)
      params = input.fetch(:params)
      @start_date = Date.parse(params[:start_date])
      @end_date = Date.parse(params[:end_date])
    end

    def get_reservations
      @reservations = Reservation.by_date_range(@start_date, @end_date)

      Success(@reservations)
    rescue StandardError => exception
      Failure(error: exception)
    end
  end
end
