class LinksController < ApplicationController
    before_filter :authenticate_user!, except: [:index]

    before_filter :set_collection_id

    def index
        @links = []
        @links.push(OpenStruct.new({id: 73, url: 'http://rodniki.ru/images/test/73.jpg', name: 'Тестовый линк 1'}))
        @links.push(OpenStruct.new({id: 74, url: 'http://rodniki.ru/images/test/74.jpg', name: 'Тестовый линк 2'}))
        @links.push(OpenStruct.new({id: 75, url: 'http://rodniki.ru/images/test/75.jpg', name: 'Тестовый линк 3'}))

        @self_collection = (current_user.present? && (current_user.id.to_i == @collection_id))
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def set_collection_id
        @collection_id = params[:collection_id].to_i
    end
end
