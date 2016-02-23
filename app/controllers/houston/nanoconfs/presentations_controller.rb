module Houston
  module Nanoconfs
    class PresentationsController < ApplicationController
      before_action :set_presentation, only: [:show, :edit]
      before_action :authenticate_presenter, only: [:edit]

      attr_reader :presentation

      layout "houston/nanoconfs/application"

      def index
        @presentations = Houston::Nanoconfs::Presentation.where(date: next_six_months).order(:date)
        create_new_nanoconfs if next_six_months.count > @presentations.count
      end

      def show

      end

      def edit

      end

      def update
        @presentation = Houston::Nanoconfs::Presentation.find(params[:id])
        @presentation.presenter = current_user

        if presentation.update_attributes(presentation_params)
          flash[:notice] = "Presentation Updated!"
          Houston.observer.fire "nanoconf:update", @presentation
          redirect_to @presentation
        else
          flash[:error] = "There was a problem"
        end
      end
    private

      def set_presentation
        @presentation = Houston::Nanoconfs::Presentation.find(params[:id])
      end

      def authenticate_presenter
        unless can? :update, @presentation
          flash[:error] = "You are not authorized to edit this presentation"
          redirect_to presentations_path
        end
      end

      def next_six_months
        start_date = Date.today
        end_date = Date.today + 6.months
        my_days = [5] # day of the week in 0-6. Sunday is day-of-week 0; Saturday is day-of-week 6.
        (start_date..end_date).to_a.select {|k| my_days.include?(k.wday)}
      end

      def create_new_nanoconfs
        next_six_months.each do |friday|
          Houston::Nanoconfs::Presentation.find_or_create_by(date: friday)
        end
      end

      def presentation_params
        params.require(:presentation).permit(:title, :description)
      end

    end
  end
end
