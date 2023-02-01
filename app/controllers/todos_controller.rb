class TodosController < ApplicationController
  before_action :set_todo, only: %i[ show update destroy NzPatch ]

  # GET /todos
  def index
    @todos = Todo.all

    @todos = @todos.sort_by(&:currentIndex)

    render json: @todos
  end

  # GET /todos/1
  def getByCategory
    category = Category.find(params[:id])
    todos = category.todos
    todos = todos.order(:currentIndex)

    render json: todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos 
  # @book = @author.books.create(published_at: Time.now)
  def create
    @thisIndex = 0
    if Todo.all.length > 0
      @lastIndex = Todo.last.currentIndex
      @thisIndex = @lastIndex + 1
    end
    # @todo = Todo.new(todo_params)
    @todo = Category.find(todo_params["category_id"]).todos.create({"currentIndex": @thisIndex, "content": todo_params["content"] })
    # @todo = Category.todos.create({"currentIndex": @thisIndex, "content": todo_params["content"] })

    if @todo.save
      render json: @todo, status: :created, location: @todo
      # render json: @newParams
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  # Updates the current Index in the drag and drop
  def update
    @todos = Todo.all
    flag = 0
    @todos = @todos.sort_by(&:currentIndex)

    @todos.each do |todo|
      if todo == @todo
        todo.update({"currentIndex": todo_params["currentIndex"]})
      else
        if flag == todo_params["currentIndex"]
          flag = flag + 1
        end
        todo.update({"currentIndex": flag })
        flag = flag + 1
      end
    end

    # if @todo.update(todo_params)
    #   puts "HELLO"
    #   render json: @todo
    # else
    #   render json: @todo.errors, status: :unprocessable_entity
    # end
  end

  def NzPatch
      # if @todo.update(todo_params)
      if Category.first.todos.find(params[:id]).update({"content": todo_params["content"]})
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:content, :currentIndex, :currentInteger, :category_id)
    end
end
