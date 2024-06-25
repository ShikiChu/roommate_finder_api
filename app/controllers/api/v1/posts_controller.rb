module Api
  module V1
    class PostsController < ApplicationController
      #  Ensures the user is authenticated for all actions except index and show.
      before_action :authenticate_user!, except: [:index, :show]
      before_action :set_post, only: [:show, :update, :destroy]
      before_action :authorize_user!, only: [:update, :destroy]

      # GET /api/v1/posts
      def index
        @posts = Post.all
        render json: @posts
      end

      # GET /api/v1/posts/:id
      def show
        render json: @post
      end

      # POST /api/v1/posts
      def create
        @post = current_user.posts.new(post_params)
        if @post.save
          render json: { post: @post, message: "Post created successfully" }, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/posts/:id
      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/posts/:id
      def destroy
        @post.destroy
        render json: { message: "Post deleted successfully" }, status: :ok
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:address, :roommates_needed, :rent, :email)
      end

      def authorize_user!
        unless current_user == @post.user
          render json: { error: "You are not authorized to perform this action" }, status: :forbidden
        end
      end
    end
  end
end
