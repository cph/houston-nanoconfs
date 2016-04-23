module Houston
  module Nanoconfs
    class PresentationsController < ApplicationController
      before_action :set_presentation, only: [:show, :edit, :update]
      before_action :authenticate_presenter, only: [:edit]
      before_action :set_presentations, only: [:index, :new, :edit]
      attr_reader :presentations, :presentation

      layout "houston/nanoconfs/application"

      def index

      end

      def show

      end

      def new
        new_presentation_date = Date.today
        new_presentation_date = params[:date].to_date if params[:date]
        @presentation = Houston::Nanoconfs::Presentation.new(date: new_presentation_date)
        @dropdown_dates = get_dropdown_dates
      end

      def create
        presentation = Houston::Nanoconfs::Presentation.new(presentation_params)
        presentation.presenter = current_user
        if presentation.save
          flash[:notice] = "Presentation Created!"
          Houston.observer.fire "nanoconf:create", presentation
          redirect_to presentation
        else
          flash[:error] = "There was an error saving your presentation"
          redirect_to new_presentation_path
        end
      end

      def edit
        @dropdown_dates = get_dropdown_dates
      end

      def update
        @presentation.presenter = current_user

        if presentation.update_attributes(presentation_params)
          flash[:notice] = "Presentation Updated!"
          Houston.observer.fire "nanoconf:update", presentation
          redirect_to presentation
        else
          flash[:error] = "There was a problem"
        end
      end

      def past_presentations
        @presentations = Houston::Nanoconfs::Presentation.where("date < ?", Date.today)
      end
    private

      def set_presentation
        @presentation = Houston::Nanoconfs::Presentation.find(params[:id])
      end

      def get_dropdown_dates
        @presentations.select do |friday, nanoconf|
          nanoconf.nil? || (params[:action] == "edit" && nanoconf.id == params[:id].to_i)
        end.keys.map { |date| date.strftime("%B %d, %Y") }
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
        permitted_params = params.require(:presentation).permit(:title, :description, :date)
        permitted_params[:date] = permitted_params[:date].to_date
        permitted_params
      end

      def set_presentations
        @presentations = next_six_months.each_with_object({}) do |friday, presentations|
          nanoconf = Houston::Nanoconfs::Presentation.find_by(date: friday)
          presentations[friday] = nanoconf
        end
      end

    end
  end
end
