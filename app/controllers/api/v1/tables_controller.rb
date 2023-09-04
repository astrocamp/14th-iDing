# frozen_string_literal: true

module Api
  module V1
    class TablesController < ApplicationController
      before_action :set_table, only: [:update_position]

      def update_position
        new_site_x = params[:site_x]
        new_site_y = params[:site_y]

        if @table.update(site_x: new_site_x, site_y: new_site_y)
          render json: { message: '位置已更新' }, status: :ok
        else
          render json: { error: '無法更新位置' }, status: :unprocessable_entity
        end
      end

      private

      def set_table
        @table = Table.find(params[:id])
      end
    end
  end
end
