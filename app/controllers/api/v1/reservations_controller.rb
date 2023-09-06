# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController

      before_action :set_reservation, only: [:check_in, :leave, :hold_seat]

      def check_in
        @reservation.use! if @reservation.may_use?
        render json: { newStatus: @reservation.state }
      end

      def leave
        @reservation.complete! if @reservation.may_complete?
        render json: { newStatus: @reservation.state }
      end

      def hold_seat
        @reservation.keep! if @reservation.may_keep?
        render json: { newStatus: @reservation.state }
      end

      private

      def set_reservation
        @reservation = Reservation.find(params[:id])
      end
    end
  end
end
