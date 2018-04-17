class WhiteboardsController < ApplicationController
    def create
        create_whiteboard(
            name: params.require(:name),
            gui: self,
            repo: Rails.configuration.whiteboard_repo
        )
    end

    def whiteboard_created(id)
        render plain: id
    end

    def validation_failed(errors)
        @errors = errors
        render "validation_failed"
    end
end