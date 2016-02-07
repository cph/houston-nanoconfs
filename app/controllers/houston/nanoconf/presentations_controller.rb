module Houston
  module Nanoconf
    class PresentationsController < ApplicationController
      before_action :set_presentation, only: [:show, :edit]
      attr_reader :presentation

      layout "houston/nanoconf/application"

      def index
        @presentations = Houston::Nanoconf::Presentation.where(date: next_six_months).order(:date)
        create_new_nanoconfs if next_six_months.count > @presentations.count
      end

      def show

      end

      def edit

      end

      def update
        @presentation = Houston::Nanoconf::Presentation.find(params[:id])

        attributes = params.pick(:title, :description)
        @presentation.presenter = current_user
        if presentation.update_attributes(attributes)
          flash[:notice] = "Presentation Updated!"
          redirect_to @presentation
        else
          flash_message[:error] = "There was a problem"
        end
      end
    private

      def set_presentation
        @presentation = Houston::Nanoconf::Presentation.find(params[:id])
      end

      def next_six_months
        start_date = Date.today
        end_date = Date.today + 6.months
        my_days = [5] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
        (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
      end

      def create_new_nanoconfs
        next_six_months.each do |friday|
          Houston::Nanoconf::Presentation.find_or_create_by(date: friday)
        end
      end
    end
  end
end
