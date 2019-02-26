class SubscribersController < ApplicationController

    rescue_from Exception do |e|
        render json: {error: e.message}, status: :internal_error
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: {error: e.message}, status: :unprocessable_entity
    end

    def index
        @subscribers = Subscriber.all
        render json: @subscribers, status: :ok
    end

    def create 
        @subscribers = Subscriber.create!(create_params)
        render json: @subscriber, status: :created
    end

    private

    def create_params
        params.requiere(:subscriber).permit(:name, :phone, :email)
    end
end
