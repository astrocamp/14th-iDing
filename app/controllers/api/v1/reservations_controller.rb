# frozen_string_literal: true

module Api
  module V1
    class ReservationsController < ApplicationController
      def check_in
        @reservation = Reservation.find(params[:id])
        @reservation.use! if @reservation.may_use?
        render json: { newStatus: @reservation.state }
      end

      def leave
        @reservation = Reservation.find(params[:id])
        @reservation.complete! if @reservation.may_complete?
        render json: { newStatus: @reservation.state }
      end

      def hold_seat
        @reservation = Reservation.find(params[:id])
        @reservation.keep! if @reservation.may_keep?
        render json: { newStatus: @reservation.state }
      end
    end
  end
end
