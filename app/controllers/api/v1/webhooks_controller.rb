module Api::V1
  class WebhooksController < ApiController
    before_action :set_webhook, only: [:show, :update, :destroy]

    # GET /v1/webhooks
    def index
      @webhooks = Webhook.all

      render json: @webhooks
    end

    # GET /v1/webhooks/1
    def show
      render json: @webhook
    end

    # POST /v1/webhooks
    def create
      @webhook = Webhook.new(webhook_params)

      if @webhook.save
        render json: @webhook, status: :created, location: @webhook
      else
        render json: @webhook.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/webhooks/1
    def update
      if @webhook.update(webhook_params)
        render json: @webhook
      else
        render json: @webhook.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/webhooks/1
    def destroy
      @webhook.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_webhook
        @webhook = Webhook.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def webhook_params
        params.require(:webhook).permit(:project_name, :name, :url)
      end
  end
end
